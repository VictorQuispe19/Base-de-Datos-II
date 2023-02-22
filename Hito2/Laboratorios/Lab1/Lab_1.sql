show databases;

CREATE DATABASE hito_2;

Create database ejemplo;

Drop database ejemplo;

USE hito_2;

drop database hito_2;

CREATE TABLE BaseDatosII
(id_estudiante varchar(50) primary key not null,
nombre_estudiante varchar(100) not null);

insert into BaseDatosII
    Values("BDA-111","Victor Quispe");

insert into BaseDatosII
    Values("BDA-112","Juan Perez");

select *
From BaseDatosII;

CREATE DATABASE universidad;
use universidad;

create table estudiantes(
    id_est integer auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    edad integer not null,
    fono integer not null,
    email varchar(50) not null
);
describe estudiantes;

Insert into estudiantes(nombres, apellidos, edad, fono, email) values
    ("nombre1","apellido1",20,73205056,"email1"),
    ("nombre2","apellido2",19,78945622,"email2"),
    ("nombre3","apellido3",21,65489744,"email3");

SELECT *
from estudiantes

alter table estudiantes
    add column direccion varchar(200) not null
default "El Alto" ;


