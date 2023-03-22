Use biblioteca

SELECT cat.nombre AS type,au.nombre as name,au.nacionalidad as nacionality
From autor as au
Inner join libro as lib on au.id = lib.autor_id
INNER JOIN libro_categoria as lc on lib.id = lc.libro_id
INNER JOIN categoria as cat on lc.categoria_id = cat.id
    where valida_historia(cat.nombre,au.nacionalidad)=true;
# WHERE cat.nombre='Historia' AND au.nacionalidad='Peruano';

# EJ 1 de funciones
CREATE OR REPLACE FUNCTION ejemplo1()
RETURNS varchar(30)
    begin
        RETURN 'Victor Hugo Quispe Torrez';
    end;
Select ejemplo1()
# Ej 2 de funciones
CREATE OR REPLACE FUNCTION numero()
RETURNS integer
    begin
        RETURN 10;
    end;
Select numero()
# Crear una funcion que reciba una variable de tipo cadena

CREATE OR REPLACE FUNCTION getNombre(nombres VARCHAR(30))
RETURNS varchar(30)
begin
    Return nombres;
end;
SELECT getNombre('Victor Hugo Quispe Torrez')
# Crear una funcion que sume 3 numeros
CREATE OR REPLACE FUNCTION suma(num1 int,num2 int,num3 int)
RETURNS int
begin
    DECLARE resultado int;
    set resultado=num1+num2+num3;
    return  resultado;
end;

Select suma(1,2,3)
# Crear una funcion de nombre calculadora, recibe 3 parametros:2numeros y una cadena de operacion

Create or REPLACE Function calculadora(num1 int,num2 int, operacion VARCHAR(20))
RETURNS int
begin
    Declare resultado int;
    if operacion='Suma' then
    set resultado=num1+num2;
    end if;
    if operacion='Resta' then
    set resultado=num1-num2;
    end if;
    if operacion='Multiplicacion'then
    set resultado=num1*num2;
    end if;
    if operacion='Division' then
    set resultado=num1/num2;
    end if;

    return resultado;
end;
# Calculadora con case
Create or REPLACE Function calculadora1(num1 int,num2 int, operacion VARCHAR(20))
RETURNS int
begin
    Declare resultado int;
    CASE
        WHEN operacion='Suma' then set resultado=num1+num2;
        WHEN operacion='Resta' then set resultado=num1-num2;
        WHEN operacion='Multiplicacion' then set resultado=num1*num2;
        WHEN operacion='Division' then set resultado=num1/num2;
        Else set resultado=0;
        END case;

    return resultado;
end;

select calculadora1(4,2,'Division')
#Funcion de valida_historia
CREATE OR REPLACE function valida_historia(cat varchar(30),nac varchar(30))
returns bool
begin

    declare response bool default false;
    if cat='Historia' and nac='Peruano' then
        set response=true;
    end if;
return response;
end;
select valida_historia('Historia','Peruano')