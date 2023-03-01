CREATE DATABASE EMPRESA;
Use EMPRESA;

CREATE table empleado
(
    id_tra integer auto_increment primary key not null,
    nombre_tra varchar(100)not null,
    apellido_tra varchar(100)not null,
    fono int not null,
    emali varchar(70)not null,
    direccion varchar(100)not null
);
CREATE TABLE empresas
(
    id_emp int auto_increment primary key not null ,
    nombre_emp varchar(100)not null ,
    direccion varchar(100)not null ,
    id_tra integer not null ,
    id_area integer not null,
    foreign key (id_tra) references empleado(id_tra),
    foreign key (id_area)references area(id_area)
);
Create table area
(
    id_area integer auto_increment primary key not null,
    nombre_area varchar(100) not null ,
    id_tra int not null ,
    foreign key (id_tra)references empleado(id_tra)
);

INSERT INTO empleado(nombre_tra, apellido_tra, fono, emali, direccion)values
("Juan","Perez",72345688,"correo1","direccion1"),
("Manuel","Guerrero",78945612,"correo2","direccion2"),
("Miguel","Rodriguez",78945622,"correo3","direccion3");

INSERT into area (nombre_area, id_tra) values
("Contabilidad",2),
("Seguridad",3),
("Recursos humanos",1);

Insert into empresas(nombre_emp, direccion, id_tra, id_area)values
("Pil","direccion1",2,1),
("Imcruz","direccion2",1,3),
("La papelera","direccion3",3,2);

SElect emp.nombre_emp,are.nombre_area
FROM empresas as emp
inner join area as are on emp.id_area = are.id_area
inner join empleado as tra on tra.id_tra = emp.id_tra
where tra.nombre_tra="Manuel"