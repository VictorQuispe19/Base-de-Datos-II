CREATE DATABASE hito3_2023;

USE hito3_2023;

set @usuario='GUEST';
set @locacion='EL ALTO';
SELECT @usuario;
SELECT @locacion;

CREATE FUNCTION variable()
RETURNS TEXT
BEGIN
    RETURN @usuario;
end;

SELECT variable();

SET @HITO_3='ADMIN';

CREATE OR REPLACE FUNCTION admina()
RETURNS VARCHAR (50)
BEGIN
    declare ext varchar(50);
    if @HITO_3='ADMIN' THEN
        SET ext='USUARIO ADMIN';
        else
        SET ext='USUARIO INVITADO';
    end if;
    RETURN ext;
end;

select admina()
# Manejo de case USUARIO ADMIN
SET @HITO_3='GUEST';

CREATE OR REPLACE FUNCTION admina1()
RETURNS VARCHAR (50)
BEGIN
    declare ext varchar(50);
     CASE
    WHEN @HITO_3='ADMIN' then set ext='USUARIO ADMINISTRADOR';
        Else set ext='USUARIO INVITADO/A';
        END case;
    RETURN ext;
end;

SELECT admina1()

CREATE OR REPLACE FUNCTION numeros_naturales(limite int)
returns text
begin
    DECLARE cont int default 1;
    DECLARE respuesta text default ' ';
    WHILE cont<=limite do
    Set respuesta = CONCAT(respuesta,cont, ',');
    set cont=cont+1;
    end WHILE;
    RETURN respuesta;
end;

SELECT numeros_naturales(15);

CREATE OR REPLACE FUNCTION numeros_naturales_v2(limite int)
returns text
begin
    DECLARE cont int default 2;
    Declare conti int default 1;
    DECLARE respuesta text default ' ';
    WHILE cont<=limite and conti<=limite do
    Set respuesta = CONCAT(respuesta,cont,',',conti, ',');
    set cont=cont+2;
    set conti=conti+2;
    end WHILE;
    RETURN respuesta;
end;

SELECT numeros_naturales_V2(10);

CREATE OR REPLACE FUNCTION numeros_naturales_v3(limite int)
returns text
begin
    DECLARE pares int default 2;
    Declare impares int default 1;
    declare cont int default 1;
    DECLARE respuesta text default ' ';
    WHILE cont<=limite do
    IF cont %2=1 THEN
        set respuesta= concat(respuesta,pares,',');
        set pares=pares+2;

        ELSE
        SET respuesta=concat(respuesta,impares,',');
        SET impares=impares+2;
    end if;
    SET cont=cont+1;
    end WHILE;
    RETURN respuesta;
end;

Select numeros_naturales_v3(10)