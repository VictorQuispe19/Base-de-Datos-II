CREATE DATABASE defensa_hito_2;

USE defensa_hito_2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
    fec_devolucion DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);

INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
       ('autor_name_2', 'Argentina'),
       ('autor_name_3', 'Mexico'),
       ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
       ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
       ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
       ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
       ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
       ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
       ('HISTORIA', 2),
       ('COMEDIA', 3),
       ('MANGA', 4),
       ('MANGA', 5),
       ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
       ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
       ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
       ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
       ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
       ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
       ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
       ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
       (2, 2, '2017-11-20', '2017-11-22'),
       (3, 3, '2018-10-22', '2018-10-27'),
       (4, 3, '2018-11-15', '2017-11-20'),
       (5, 4, '2018-12-20', '2018-12-25'),
       (6, 5, '2019-10-16', '2019-10-18');

# Mostrar datos del usuario, libro, en una vista
CREATE OR REPLACE VIEW LIBROS_ESTADO AS
SELECT CONCAT(usr.fullname,usr.lastname)AS NOMBRE_COMPLETO,usr.ci AS CI_USER,
       bk.title AS LIBRO_PRESTADO, cat.type AS CATEGORIA
    FROM users as usr
    INNER JOIN prestamos as pre on pre.id_user=usr.id_user
    INNER JOIN book as bk on pre.id_book = bk.id_book
    Inner JOIN category as cat on cat.id_book=bk.id_book
    WHERE cat.type = 'MANGA' or cat.type='COMEDIA'

SELECT* FROM LIBROS_ESTADO

SELECT count(usr.id_user)
    FROM users as usr
    INNER JOIN prestamos p on usr.id_user = p.id_user
    INNER JOIN book b on p.id_book = b.id_book
        WHERE b.pages>90 and b.editorial= 'IBRANI';

# EJERCICIOS 2
CREATE OR REPLACE FUNCTION USUARIOS_IBRANI(edit varchar(100),pag int)
returns int
    begin
        declare cont int;
SELECT count(usr.id_user)
into cont
    FROM users as usr
    INNER JOIN prestamos p on usr.id_user = p.id_user
    INNER JOIN book b on p.id_book = b.id_book
        WHERE b.pages>pag and b.editorial= edit;
            return cont;
        end;

SELECT USUARIOS_IBRANI('IBRANI',90)


# EJERCICIO 3
CREATE OR REPLACE FUNCTION IBRANI(pages varchar(20))
returns varchar (20)
begin
    declare numpage varchar(20);
    if pages mod 2=0 then
        set numpage=CONCAT('PAR:',pages);
    end if;
    if pages mod 2=1 then
        set numpage=CONCAT('IMPAR:',pages);
    end if;
    return numpage;
end;

CREATE OR REPLACE FUNCTION concat_libro(editorial varchar(50),categoria varchar(50))
RETURNS varchar (100)
BEGIN
    Declare cont varchar(100);
    SET cont= concat('EDITORIAL:', +editorial,+', ',+'CATEGORIA:',categoria);
return cont;
        end;

    select concat_libro(bk.editorial,cat.type) as DESCRIPTION,
           IBRANi(bk.pages)
               AS PAGES
FROM book as bk
inner join category cat on bk.id_book = cat.id_book
WHERE cat.type='MANGA'and bk.editorial='IBRANI';

# CONCAT los años de gestion
# EJERCICIO 4
CREATE OR REPLACE FUNCTION usuariosGestion2017_2018()
returns int
    begin
        declare cont int;
SELECT count(bk.id_book)into cont
FROM book as bk
inner join prestamos p on bk.id_book = p.id_book
WHERE p.fec_prestamo like '%2017%' or p.fec_prestamo like '%2018%';
        return cont;
        end;

SELECT usuariosGestion2017_2018()
