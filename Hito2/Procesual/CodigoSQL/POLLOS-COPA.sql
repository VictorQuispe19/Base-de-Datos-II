CREATE DATABASE POLLOS_COPA;

USE POLLOS_COPA;

# Crear tres tablas para la base de datos de pollos_copa
Create table cliente(
id_cliente varchar (30) Primary key not null,
nombre varchar (50)not null,
apellido varchar (50)not null,
edad int not null,
domicilio varchar (50)not null);

Create table pedido(
id_pedido varchar (30) Primary key not null,
articulo varchar(30)not null,
costo int not null,
fecha varchar(20)not null);

CREATE TABLE detalle_pedido(
id_detalle_pedido varchar(50) Primary key not null,
id_cliente varchar(30)not null,
id_pedido varchar (30)not null,

FOREIGN KEY (id_pedido)REFERENCES pedido(id_pedido),
FOREIGN KEY (id_cliente)REFERENCES cliente(id_cliente)
);

select *
from cliente;

select *
from detalle_pedido;

select *
from pedido;

# Insertar dos registros para cada tabla
INSERT INTO	cliente(id_cliente,nombre,apellido,edad,domicilio)VALUES
('cliente-19561','Kevin','Aramayo',22,'Domicilio 1'),
('cliente-26457','Pablo','Flores',24,'Domicilio 2');

INSERT INTO	pedido(id_pedido,articulo,costo,fecha)VALUES
('pedido-12345','Combo fiesta',35,'19-11-2022'),
('pedido-54321','Combo feliz',25,'11-08-2022');

INSERT INTO detalle_pedido(id_detalle_pedido,id_cliente,id_pedido) VALUES
('19802783','cliente-19561','pedido-12345'),
('39679784','cliente-26457','pedido-54321');

# Crear una funcion que muestre lo siguiente
# el nombre y apellido del cliente, el articulo , y el id de detalle del producto que cueste menos de 30BS

Select cli.nombre,cli.apellido,ped.articulo,det.id_detalle_pedido
From cliente as cli
Inner join detalle_pedido as det on cli.id_cliente=det.id_cliente
Inner join pedido as ped on ped.id_pedido=det.id_pedido
Where ped.costo<30;









CREATE OR REPLACE FUNCTION sumarDosNumeros(n int,m int)
returns int
begin
    DECLARE resultado int;
    set resultado=n+m;
    return resultado;
end;

Select sumarDosNumeros(4,5)
DROP FUNCTION sumarDosNumeros















