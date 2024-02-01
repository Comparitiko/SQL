DROP DATABASE IF EXISTS tienda;
/* 1. Crea una base de datos llamada TIENDA */
CREATE DATABASE IF NOT EXISTS tienda;

/* 2. Muestra las Bases de datos almacenadas */
SHOW DATABASES;

/* 3. Habilita la Base de datos TIENDA */
USE tienda;

/* 4. Genera las siguientes tablas: */

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

/* 5. Muestra las tablas de la Base de datos TIENDA */
SHOW TABLES;

/* 6. Muestra los atributos de la tabla ARTICULOS; */
DESCRIBE articulos;

/* 7. Introduce los siguientes datos en cada tabla */
insert into fabricantes (clave_fabricante, nombre) values
(1, "Kingston"),
(2, "Adata"),
(3, "Logitech"),
(4, "Lexar"),
(5, "Seagate");

insert into articulos (clave_articulo, nombre, precio, clave_fabricante) values
(1, "Teclado", 100, 3),
(2, "Disco duro 300gb", 500, 5),
(3, "Mouse", 80, 3),
(4, "Memoria USB", 140, 4),
(5, "Memoria RAM", 290, 1),
(6, "Disco duro extraíble 250 Gb", 650, 5),
(7, "Memoria USB", 279, 1),
(8, "DVD Rom", 450, 2),
(9, "CD Rom", 200, 2),
(10, "Tarjeta de red", 180, 3);

/* 8. Genera las siguientes consultas: */
/* a) Obtener todos los datos de los productos de la tienda */
SELECT * FROM articulos;
/* b) Obtener los nombres de los productos de la tienda */
SELECT nombre FROM articulos;
/* c) Obtener los nombres y precio de los productos de la tienda */
SELECT nombre, precio FROM articulos;
/* d) Obtener los nombres de los artículos sin repeticiones */
SELECT DISTINCT nombre FROM articulos;
/* e) Obtener todos los datos del artículo cuya clave de producto es ‘5’ */
SELECT * FROM articulos
WHERE clave_articulo = 5;
/* f) Obtener todos los datos del artículo cuyo nombre del producto es ‘’Teclado” */
SELECT * FROM articulos
WHERE nombre = "Teclado";
/* g) Obtener todos los datos de la Memoria RAM y memorias USB */
SELECT * FROM articulos
WHERE nombre IN ("Memoria RAM", "Memoria USB");
/* h) Obtener todos los datos de los artículos que empiezan con ‘M’ */
SELECT * FROM articulos
WHERE nombre LIKE "M%";
/* i) Obtener el nombre de los productos donde el precio sea $ 100 */
SELECT nombre FROM articulos
WHERE precio = 100;
/* j) Obtener el nombre de los productos donde el precio sea mayor a $ 200 */
SELECT nombre FROM articulos
WHERE precio > 200;
/* k) Obtener todos los datos de los artículos cuyo precio este entre $100 y $350 */
SELECT nombre FROM articulos
WHERE precio BETWEEN 100 AND 350;
/* l) Obtener el precio medio de todos los productos */
SELECT AVG(precio) AS precio_medio FROM articulos;
/* m) Obtener el precio medio de los artículos cuyo código de fabricante sea 2 */
SELECT AVG(precio) AS precio_medio FROM articulos
WHERE clave_fabricante = 2;
/* n) Obtener el nombre y precio de los artículos ordenados por Nombre */
SELECT nombre, precio FROM articulos
ORDER BY nombre;
/* o) Obtener todos los datos de los productos ordenados descendentemente por Precio */
SELECT * FROM articulos
ORDER BY precio DESC;
/* p) Obtener el nombre y precio de los artículos cuyo precio sea mayor a $ 250 y ordenarlos descendentemente por precio
y luego ascendentemente por nombre */
SELECT * FROM articulos
WHERE precio > 250
ORDER BY precio DESC, nombre ASC;
/* q) Obtener un listado completo de los productos, incluyendo por cada articulo los datos del articulo y del fabricante */
SELECT a.clave_articulo, a.nombre, a.precio, f.nombre
FROM articulos a
JOIN fabricantes f ON a.clave_fabricante = f.clave_fabricante;
/* r) Obtener la clave de producto, nombre del producto y nombre del fabricante de todos los productos en venta */
SELECT a.clave_articulo, a.nombre, f.nombre
FROM articulos a
JOIN fabricantes f ON a.clave_fabricante = f.clave_fabricante;
/* s) Obtener el nombre y precio de los artículos donde el fabricante sea Logitech ordenarlos alfabéticamente por nombre
del producto */
SELECT a.nombre, a.precio
FROM articulos a
JOIN fabricantes f ON f.clave_fabricante = f.clave_fabricante
WHERE f.nombre = "Logitech"
ORDER BY a.nombre;
/* t) Obtener el nombre, precio y nombre de fabricante de los productos que son marca Lexar o Kingston ordenados
descendentemente por precio */
SELECT a.nombre, a.precio, f.nombre
FROM articulos a
JOIN fabricantes f ON f.clave_fabricante = f.clave_fabricante
WHERE f.nombre IN ("Lexar", "Kingston")
ORDER BY a.precio DESC;
/* u) Añade un nuevo producto: Clave del producto 11, Altavoces de $ 120 del fabricante 2 */
INSERT INTO articulos VALUES (11, "Altavoces", 120, 2);
/* v) Cambia el nombre del producto 6 a ‘Impresora Laser’ */
UPDATE articulos
SET nombre = "Impresora Laser"
WHERE clave_articulo = 6;
/* w) Aplicar un descuento del 10% a todos los productos. */
SET SQL_SAFE_UPDATES = 0;
UPDATE articulos
SET precio = precio * 0.90;
/* x) Aplicar un descuento de $ 10 a todos los productos cuyo precio sea mayor o igual a $ 300 */
UPDATE articulos
SET precio = precio - 10
WHERE precio >= 300;
/* y) Borra el producto numero 6 */
DELETE FROM articulos
WHERE clave_articulo = 6;