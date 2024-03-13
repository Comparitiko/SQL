DROP DATABASE IF EXISTS prueba_examen;
CREATE DATABASE IF NOT EXISTS prueba_examen;

USE prueba_examen;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    ciudad VARCHAR(50),
    correo_electronico VARCHAR(100)
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(50),
    categoria VARCHAR(50),
    precio DECIMAL(10, 2),
    stock INT
);

CREATE TABLE compras (
    id_compra INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO clientes (id_cliente, nombre, ciudad, correo_electronico) VALUES
(1, 'Juan Pérez', 'Madrid', 'juan@example.com'),
(2, 'María López', 'Barcelona', 'maria@example.com'),
(3, 'Pedro García', 'Madrid', 'pedro@example.com');

INSERT INTO productos (id_producto, nombre, categoria, precio, stock) VALUES
(101, 'Televisor', 'Electrónica', 500.00, 10),
(102, 'Teléfono móvil', 'Electrónica', 300.00, 15),
(103, 'Portátil', 'Electrónica', 800.00, 8),
(104, 'Camiseta', 'Ropa', 20.00, 20),
(105, 'Zapatos', 'Ropa', 50.00, 12);

INSERT INTO compras (id_compra, id_cliente, id_producto, cantidad, fecha) VALUES
(1, 1, 101, 2, '2024-03-01'),
(2, 1, 102, 1, '2024-03-05'),
(3, 2, 103, 1, '2024-03-08'),
(4, 3, 104, 3, '2024-03-10'),
(5, 3, 105, 2, '2024-03-11');

/* 1. Escribe una consulta SQL que seleccione todos los datos de la tabla "clientes". */
SELECT * FROM clientes;

/* 2. Escribe una consulta SQL que seleccione los nombres y correos electrónicos de los clientes que viven
en la ciudad de "Madrid" y ordénelos alfabéticamente por nombre. */
SELECT nombre, correo_electronico
FROM clientes
WHERE ciudad LIKE 'Madrid'
ORDER BY nombre DESC;

/* 3. Escribe una consulta SQL que calcule el número total de productos en la tabla "productos". */
SELECT SUM(stock) AS 'Numero de productos'
FROM productos;

/* 4. Escribe una consulta SQL que muestre el nombre del cliente y el nombre del producto que
compraron para todas las compras registradas en la base de datos. */
SELECT c.nombre, p.nombre
FROM compras co
JOIN clientes c ON c.id_cliente = co.id_cliente
JOIN productos p ON p.id_producto = co.id_producto;

/* 5. Escribe una consulta SQL que muestre el nombre del cliente y la cantidad total de dinero gastado por cada cliente en todas sus compras. */
SELECT c.nombre, SUM(p.precio * co.cantidad) AS 'Total gastado'
FROM clientes c
JOIN compras co ON co.id_cliente = c.id_cliente
JOIN productos p ON p.id_producto = co.id_producto
GROUP BY co.id_cliente;

/* 6. Actualiza el precio de todos los productos de la categoría "Electrónica" aumentando el precio en un 10%. */
SET SQL_SAFE_UPDATES = 0;

UPDATE productos
SET precio = precio * 1.10
WHERE categoria LIKE 'Electronica';

SELECT * FROM productos;

/* 7. Elimina todos los productos que tienen un stock menor o igual a 5 unidades. */
INSERT INTO productos VALUES
(106, 'Televisor 2', 'Electrónica', 500.00, 4);

DELETE FROM productos
WHERE stock <= 5;

SELECT * FROM productos;