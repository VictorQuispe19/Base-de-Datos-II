create database hito2
use hito2

create table usuarios
(
    id_usuario integer auto_increment Primary key not null,
    nombres varchar(50)not null ,
    apellidos varchar(50)not null ,
    edad Integer not null ,
    email varchar(100)not null
);
truncate table usuarios
INSERT INTO usuarios(nombres,apellidos,edad,email)
VALUES ('nombre1','apellidos1',20,'nombre1@correo.com'),
       ('nombre2','<pellidos2',30,'nombre2@correo.com'),
        ('nombre3','apellidos3',40,'nombre3@correo.com');
# vistas en sql y alter
ALTER VIEW mayores_a_30 as
SELECT us.nombres,us.apellidos,us.edad,us.email
from usuarios as us
where us.edad>30;


# modificar la vista anterior
# que tenga
# Fullname, edad_Usuario, Email_usuario
|
CREATE or REPLACE View mayores_a_30 as
SELECT CONCAT(us.nombres,' ',us.apellidos) full_name,us.edad edad_usuario,us.email EMAIL_usuario
from usuarios as us
where us.edad>30;

# a la vista cread mostrar aquellos usuarios que su apellido tengan numero3

select full_name from mayores_a_30 as m30
WHere m30.full_name like '%3'


