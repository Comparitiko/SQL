DROP DATABASE IF EXISTS relacion0;
CREATE DATABASE IF NOT EXISTS relacion0;

USE relacion0;

CREATE TABLE IF NOT EXISTS clientes (
	nif CHAR(9) PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    domicilio VARCHAR(100),
    tlf VARCHAR(25),
    ciudad VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS productos (
	codigo CHAR(4) PRIMARY KEY,
	descripcion VARCHAR(100) NOT NULL,
    precio FLOAT,
    stock FLOAT,
    minimo FLOAT,
    CHECK (precio > 0)
);

CREATE TABLE IF NOT EXISTS facturas (
	numero INTEGER PRIMARY KEY,
    fecha DATE,
    pagado BOOLEAN,
    total_precio FLOAT,
    nif_cliente CHAR(9),
    FOREIGN KEY (nif_cliente) REFERENCES clientes(nif)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS detalles (
	numero INTEGER,
    codigo CHAR(4),
    unidades INTEGER,
    PRIMARY KEY(numero, codigo),
    FOREIGN KEY (numero) REFERENCES facturas(numero)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (codigo) REFERENCES productos(codigo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);