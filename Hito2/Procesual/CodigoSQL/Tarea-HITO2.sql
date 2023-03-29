CREATE DATABASE tareaHito2;
USE tareaHito2;
# Crear las tablas para la base de datos

CREATE TABLE estudiantes(id_est integer auto_increment primary key not null,
    nombres varchar(50) not null,
    apellidos varchar(50) not null,
    edad integer not null,
    gestion integer not null,
    fono integer not null,
    email varchar(100) not null,
    direccion varchar(100) not null,
    genero varchar(15) not null
);

CREATE TABLE materias(id_mat int auto_increment primary key not null,
nombre_mat varchar(100)not null ,
cod_mat varchar(100) not null
);

CREATE TABLE inscripcion(
    id_ins int auto_increment primary key not null,
    semestre varchar(20)not null ,
    gestion int not null,
    id_est int not null,
    id_mat int not null,
    FOREIGN KEY (id_est) references estudiantes(id_est),
    FOREIGN KEY (id_mat) references materias(id_mat)
);

# Insertar datos en la base de datos
INSERT INTO estudiantes (nombres, apellidos, edad,gestion, fono, email,direccion, genero)
VALUES ('Miguel', 'Gonzales Veliz', 20,2018, 2832115,'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra', 'Mavir Uria', 25,2019, 2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
('Joel', 'Adubiri Mondar', 30,2020, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
('Andrea', 'Arias Ballesteros', 21,2021, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos', 'Montes Valenzuela', 24,2021, 2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
('Urbanismo y Diseno', 'ARQ-102'),
('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
('Matematica discreta', 'ARQ-104'),
('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
(1, 2, '2do Semestre', 2018),
(2, 4, '1er Semestre', 2019),
(2, 3, '2do Semestre', 2019),
(3, 3, '2do Semestre', 2020),
(3, 1, '3er Semestre', 2020),
(4, 4, '4to Semestre', 2021),
(5, 5, '5to Semestre', 2021);

# Mostra los nombre y apellidos de los inscritos de la materia ARQ-105
SELECT est.nombres,est.apellidos,mat.nombre_mat
FROM estudiantes as est
INNER JOIN inscripcion as ins on est.id_est = ins.id_est
INNER JOIN materias as mat on ins.id_mat = mat.id_mat
WHERE mat.cod_mat='ARQ-105'

# #
# CREATE OR REPLACE FUNCTION comparaMaterias(cod_mat,codigoComp)
# returns varchar (100)
#     Begin
#         Declare cod_mat varchar(100)
#         Select est.nombres,est.apellidos,mat.nombre_mat,mat.cod_mat
#         into cod_mat
#         from estudiantes as est
#         inner join inscripcion as ins on est.id_est = ins.id_est
#         inner join materias as mat on ins.id_mat = mat.id_mat
#         Where mat.cod_mat=cod_mat
#               return cod_mat
#     end;
#
# Select est.id_est
# from estudiantes as est
# where comparaMaterias(mat.cod_mat,'ARQ-105');

# Crear una función que permita obtener el promedio de las edades del género
# masculino o femenino de los estudiantes inscritos en la asignatura ARQ-104.
CREATE OR REPLACE FUNCTION PromedioGenero(gene varchar(15),cod varchar(100))
Returns integer
BEGIN
    DECLARE resultado int;
    SELECT AVG(est.edad)
    into resultado
    from estudiantes as est
    Inner join inscripcion as ins on est.id_est = ins.id_est
    Inner join materias as mat on ins.id_mat=mat.id_mat
    where est.genero=gene and mat.cod_mat=cod;
    return resultado;
end;

SELECT PromedioGenero('Femenino','ARQ-103');

# Crear una funcion que permita concatenar 3 cadenas
CREATE OR REPLACE FUNCTION informacion(cadena1 varchar(100),cadena2 varchar(100),cadena3 int)
RETURNS varchar(200)
BEGIN
    DECLARE resultado varchar(200);
    select concat(cadena1,+', ',cadena2,+', ',cadena3)
    into resultado;
    return resultado;
end;

SELECT informacion('Victor','37',24);

# CREAR UNA VISTA QUE MUESTRE CON ESTADO LIBRE A ESTUDIANTES INSCRITOS EN LA GESTION 2021
SELEct est.nombres,est.apellidos,est.edad,est.gestion
FROM estudiantes as est
WHERE est.gestion=2021;

CREATE OR REPLACE VIEW ARQUITECTURA_DIA_LIBRE as
    SELECT CONCAT(est.nombres,+' ',est.apellidos)as FULLNAME,
           est.edad as EDAD,
           est.gestion as GESTION,
           (CASE
               WHEN est.gestion=2021 then 'LIBRE'
               ELSE 'NO LIBRE'
               END)As DIA_LIBRE
From estudiantes as est;

SELECT * FROM ARQUITECTURA_DIA_LIBRE;

# CREAR UNA TABLA, LUEGO CREAR UNA VIsTA QUE RELACIONE LAS 4 TABLAS
CREATE TABLE profesor(id_profesor int auto_increment primary key not null,
nombre_profesor varchar(100)not null,
estado varchar(20)not null,
id_mat int not null,
alumnos_Curso int not null,
FOREIGN KEY (id_mat)REFERENCES materias(id_mat));
# LLenamos de registros la tabla
INSERT INTO profesor(nombre_profesor,estado,id_mat,alumnos_Curso)VALUES
('Pedro Tarqui','Profesor sustituto',1,16),
('Maria Torrez','Profesor permanente',4,12),
('Nadia Rojas','Profesor permanente',5,14),
('Mario Velasquez','Profesor sustituto',3,11);

SELECT * FROM profesor

CREATE OR REPLACE view PARALELO_DBA_I as
    Select concat(est.nombres,+' ',est.apellidos)as NOMBRES,mat.nombre_mat as MATERIA,
           pro.nombre_profesor as PROFESOR,ins.semestre as SEMESTRE
from estudiantes as est
inner join inscripcion as ins on est.id_est = ins.id_est
inner join materias as mat on ins.id_mat = mat.id_mat
inner join profesor as pro on mat.id_mat = pro.id_mat
WHERE pro.estado like '%permanente%';

Select * FROM PARALELO_DBA_I