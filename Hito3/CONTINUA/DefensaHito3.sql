CREATE DATABASE defensa_hito3_2023;
use defensa_hito3_2023;

# Problema 1

CREATE OR REPLACE FUNCTION VOCALBUSCAR (CADENA TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    WHILE char_length(CADENA)>0 Do
        If substring(CADENA,1,1) IN ('a','e','i','o','u') THEN
            SET RESP=Concat(RESP,SUBSTRING(CADENA,1,1));
            ELSE IF SUBSTRING(CADENA,1,1) IN (' ') THEN
                SET RESP=Concat(RESP,SUBSTRING(CADENA,1,1));
            end if;
        end if;
        SET CADENA=SUBSTRING(CADENA,2);
        end while;
return RESP;
end;

SELECT VOCALBUSCAR('BASE DE DATOS II 2023');
SELECT VOCALBUSCAR('2023');
SELECT VOCALBUSCAR('AAAAA');

# Problema 2

CREATE TABLE CLIENTES(id_client int auto_increment PRIMARY KEY ,
fullname varchar(20) not null ,
lastname varchar(20)not null ,
age int not null,
genero CHAR not null );

INSERT INTO CLIENTES(fullname, lastname, age, genero) VALUES
('Pepito','Perez',21,'M'),
('Maria','Gutierrez',22,'F'),
('Gabriel','Ramos',24,'M');
SELECT * FROM CLIENTES;
SELECT edadMaxima();

CREATE OR REPLACE function edadMaxima()
RETURNS int
BEGIN
    DECLARE resp int;
    Select MAX(cli.age)
        into resp
    from CLIENTES as cli;
    return resp;
end;

CREATE OR REPLACE FUNCTION mostrarParImpar()
    RETURNS TEXT
    BEGIN
        DECLARE contP int default 0;
        DECLARE contI int default edadMaxima();
        DECLARE resp text default '';
        DECLARE cont int default 0;
        loop_label: loop
        If cont=edadMaxima() THEN
        LEAVE loop_label;
        end if;
        if edadMaxima()%2=0 THEN
            SET resp=concat(resp,contP,',');
            SET contP=contP+2;
        end if;
        Set cont=cont+2;
        ITERATE loop_label;
        end loop;

        loop_label: loop
        If contI=1 THEN
        LEAVE loop_label;
        end if;
        if edadMaxima()%2=1 THEN
            SET resp=concat(resp,contI,',');
            SET contI=contI-2;
        end if;
        Set cont=cont+2;
        ITERATE loop_label;
        end loop;
        return resp;
    end;
SELECT mostrarParImpar();

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
SELECT fibonacci(10);
SELECT Locate('UNIFRANZ', 'hola UNIFRANZ tiene 10 carreras');

CREATE OR REPLACE FUNCTION reemplaza_parametros(cad1 text, cad2 text,cad3 text)
RETURNS TEXT
BEGIN
    Declare respuesta TEXT DEFAULT '';
    DECLARE cont int DEFAULT LOCATE(cad2,cad1);
    DECLARE puntero int DEFAULT CHAR_LENGTH(cad2);
        WHILE cont<=char_length(cad1)DO
        SET respuesta=CONCAT(substring(cad1,cont,puntero-1));

        end while;
    return respuesta;
end;
SELECT reemplaza_parametros('UNIFRANZ DICE HOLA','UNIFRANZ','UNIVALLE');

CREATE OR REPLACE FUNCTION revertirCadena(cad1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    DECLARE PUNTERO INT DEFAULT 1;
    DECLARE TAMA INT default char_length(cad1);
    WHILE PUNTERO<=TAMA DO
        SET RESP =CONCAT(SUBSTRING(cad1,PUNTERO,1),RESP);
        SET PUNTERO=PUNTERO+1;
        end while;
    RETURN RESP;
end;

CREATE OR REPLACE FUNCTION revertir(cad text)
    RETURNS TEXT
BEGIN
    DECLARE RESP text default '';
    SELECT REVERSE(cad)
        into RESP;
    return resp;
END;

SELECT revertir('BDA 2023');
SELECT revertirCadena('BDA 2023');

CREATE OR REPLACE FUNCTION revertirCadenaV2(cad1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT '';
    DECLARE PUNTERO TEXT DEFAULT '';
    DECLARE TAMA INT default char_length(cad1);
    WHILE TAMA>=1 DO
        SET PUNTERO =SUBSTRING(cad1,TAMA,1);
        SET TAMA=TAMA-1;
        SET RESP=CONCAT(RESP,PUNTERO);
        end while;
    RETURN RESP;
end;
SELECT revertirCadenaV2('2023 BDA');
