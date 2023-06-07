create database hito4_2023;
use hito4_2023;

# son programas almacenados que se ejecutan automaticamente
# INSERT UPDATE DELETE son EVENTOS

# create trigger CalculaCuadradoRaiz
# before INSERT
# on numeros
# for each row
# begin
# Set new.cuadrado=Power(NEW.numero,2)
# Set new.Cubo=Power(new.numero,3)
# SET new.raiz=sqrt(new.numero)
# END

CREATE TABLE numeros
(
    numero        bigint PRIMARY KEY not null,
    cuadrado      bigint,
    cubo          bigint,
    raiz_cuadrada REAL
);

ALTER TABLE numeros add column suma_total REAL;

create or replace trigger CompletaDatos
before INSERT
on numeros
for each row
    begin
        DECLARE valor_cuadrado bigint;
        DECLARE valor_cubo bigint;
        DECLARE valor_raiz REAL;
        DECLARE suma REAL;

        Set valor_cuadrado=Power(NEW.numero,2);
        Set valor_cubo=Power(new.numero,3);
        SET valor_raiz=sqrt(new.numero);
        SET suma=valor_raiz+valor_cubo+valor_cuadrado+new.numero;

        SET NEW.cuadrado=valor_cuadrado;
        SET NeW.cubo=valor_cubo;
        SET NEW.raiz_cuadrada=valor_raiz;
        SET NEW.suma_total =suma;
END;
INSERT INTO numeros(numero)VALUES (2);
SELECT *
FROM numeros;

create or replace trigger GenerarPassword
before INSERT
on usuarios
for each row
    begin
        DECLARE nombre varchar(50);
        DECLARE apellido varchar(50);
        DECLARE pass text default '';

        Set nombre=substring(NEW.nombres,1,2);
        Set apellido=substring(NEW.apellidos,1,2);
        SET pass=CONCAT(nombre,apellido,NEW.edad);

        SET NEW.password =pass;
END;

# no se puede modificar un registro desde un trigger
# Cuando se esta insertando
create or replace trigger GenerarPasswordV1
after INSERT
on usuarios
for each row
    begin
        UPDATE usuarios SET password=CONCAT(SUBSTRING(NEW.nombres,1,2),
            SUBSTRING(NEW.apellidos,1,2),NEW.EDAD)
        WHERE id_usuario=last_insert_id();
END;

CREATE TABLE usuarios(id_usuario int auto_increment primary key,
nombres varchar(20)not null,
apellidos varchar(20)not null,
fecha_nac DATE not null,
correo varchar(100)not null,
password  varchar(100),
edad int);

CREATE OR REPLACE TRIGGER generarDatos
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        SET NEW.password=LOWER(CONCAT(SUBSTRING(NEW.nombres,1,2),
            SUBSTRING(NEW.apellidos,1,2),SUBSTRING(NEW.correo,1,2)));
        SET NEW.edad=TIMESTAMPDIFF(year,NEW.fecha_nac,CURDATE());

    end;

Insert Into usuarios(nombres,apellidos,fecha_nac,correo)VALUES
('Victor','Quispe','1998-11-19','vico@gmail.com'),
('Richard','Perez','1999-07-18','richard@gmail.com');

SELECT CURDATE();
SELECT TIMESTAMPDIFF(YEAR,'1998-11-19',CURDATE());
SELECT SUBSTR('VICTOR',-2);
SELECT CHAR_LENGTH('Victor');

# CREAR UN TRIGGER PARA LA TABLA
# VERIFICAR SI EL PASSWORD TIENE MAS DE 10 CARACTERES
# Si TIENE 10 CARACTERES O MAS DEJAR EL VALOR COMO ESTA
# Caso CONTRARIO GENERAR EL PASSWORD
# TOMAR LOS ULTIMOS 2 CARACTERES DEL NOMBRE APELLIDO Y LA EDAD

CREATE OR REPLACE TRIGGER generarDatosV2
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        DECLARE pass int default CHAR_LENGTH(NEW.password);
        SET NEW.edad=TIMESTAMPDIFF(year,NEW.fecha_nac,CURDATE());
        IF (pass<10)THEN
        SET NEW.password=LOWER(CONCAT(SUBSTRING(NEW.nombres,-2),
        SUBSTRING(NEW.apellidos,-2),NEW.edad));
        end if;
    end;

Insert Into usuarios(nombres,apellidos,fecha_nac,correo,password)VALUES
('Maria','Gomez','2002-08-19','mari@gmail.com','pasodas');
SELECT * FROM  usuarios;

SELECT DAYNAME('2023-05-24');

CREATE OR REPLACE TRIGGER tr_usuarios_mantenimiento
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        DECLARE dia_semana text default '';
        SET dia_semana=DAYNAME('2023-05-24');
        if (dia_semana='Wednesday')Then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Base de Datos en mantenimiento';
        end if;
    end;

ALTER TABLE usuarios ADD COLUMN nacionalidad varchar(20);

CREATE OR REPLACE TRIGGER tr_usuarios_nacionalidad
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        DECLARE nacio text ;
        SET nacio=NEW.nacionalidad;
        if nacio='Bolivia'or nacio='Argentina' or nacio='Paraguay' THEN
            SET NEW.nacionalidad=nacio;
            ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Nacionalidad no disponible en este momento';
        end if;
    end;

INSERT INTO usuarios (nombres, apellidos, fecha_nac, correo, password,nacionalidad) VALUES
('Maria','Gomez','2002-08-19','mari@gmail.com','pasodas','Argentina');

INSERT INTO usuarios (nombres, apellidos, fecha_nac, correo, password,nacionalidad) VALUES
('Maria','Gomez','2002-08-19','mari@gmail.com','pasodas','Mexico');

SELECT *FROm usuarios;

# auditoria de base de datos

CREATE TABLE usuarios_rrhh(id_usuario int primary key not null ,
full_name varchar(50)not null,
fecha_nac DATE not null,
correo varchar(100)not null,
password  varchar(100));

insert into usuarios_rrhh(id_usuario, full_name, fecha_nac, correo, password) VALUES
(123456,'William Barra','1990-01-01' ,'william@gmail.com','123456');
select *from usuarios_rrhh;
# Me permite saber la fecha y hora actual
SELECT now();
Select current_date;
# me permite mantener el usuario loggeado
SeLECT USER();
# Me permite sabe el HOSTNAME
SELECT @@HOSTNAME;
# Todas las variables del BDA
Show VARIABLES;

CREATE TABLE audit_usuarios_rrhh(
    fecha_mod TEXT NOT NULL,
    usuario_log TEXT NOT NULL ,
    hostname TEXT NOT NULL,
    accion TEXT not null,

    id_usuario text NOT NULL,
    full_name TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE OR REPLACE TRIGGER tr_audit_usuarios
    AFTER DELETE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE id_usr text;
        DECLARE nombre text;
        DECLARE pass TEXT;
        SET id_usr=OLD.id_usuario;
        SET nombre=OLD.full_name;
        SET pass=OLD.password;
        INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, id_usuario, full_name, password)
            SELECT NOW(),user(),@@HOSTNAME,'DELETE',id_usr,nombre,pass;
    end;

insert into usuarios_rrhh(id_usuario, full_name, fecha_nac, correo, password) VALUES
(123457,'Pepito Lopez','1992-03-03' ,'pepolol@gmail.com','123456');
SELECT *FROM audit_usuarios_rrhh;
select *from usuarios_rrhh;

CREATE OR REPLACE TRIGGER tr_audit_usuariosV1
    after INSERT
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, id_usuario, full_name, password)
            SELECT NOW(),user(),@@HOSTNAME,'INSERT',NEW.id_usuario,NEW.full_name,NEW.password;
    end;

CREATE TABLE audit_usuarios_rrhh(
    fecha_mod TEXT NOT NULL,
    usuario_log TEXT NOT NULL ,
    hostname TEXT NOT NULL,
    accion TEXT not null,

    antes_del_cambio TEXT NOt NULL,
    despues_del_cambio TEXT NOT NULL
);

CREATE OR REPLACE TRIGGER tr_audit_usuarioV2
    AFTER UPDATE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE antes_cambio text DEFAULT '';
        DECLARE despues_cambio text Default '';
        SET antes_cambio=CONCAT(OLD.id_usuario,OLD.full_name,OLD.fecha_nac);
        SET despues_cambio=CONCAT(OLD.id_usuario,NEW.full_name,NEW.fecha_nac);
        INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, antes_del_cambio, despues_del_cambio)
            SELECT NOW(),USER(),@@HOSTNAME,'UPDATE',antes_cambio,despues_cambio;
    end;
SELECT *FROM audit_usuarios_rrhh;
select *from usuarios_rrhh;

CREATE PROCEDURE inserta_datos(fecha text, usuario text, hostn text,acc text, antes text,despues text)
BEGIN
    INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, antes_del_cambio, despues_del_cambio)
            Values (fecha,usuario,hostn,acc,antes,despues);
end;

CREATE OR REPLACE TRIGGER tr_audit_usuarioV2
    AFTER UPDATE
    ON usuarios_rrhh
    FOR EACH ROW
    BEGIN
        DECLARE antes_cambio text DEFAULT '';
        DECLARE despues_cambio text Default '';
        SET antes_cambio=CONCAT(OLD.id_usuario,OLD.full_name,OLD.fecha_nac);
        SET despues_cambio=CONCAT(OLD.id_usuario,NEW.full_name,NEW.fecha_nac);
        CALL inserta_datos(now(),user(),@@HOSTNAME,'UPDATE',antes_cambio,despues_cambio);
    end;




