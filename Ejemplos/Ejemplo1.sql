DROP DATABASE IF EXISTS tienda_alumno;
CREATE DATABASE IF NOT EXISTS tienda_alumno;

USE tienda_alumno;

CREATE TABLE IF NOT EXISTS clientes (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono CHAR(9) NOT NULL,
    ciudad VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS productos (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    precio FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS ventas (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cantidad INTEGER NOT NULL,
    id_producto INTEGER,
    id_cliente INTEGER,
    FOREIGN KEY (id_producto) REFERENCES  productos(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES  clientes(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);