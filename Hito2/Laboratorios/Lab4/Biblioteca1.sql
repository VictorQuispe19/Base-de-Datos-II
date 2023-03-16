Create database biblioteca

use biblioteca

CREATE TABLE autor (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(50),
  fecha_nacimiento DATE
);

CREATE TABLE usuario (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE,
  direccion VARCHAR(100)
);

CREATE TABLE libro (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  isbn VARCHAR(20),
  fecha_publicacion DATE,
  autor_id INTEGER,
  FOREIGN KEY (autor_id) REFERENCES autor(id)
);

CREATE TABLE prestamo (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  usuario_id INTEGER REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE libro_categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  categoria_id INTEGER REFERENCES categoria(id) ON DELETE CASCADE
);

INSERT INTO autor (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel Garcia Marquez', 'Colombiano', '1927-03-06'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28'),
('Pablo Neruda', 'Chileno', '1904-07-12'),
('Octavio Paz', 'Mexicano', '1914-03-31'),
('Jorge Luis Borges', 'Argentino', '1899-08-24');

INSERT INTO libro (titulo, isbn, fecha_publicacion, autor_id) VALUES
('Cien años de soledad', '978-0307474728', '1967-05-30', 1),
('La ciudad y los perros', '978-8466333867', '1962-10-10', 2),
('Veinte poemas de amor y una canción desesperada', '978-0307477927', '1924-08-14', 3),
('El laberinto de la soledad', '978-9681603011', '1950-01-01', 4),
('El Aleph', '978-0307950901', '1949-06-30', 5);

INSERT INTO usuario (nombre, email, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@gmail.com', '1985-06-20', 'Calle Falsa 123'),
('Maria Rodriguez', 'maria.rodriguez@hotmail.com', '1990-03-15', 'Av. Siempreviva 456'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', '1982-12-10', 'Calle 7ma 789'),
('Laura Sanchez', 'laura.sanchez@gmail.com', '1995-07-22', 'Av. Primavera 234'),
('Jorge Fernandez', 'jorge.fernandez@gmail.com', '1988-04-18', 'Calle Real 567');

INSERT INTO prestamo (fecha_inicio, fecha_fin, libro_id, usuario_id) VALUES
('2022-01-01', '2022-01-15', 1, 1),
('2022-01-03', '2022-01-18', 2, 2),
('2022-01-05', '2022-01-20', 3, 3),
('2022-01-07', '2022-01-22', 4, 4),
('2022-01-09', '2022-01-24', 5, 5);

INSERT INTO categoria (nombre) VALUES
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Historia');

INSERT INTO libro_categoria (libro_id, categoria_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);

Alter Table libro add column paginas INTEGER Default 20;
ALTER TABLE libro add column editorial VARCHAR(70) DEFAULT 'Don Bosco'

CREATE VIEW autor_libro as
Select au.nombre, au.nacionalidad,lib.titulo
from autor as au
inner join libro as lib on lib.autor_id=au.id
where au.nacionalidad LIKE '%Argentino%';

create VIEW libros_ciencia_ficcion As
Select lib.titulo,cat.nombre
from libro_categoria as lc
Inner join categoria as cat on lc.categoria_id=cat.id
inner join libro as lib on lib.id=lc.libro_id
where  cat.nombre='Ciencia Ficción';

# El nombre de la vista deberá ser bookContent.
# La vista deberá de tener las siguientes columnas. (titleBook, editorialBook, pagesBook y typeContentBook).
# El objetivo es mostrar en la columna typeContentBook los siguientes mensajes:
# CONTENIDO BASICO		: si la cantidad de páginas es mayor a 10 y menor igual a 30
# CONTENIDO MEDIANO		: si la cantidad de páginas es mayor a 30 y menor igual a 80
# CONTENIDO SUPERIOR		: si la cantidad de páginas es mayor a 80 y menor igual a 150
# CONTENIDO AVANZADO		: si la cantidad de páginas es mayor a 150.
CREATE OR REPLACE view bookContent AS
SELECT lib.titulo as Title_Book,
       lib.editorial as editorialBook,
       lib.paginas as pagesBook,
       (CASE
        WHEN lib.paginas >= 1 and lib.paginas<=30 then 'CONTENIDO BASICO'
        WHEN lib.paginas > 30 and lib.paginas<=80 then 'CONTENIDO MEDIANO'
        WHEN lib.paginas > 80 and lib.paginas<=150 then 'CONTENIDO SUPERIOR'
        ELSE 'CONTENIDO AVANZADO'
        END) AS contentBook
FROM libro as lib;
SELECT * FROM bookContent

# De acuerd contar cuanros son de contenido medio
SELECT COUNT(contentBook)
from bookContent
Where contentBook='CONTENIDO MEDIANO'

# Crear la siguiente Vista.
# El nombre de la vista deberá ser bookAndUser.
# La vista deberá de tener las siguientes columnas. (BOOK_DETAIL, AUTOR_DETAIL).
# BOOK_DETAIL = Titulo - editorial - categoria
# AUTOR_DETAIL = Nombre - nacionalidad

CREATE OR REPLACE VIEW bookAndUser AS
Select CONCAT(lib.titulo,'-',lib.editorial,'-',cat.nombre)as BookDetail,
       concat(au.nombre,'-',au.nacionalidad)as AutorDetail
FROM autor as au
Inner join libro as lib on au.id = lib.autor_id
inner join libro_categoria as lc on lib.id=lc.libro_id
inner join categoria as cat on lc.categoria_id=cat.id

SELECT *, (case
WHEN BookDetail LIKE '%NOVA%' then 'En venta'
Else 'En proceso'
END) AS disponibilidad
FROM bookAndUser




CREATE OR REPLACE VIEW historyBolivia AS
SELECT cat.nombre AS type,au.nombre as name,au.nacionalidad as nacionality
From autor as au
Inner join libro as lib on au.id = lib.autor_id
INNER JOIN libro_categoria as lc on lib.id = lc.libro_id
INNER JOIN categoria as cat on lc.categoria_id = cat.id
WHERE cat.nombre='Historia' AND au.nacionalidad='Boliviano'


Select * from historyBolivia

