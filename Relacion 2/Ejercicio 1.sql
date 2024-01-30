DROP DATABASE IF EXISTS tienda;
CREATE DATABASE IF NOT EXISTS tienda;

SHOW DATABASES;

USE tienda;

CREATE TABLE IF NOT EXISTS fabricantes (
	clave_fabricante INTEGER PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS articulos (
	clave_articulo INTEGER PRIMARY KEY,
    nombre VARCHAR(30),
    precio DOUBLE,
    clave_fabricante INTEGER,
    FOREIGN KEY (clave_fabricante) REFERENCES fabricantes(clave_fabricante)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
);
