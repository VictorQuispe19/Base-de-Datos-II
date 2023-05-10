CREATE DATABASE tarea_hito_3;
USE tarea_hito_3;

SELECT CONCAT('Hola ','Soy estudiante de ','DBA II') ;
SELECT SUBSTRING('VICTOR HUGO',8);

CREATE OR REPLACE FUNCTION nombres(cad1 text)
RETURNS TEXT
BEGIN
    DECLARE posi int default Locate(' ',cad1);
return SUBSTRING(cad1,1,posi);
End;
SELECT nombres('Victor Quispe Torrez');

CREATE OR REPLACE FUNCTION nom(cad1 text,pos int)
RETURNS TEXT
BEGIN
    DECLARE posi int default char_length(cad1);
    DECLARE RESP TEXT default '';
    DECLARE num int default LOCATE(' ',cad1);
    if posi<=pos then
        SET RESP=Concat(SUBSTRING(cad1,1,num),'Cadena aceptada ');
        ELSE
        SET RESP='Cadena no aceptada';
    end if;

return RESP;
End;

SELECT nom('VHQT DBAII',5);

CREATE OR REPLACE FUNCTION compararCad(cad1 text, cad2 text, cad3 text)
    RETURNS text
    BEGIN
        DECLARE Resp text default '';
        If STRCMP(cad1,cad2)=0 or STRCMP(cad2,cad3)=0 or strcmp(cad1,cad3)=0 THEN
            SET Resp='Al menos Dos de ellas son iguales';
            ELSE
            SET Resp='Ninguno es igual';
        end if;
        return Resp;
    end;
Select compararCad('HERO','HERO','POA');


Select LOCATE(' ','VICTOR QUISPE');

CREATE TABLE estudiante(nombres varchar(50) not null,
apellidos varchar(50)not null,
edad int not null,
fono int not null,
email varchar(100) not null,
direccion varchar(100)not null,
genero varchar(10)not null,
id_est int auto_increment PRIMARY KEY);

CREATE TABLE materias(nombre_mat varchar(100)not null,
cod_mat varchar(100)not null,
id_mat int auto_increment PRIMARY KEY);

CREATE TABLE inscripcion(semestre varchar(20)not null,
gestion int not null ,
id_est int not null ,
id_mat int not null ,
id_ins int auto_increment PRIMARY KEY,
FOREIGN KEY (id_mat) REFERENCES materias(id_mat),
FOREIGN KEY (id_est) REFERENCES estudiante(id_est));

INSERT INTO estudiante(nombres, apellidos, edad, fono, email, direccion, genero) VALUES
('Miguel','Gonzales Veliz',20,2832115,'miguel@gmail.com','Av. 6 de Agosto','masculino'),
('Sandra','Mavir Uria',25,2832116,'sandra@gmail.com','Av. 6 de Agosto','femenino'),
('Joel','Adubiri Mondar',30,2832117,'joel@gmail.com','Av. 6 de Agosto','masculino'),
('Andrea','Arias Ballesteros',21,2832118,'andrea@gmail.com','Av. 6 de Agosto','femenino'),
('Santos','Montes Valenzuela',24,2832119,'santos@gmail.com','Av. 6 de Agosto','masculino');

INSERT INTO materias(nombre_mat, cod_mat) VALUES
('Introduccion a la Arquitectura','ARQ-101'),
('Urbanismo y Diseño','ARQ-102'),
('Dibujo y Pintura Arquitectonico','ARQ-103'),
('Matematica Discreta','ARQ-104'),
('Fisica Basica','ARQ-105');

INSERT INTO inscripcion(semestre, gestion, id_est, id_mat) VALUES
('1er Semestre',2018,1,1),
('2do Semestre',2018,1,2),
('1er Semestre',2019,2,4),
('2do Semestre',2019,2,3),
('2do Semestre',2020,3,3),
('3er Semestre',2020,3,1),
('4to Semestre',2021,4,4),
('5to Semestre',2021,5,5);
SELECT * FRom estudiante
# Ejercicio 12

CREATE OR REPLACE FUNCTION fibonacci(numeroF int)
    RETURNS TEXT
    BEGIN
        DECLARE num1 int default 0;
        DECLARE num2 int default 1;
        DECLARE num3 int default 0;
        DECLARE cont int default 0;
        DECLARE resp text default '';
        SET resp=CONCAT(num1,',',num2);
        SET cont=2;
        While cont<numeroF do

            SET num3=num1+num2;
            Set num1=num2;
            Set num2=num3;
            SET resp=Concat(resp,',',num3);
            Set cont=cont+1;
            end while;

        return resp;
    end;
SELECT fibonacci(7);

#Ejercicio 13
SET @LIMIT=5;

CREATE OR REPLACE FUNCTION fibonacciV2()
    RETURNS TEXT
    BEGIN
        DECLARE num1 int default 0;
        DECLARE num2 int default 1;
        DECLARE num3 int default 0;
        DECLARE cont int default 0;
        DECLARE resp text default '';
        SET resp=CONCAT(num1,',',num2);
        SET cont=2;
        While cont<@LIMIT do

            SET num3=num1+num2;
            Set num1=num2;
            Set num2=num3;
            SET resp=Concat(resp,',',num3);
            Set cont=cont+1;
            end while;

        return resp;
    end;
SELECT fibonacciV2();

#Ejercicio 14
CREATE OR REPLACE function edad_minima()
    RETURNS INT
    BEGIN
        DECLARE resp int;
        Select Min(est.edad)
        into resp
        from estudiante as est;
        return resp;
    END;
SELECT edad_minima();
CREATE OR REPLACE FUNCTION mostrarParImpar()
    RETURNS TEXT
    BEGIN
        DECLARE contP int default 0;
        DECLARE contI int default edad_minima();
        DECLARE resp text default '';
        DECLARE cont int default 0;
        WHILE cont<=edad_minima() do
        if edad_minima()%2=0 THEN
            SET resp=concat(resp,contP,',');
            SET contP=contP+2;
            ELSE
            SET resp=concat(resp,contI,',');
            SET contI=contI-2;
        end if;
        Set cont=cont+2;
        end WHILE ;
        return resp;
    end;
SELECT mostrarParImpar();

# Ejercicio 15
CREATE OR REPLACE FUNCTION VOCALBUSCARCAD (CADENA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    DECLARE CONT INT DEFAULT 0;
    DECLARE CONTA INT DEFAULT 0;
    DECLARE CONTE INT DEFAULT 0;
    DECLARE CONTI INT DEFAULT 0;
    DECLARE CONTO INT DEFAULT 0;
    DECLARE CONTU INT DEFAULT 0;
    DECLARE PUNTERO CHAR;
         WHILE CONT <= CHAR_LENGTH(CADENA) DO
             SET PUNTERO = SUBSTRING(CADENA,CONT,1);
             IF PUNTERO = 'a'  THEN
                 SET CONTA = CONTA + 1;
             end if;
             IF PUNTERO='e'THEN
                 SET CONTE=CONTE+1;
             end if;
             IF PUNTERO='i' THEN
                 SET CONTI=CONTI+1;
             end if;
             IF PUNTERO='o' THEN
                 SET CONTO=CONTO+1;
             end if;
             IF PUNTERO='u' THEN
                 SET CONTU=CONTU+1;
             end if;
         SET CONT =CONT+1;
         END WHILE;
          SET RESP=CONCAT('a: ',CONTA,',e: ',CONTE,',i: ',CONTI,',o: ',CONTO,',u: ',CONTU);
    RETURN RESP;
end;
SELECT VOCALBUSCARCAD('HEROE MALVADO MALICIOUS');

#Ejercicio 16
CREATE OR REPLACE FUNCTION TipoCredito(creditNumber int)
RETURNS TEXT
BEGIN
    DECLARE TipoCliente TEXT DEFAULt '';
    CASE
        WHEN creditNumber >50000 then SET TipoCliente='PLATINIUM';
        WHEN creditNumber between 10000 and 50000 then SET TipoCliente='GOLD';
        WHEN creditNumber <10000 then SET TipoCliente='SILVER';
        END CASE;

    RETURN TipoCliente;
end;
SELECT TipoCredito(7500);

#Ejercicio 17
CREATE OR REPLACE FUNCTION VOCALBUSCAR (CADENA VARCHAR(20),CADENA1 VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    WHILE char_length(CADENA)>0 Do
        If substring(CADENA,1,1) NOT IN ('a','e','i','o','u') THEN
            SET RESP=Concat(RESP,SUBSTRING(CADENA,1,1));
        end if;
        SET CADENA=SUBSTRING(CADENA,2);
        end while;
    WHILE char_length(CADENA1)>0 DO
        If substring(CADENA1,1,1) NOT IN ('a','e','i','o','u') THEN
            SET RESP=Concat(RESP,SUBSTRING(CADENA1,1,1));
        end if;
        SET CADENA1=SUBSTRING(CADENA1,2);
        end while;
    return RESP;
end;
SELECT VOCALBUSCAR('VIVA II','PORQUE PLIO');

#EJERCICIO 18
CREATE  OR REPLACE FUNCTION letras(CADENA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    DECLARE punt TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;
    REPEAT
        SET punt = SUBSTRING(CADENA,cont);
        SET RESP = CONCAT(RESP,punt,',');
        SET cont = cont +1;
    until cont >CHAR_LENGTH(CADENA)
        end repeat;
    return RESP;
END;

SELECT letras('DBAII');