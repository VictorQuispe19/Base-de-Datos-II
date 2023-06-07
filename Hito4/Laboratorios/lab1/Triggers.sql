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
CREATE TABLE usuarios(id_usuario int auto_increment primary key,
nombres varchar(50)not null,
apellidos varchar(50)not null,
edad int not null,
correo varchar(30)not null,
password  varchar(100));
SELECT SUBSTRING('Victor',1,2)

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

Insert Into usuarios(nombres,apellidos,edad,correo)VALUES
('Victor','Quispe',22,'vico@gmail.com');
TRUNCATE TABLE usuarios
SELECT * FROM usuarios

create or replace trigger GenerarPasswordV1
before INSERT
on usuarios
for each row
    begin
        SET NEW.password=CONCAT(SUBSTRING(NEW.nombres,1,2),
            SUBSTRING(NEW.apellidos,1,2),NEW.EDAD);
END;