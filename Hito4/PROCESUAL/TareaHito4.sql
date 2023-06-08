CREATE DATABASE tareaHito4;
Use tareaHito4;

CREATE TABLE proyecto(id_proy int auto_increment PRIMARY KEY ,
nombreProy varchar(100),
tipoProy VARCHAR(30));

CREATE TABLE departamento(id_dep int auto_increment PRIMARY KEY ,
nombre VARCHAR(50));

CREATE TABLE provincia(id_prov int auto_increment PRIMARY KEY ,
nombre varchar(50),
id_dep int,
FOREIGN KEY (id_dep)REFERENCES departamento(id_dep));

CREATE TABLE persona(id_per int auto_increment PRIMARY KEY ,
nombre varchar(20),
apellidos varchar(50),
fecha_nac DATE,
edad int,
email varchar(50),
id_dep int,
id_prov int,
sexo CHAR,
FOREIGN KEY (id_dep)REFERENCES departamento(id_dep),
FOREIGN KEY (id_prov)REFERENCES provincia(id_prov));

CREATE TABLE detalle_proyecto(id_dp int auto_increment PRIMARY KEY ,
id_per int,
id_proy int,
FOREIGN KEY (id_per)REFERENCES persona(id_per),
FOREIGN KEY (id_proy)REFERENCES proyecto(id_proy));

INSERT INTO proyecto(nombreProy, tipoProy) VALUES
('Cuidado Ambiental','Forestacion'),
('Musica Precolombina','Cultura');

INSERT INTO departamento(nombre)VALUES
('La Paz'),
('Cochabamba');

INSERT INTO provincia(nombre, id_dep) VALUES
('Murillo',1),
('Campero',2);

INSERT INTO persona(nombre, apellidos, fecha_nac, edad, email, id_dep, id_prov, sexo) VALUES
('Pepito','Perez','2000-10-10',23,'pepito@gmail.com',2,2,'M'),
('Fernanda','Choque','2002-03-02',21,'fernanda@gmail.com',1,1,'F');

INSERT INTO detalle_proyecto(id_per, id_proy) VALUES
(2,1),
(1,2);

# SUma numeros fibonacci
CREATE FUNCTION fibonacci(numero int)
RETURNS TEXT
BEGIN
    DECLARE num1 int default 0;
    DECLARE num2 int default 1;
    DECLARE num3 int default 0;
    DECLARE cont int default 0;
    DECLARE resp text default '';
    SET resp=CONCAT(num1,',',num2);
    SET cont=2;
    WHILE cont<numero do
        SET num3=num1+num2;
        SET num1=num2;
        SET num2=num3;
        SET resp=CONCAT(resp,',',num3);
        SET cont=cont+1;
        end while;
    return resp;
end;

SELECT fibonacci(6);

CREATE OR REPLACE FUNCTION sumaFibonacci(fibo text)
RETURNS int
BEGIN
    DECLARE resultado int default 0;
    DECLARE serie TEXT;
    DECLARE aux INT;
    WHILE fibo!=''DO
        SET aux =LOCATE(',',fibo);
        IF aux=0 THEN
            SET serie=fibo;
            SET fibo='';
            ELSE
            SET serie=SUBSTRING(fibo,1,aux-1);
            SET fibo=SUBSTRING(fibo,aux+1);
        end if;
        SET resultado=resultado+CAST(serie as int);
        end while;
    RETURN resultado;
end;

SELECT sumaFibonacci(fibonacci(6));
# Manejo de vistas
CREATE OR REPLACE VIEW informacion AS
    SELECT CONCAT(per.nombre,'-',per.apellidos)AS Full_Name,
           per.edad as EDAD, per.fecha_nac AS Fecha_Nac, proy.nombreProy AS Nombre_Proyecto
    FROM persona as per
    INNER JOIN detalle_proyecto as dp on per.id_per = dp.id_per
    INNER JOIN departamento as dep on per.id_dep = dep.id_dep
    INNER JOIN proyecto as proy ON dp.id_proy = proy.id_proy
    WHERE per.fecha_nac='2000-10-10' AND per.sexo='F' AND dep.id_dep=1;
#Manejo de triggers 1

CREATE OR REPLACE TRIGGER estructuraProy
    BEFORE INSERT
    on proyecto
    for each row
    BEGIN
        DECLARE proy int default char_length(New.nombreProy);
        IF(proy<20)THEN
            SET NEW.tipoProy=CONCAT(NEW.tipoProy,'-Titulo corto');
            else
            SET NEW.tipoProy=CONCAT(NEW.tipoProy,'-Titulo Amplio');
        end if;
    end;

CREATE OR REPLACE TRIGGER pagProy
    BEFORE UPDATE
    on proyecto
    for each row
    BEGIN
        IF(OLD.tipoProy!=NEW.tipoProy)THEN
            SET NEW.tipoProy=CONCAT(SUBSTRING(NEW.tipoProy,1,3),'-',NEW.tipoProy);
        end if;
    end;

ALTER TABLE proyecto ADD COLUMN estado varchar(50);

CREATE OR REPLACE TRIGGER estadoProy
    BEFORE INSERT
    on proyecto
    for each row
    BEGIN
        DECLARE est text default '';
        If(NEW.tipoProy='EDUCACION')OR (NEW.tipoProy='FORESTACION') OR(NEW.tipoProy='CULTURA') THEN
            SET NEW.estado='ACTIVO';
            ELSE
            SET NEW.estado='INACTIVO';
        end if;
    end;
# Manejo de Triggers 2

CREATE OR REPLACE TRIGGER calculaEdad
    BEFORE INSERT
    on persona
    for each row
    BEGIN
        SET NEW.edad=TIMESTAMPDIFF(year,NEW.fecha_nac,curdate());
    end;
# Manejo de Triggers 3

CREATE TABLE personaV2(
nombre varchar(20),
apellidos varchar(50),
fecha_nac DATE,
edad int,
email varchar(50),
id_dep int,
id_prov int,
sexo CHAR,
FOREIGN KEY (id_dep)REFERENCES departamento(id_dep),
FOREIGN KEY (id_prov)REFERENCES provincia(id_prov));

CREATE OR REPLACE TRIGGER copiarPersona
    BEFORE insert
    on persona
    for each row
    BEGIN
        INSERT INTO personaV2(nombre, apellidos, fecha_nac, edad, email, id_dep, id_prov, sexo)
        SELECT NEW.nombre,NEW.apellidos,NEW.fecha_nac,NEW.edad,NEW.email,NEW.id_dep,NEW.id_prov,NEW.sexo;
    end;

SELECT *FROM personaV2;

CREATE OR REPLACE VIEW informacionGeneralPersona AS
    SELECT CONCAT(per.nombre,'-',per.apellidos)as FULL_NAME, dep.nombre as Nombre_DEPARTAMENTO,
           prov.nombre as Nombre_PROVINCIA,dp.id_dp as Detalle_Proyecto, proy.nombreProy as Nombre_proyecto
    FROM persona as per
    INNER JOIN departamento as dep on per.id_dep=dep.id_dep
    INNER JOIN provincia as prov on dep.id_dep = prov.id_dep
    INNER JOIN detalle_proyecto dp on per.id_per = dp.id_per
    INNER JOIN proyecto proy on dp.id_proy = proy.id_proy
    WHERE proy.tipoProy='FORESTACION' and dp.id_proy='1';
