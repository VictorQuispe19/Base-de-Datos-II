
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
