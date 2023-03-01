# show databases;
#
# CREATE DATABASE hito_2;
#
# Create database ejemplo;
#
# Drop database ejemplo;
#
# USE hito_2;
#
# drop database hito_2;
#
# CREATE TABLE BaseDatosII
# (id_estudiante varchar(50) primary key not null,
# nombre_estudiante varchar(100) not null);
#
# insert into BaseDatosII
#     Values("BDA-111","Victor Quispe");
#
# insert into BaseDatosII
#     Values("BDA-112","Juan Perez");
#
# select *
# From BaseDatosII;
#
# CREATE DATABASE universidad;
# use universidad;
#
# create table estudiantes(
#     id_est integer auto_increment primary key not null,
#     nombres varchar(100) not null,
#     apellidos varchar(100) not null,
#     edad integer not null,
#     fono integer not null,
#     email varchar(50) not null
# );
# describe estudiantes;
#
# Insert into estudiantes(nombres, apellidos, edad, fono, email) values
#     ("nombre1","apellido1",20,73205056,"email1"),
#     ("nombre2","apellido2",19,78945622,"email2"),
#     ("nombre3","apellido3",21,65489744,"email3");
#
# SELECT *
# from estudiantes
#
# alter table estudiantes
#     add column direccion varchar(200) not null
# default "El Alto" ;

describe estudiantes
#     este comando me permite agregar nuevos cambios a una tabla
alter table estudiantes
    add column fax varchar(10),
    add column genero varchar(10);


alter table estudiantes
    drop column  fax;

SELECT est.nombres,est.apellidos as 'apellidos de la persona',est.edad
from estudiantes as est
Where est.edad>18;
# mostrar todos los registros donde la edad

SELECT *
from estudiantes as est
where est.id_est %2=0;

SELECT *
from estudiantes as est
where est.id_est %2=!0;

drop table estudiantes;

create table estudiantes
(
    id_est INT auto_increment primary key not null,
    nombres varchar(100)not null,
    apellidos varchar(100)not null,
    edad int not null,
    fono int not null,
    email varchar(100)not null
    );

create table materias
(
    id_mat int auto_increment primary key not null,
    nombre_mat varchar(100)not null,
    cod_mat varchar(100)not null
);

create table inscripcion
(
    id_ins int auto_increment primary key not null,
    id_est int not null,
    id_mat int not null,
    FOREIGN KEY (id_est) references estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

