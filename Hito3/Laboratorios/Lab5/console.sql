Create or REPLACE function cuenta_caracter(cad1 VARCHAR(50),letra char)
RETURNS TEXT
BEGIN
    Declare respuesta TEXT DEFAULT 'La letra no hay en la cadena';
    DECLARE cont int DEFAULT 1;
    DECLARE puntero char;
    DECLARE nveces int default 0;
    If locate(letra,cad1)>0 then
        WHILE cont<=char_length(cad1)DO
        SET puntero=substring(cad1,cont,1);
        IF puntero=letra then
            SET nveces=nveces+1;
        end if;
        SET cont=cont+1;
            end while;
        SET respuesta=concat('La letra ',letra,' se repite ',nveces,' veces');
    end if;
    return respuesta;
end;

Select cuenta_caracter('DBAII-2023','I');

Create or REPLACE function cuenta_caracterV2(cad1 VARCHAR(50))
RETURNS TEXT
BEGIN

    DECLARE cont int DEFAULT 1;
#     DECLARE puntero char;
    DECLARE nveces int default 0;
        WHILE cont<=char_length(cad1)DO
#         SET puntero=substring(cad1,cont,1);
        IF SUBSTRING(cad1,cont,1) LIKE '%aeiou%' then
            SET nveces=nveces+1;
        end if;
        SET cont=cont+1;
            end while;
    return concat('Cantidad de vocales: ',nveces);
end;

SELECT cuenta_caracterV2('HolaMundo')

CREATE OR REPLACE FUNCTION cuentaPalabrasV3(cad1 text)
RETURNS TEXT
BEGIN
    Declare respuesta TEXT DEFAULT 'La letra no hay en la cadena';
    DECLARE cont int DEFAULT 1;
    DECLARE puntero char;
    DECLARE nveces int default 0;

        WHILE cont<=char_length(cad1)DO
        SET puntero=substring(cad1,cont,1);
        IF puntero='' then
            SET nveces=nveces+1;
        end if;
        SET cont=cont+1;
            end while;
        SET respuesta=concat('La letra  se repite ',nveces,' veces');

    return respuesta;
end;
SELECT cuentaPalabrasV3('hola Mundo')

CREATE OR REPLACE FUNCTION apellidos(cad1 text)
RETURNs TEXT
BEGIN
    DECLARE pos int default LOCATE(' ',cad1);
return SUBSTRING(cad1,pos);
End;

SELECT apellidos('Victor Quispe Torrez')

