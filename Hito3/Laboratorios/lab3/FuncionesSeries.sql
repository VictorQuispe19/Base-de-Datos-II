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

CREATE OR REPLACE FUNCTION numeros(x int)
returns text
begin
    declare str text DEFAULT '';
        REPEAT
        SET str =CONCAT(str,x,', ');
        Set x=x-1;
        UNTIL x<=0 END REPEAT;

    return str;
end;

Select numeros(10)

CREATE OR REPLACE FUNCTION numerosV2(x int)
RETURNS text
BEGIN
    DECLARE str text DEFAULT '';
        REPEAT
        IF x%2=0 THEN
            SET str =CONCAT(str,x,' -AA- ,');
            ELSE
            SET str=concat(str,x,' -BB- ,');
        END IF;
        SET x=x-1;
        UNTIL x<=0 END REPEAT;
    RETURN str;
END;

SELECT numerosV2(10)

CREATE OR REPLACE FUNCTION manejo_de_loop(x int)
RETURNS TEXT
BEGIN
    DECLARE str text DEFAULT '';
    loop_label: LOOP
        if x>0 THEN
        LEAVE loop_label;
        end if;
        SET str=concat(str,x,', ');
        SET x=x+1;
        ITERATE loop_label;
    end loop;
    return str;
end;

SELECT manejo_de_loop(-10)

CREATE OR REPLACE FUNCTION manejo_de_loopV2(x int)
RETURNS TEXT
BEGIN
    DECLARE str text DEFAULT '';
    loop_label: LOOP
        if x>0 THEN
        LEAVE loop_label;
        end if;
        IF x%2=0 THEN
            SET str =CONCAT(str,x,' -AA- ,');
            ELSE
            SET str=concat(str,x,' -BB- ,');
        END IF;
#         SET str=concat(str,x,', ');
        SET x=x+1;
        ITERATE loop_label;
    end loop;
    return str;
end;

SELECT manejo_de_loopV2(-10)

CREATE OR REPLACE FUNCTION TipoCredito(creditNumber int)
RETURNS TEXT
BEGIN
    DECLARE TipoCliente TEXT DEFAULt '';
    IF creditNumber>50000 THEN
        SET TipoCliente='PLATINIUM';
    END IF;
    IF creditNumber between 10000 and 50000 THEN
        SET TipoCliente='GOLD';
    END IF;
    IF creditNumber<10000 THEN
        SET TipoCliente='SILVER';
    end if;

    RETURN TipoCliente;
end;

SELECT TipoCredito(1000)

# charlenght nos permite determinar cuantos caracteres tiene una palabra

Select char_length('DBAII 2023')

CREATE OR REPLACE FUNCTION valida_lenght_7(password TEXT)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';
    IF char_length(password)>7 THEN
        SET resp='Passed';
        Else    SET resp='Failed';
    end if;
    return  resp;
end;
Select valida_lenght_7('AHEROLIVES')

# Comparacion de cadenas comando strcmp
# En mysql si son iguales la funcion me retorna 0
# Si son distintos la funcion retorna -1
SELECT strcmp('DBAII2023','dbaii2023')

# Determinar si do cadenas son iguales, sison iguales retornar cadenas iguales
# Sison distintas retornar cadenas distintas

CREATE OR REPLACE FUNCTION compararCadenas(cadena1 text,cadena2 text)
RETURNS TEXT
BEGIN
    Declare resp TEXT DEFAULT '';
    IF strcmp(cadena1,cadena2)=0 THEN
        SET resp='Cadenas Iguales';
        Else    SET resp='Cadenas Distintas';
    end if;
    return resp;
end;

SELECT compararCadenas('HOLA','HOLA')
# Recibir dos cadenas en la funcion, si las dos cadenas son iguales y ademas el length es mayor a 15
# Retornar el mensaje Valido, sino retornar No VALIDO

CREATE OR REPLACE FUNCTION compararCadenasV2(cadena1 text,cadena2 text)
RETURNS TEXT
BEGIN
    Declare resp TEXT DEFAULT '';
    Declare cadenaM TEXT ;
        SEt cadenaM=CONCAT(cadena1,cadena2);
    IF strcmp(cadena1,cadena2)=0 and char_length(cadenaM)>15 THEN
        SET resp='VALIDO';
        Else    SET resp= 'NO VALIDO';
    end if;
    return resp;
end;

SELECT compararCadenasV2('ELEMENTAL HERO','ELEMENTAL Hero')

Select SUBSTRING('DBAII UNIFRANZ 2023',7);
Select SUBSTRING('DBAII UNIFRANZ 2023' FROM 7 FOR 4);

SELECT SUBSTRING('DBAII UNIFRANZ 2023' ,6,2);

SELECT LOCATE('2023','UNIFRANZ 2023');
SELECT LOCATE('HOLA', 'HOLA QUE TAL')
CREATE OR REPLACE FUNCTION localizar(cad1 text,cad2 text)
RETURNS text
BEGIN
    Declare resp text default '';
    DECLARE buscar int DEFAULT locate(cad2,cad1);
    IF buscar>0 THEN
        SET resp=CONCAT('Si existe: ',buscar);
        ELSE
        SET resp='No existe';
    end if;
    RETURN resp;
end;
SELECT localizar('6038688LP','LP')

CREATE OR REPLACE FUNCTION numeros_naturales_v4(limite int)
returns text
begin
    DECLARE pares int default 0;
    DECLARE respuesta text default ' ';
    WHILE pares<=limite do
        set respuesta= concat(respuesta,pares,',');
        set pares=pares+2;
    end WHILE;
    RETURN respuesta;
end;

SELECT numeros_naturales_v4(19);

CREATE OR REPLACE FUNCTION concatdba(par1 TEXT,num int)
RETURNS TEXT
BEGIN
    DECLARE resp TEXT DEFAULT '';

    REPEAT
        SET resp=CONCAT(par1,resp);
        Set num=num-1;
    until num<=0 end repeat;
    return resp;
end;

SELECT concatdba('DBAII',4);

