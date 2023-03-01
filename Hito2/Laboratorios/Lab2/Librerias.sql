Create database Librerias;
Use Librerias
Create table categories
(
    category_id int auto_increment primary key not null,
    name varchar(100)not null
);

create table publishers
(
    publisher_id int auto_increment primary key not null ,
    name varchar(100)not null
);

create table books
(
    book_id int auto_increment primary key not null ,
    title varchar(100)not null,
    isbn varchar(50)not null,
    published_date date not null,
    description varchar(100)not null,
    category_id integer not null,
    publisher_id integer not null,
    FOREIGN KEY (category_id) references categories(category_id) ,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);
