DROP DATABASE IF EXISTS relacion6;
CREATE DATABASE IF NOT EXISTS relacion6;

USE relacion6;

CREATE TABLE IF NOT EXISTS ciudades (
	id_ciudad CHAR(3) PRIMARY KEY,
    nom_ciudad VARCHAR(25)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tiendas (
	id_tienda CHAR(3) PRIMARY KEY,
    nom_tienda VARCHAR(25),
    id_ciudad CHAR(3),
    FOREIGN KEY (id_ciudad) REFERENCES ciudades (id_ciudad)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS vendedores (
		id_vend CHAR(3) PRIMARY KEY,
        nom_vend VARCHAR(25),
        salario DOUBLE,
        id_tienda CHAR(3),
        FOREIGN KEY (id_tienda) REFERENCES tiendas(id_tienda)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tiposart (
	id_tipo CHAR(3) PRIMARY KEY,
    nom_tipo VARCHAR(25)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS articulos (
	id_art CHAR(3) PRIMARY KEY,
    nom_art VARCHAR(25),
    precio DOUBLE,
    id_tipo CHAR(3),
    FOREIGN KEY (id_tipo) REFERENCES tiposart(id_tipo)
	ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS vendart (
	id_vend CHAR(3),
    id_art CHAR(3),
    fech_venta DATE,
    PRIMARY KEY (id_vend, id_art, fech_venta),
    FOREIGN KEY (id_vend) REFERENCES vendedores(id_vend)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_art) REFERENCES articulos(id_art)
	ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=INNODB;

INSERT INTO ciudades VALUES
('CI1', 'Sevilla'),
('CI2', 'Almeria'),
('CI3', 'Granada');

INSERT INTO tiendas VALUES
('TD1', 'Bazares S.A.', 'CI1'),
('TD2', 'Cadenas S.A.', 'CI1'),
('TD3', 'Mirros S.L.', 'CI2'),
('TD4', 'Luna', 'CI3'),
('TD5', 'Mas S.A.', 'CI3'),
('TD6', 'Joymon', 'CI2');

INSERT INTO vendedores VALUES
('VN1', 'Juan', 1090, 'TD1'),
('VN2', 'Pepe', 1034, 'TD1'),
('VN3', 'Lucas', 1100, 'TD2'),
('VN4', 'Ana', 890, 'TD2'),
('VN5', 'Pepa', 678, 'TD3'),
('VN6', 'Manuel', 567, 'TD2'),
('VN7', 'Lorena', 1100, 'TD3');

INSERT INTO tiposart VALUES 
('TI1', 'Bazar'),
('TI2', 'Comestibles'),
('TI3', 'Papeleria');

INSERT INTO articulos VALUES
('AR1', 'Radio', 78, 'TI1'),
('AR2', 'Carne', 15, 'TI2'),
('AR3', 'Bloc', 5, 'TI3'),
('AR4', 'DVD', 24, 'TI1'),
('AR5', 'Pescado', 23, 'TI2'),
('AR6', 'Leche', 2, 'TI2'),
('AR7', 'Camara', 157, 'TI1'),
('AR8', 'Lapiz', 1, 'TI3'),
('AR9', 'Bombilla', 2, 'TI1');

INSERT INTO vendart VALUES
('VN1', 'AR1', '2005-02-01'),
('VN1', 'AR2', '2005-02-01'),
('VN2', 'AR3', '2005-03-01'),
('VN1', 'AR4', '2005-04-01'),
('VN1', 'AR5', '2005-06-01'),
('VN3', 'AR6', '2005-07-01'),
('VN3', 'AR7', '2005-08-01'),
('VN3', 'AR8', '2001-09-12'),
('VN4', 'AR9', '2005-10-10'),
('VN4', 'AR8', '2005-11-1'),
('VN5', 'AR7', '2005-10-1'),
('VN5', 'AR6', '2005-11-2'),
('VN6', 'AR5', '2005-11-3'),
('VN6', 'AR4', '2005-11-4'),
('VN7', 'AR3', '2005-11-5'),
('VN7', 'AR2', '2005-11-7'),
('VN1', 'AR2', '2005-11-6'),
('VN2', 'AR1', '2004-10-8'),
('VN3', 'AR2', '1999-1-1'),
('VN4', 'AR3', '2005-10-25'),
('VN5', 'AR4', '2005-10-26'),
('VN5', 'AR5', '2005-10-27'),
('VN6', 'AR6', '2005-10-28'),
('VN5', 'AR7', '2005-10-28'),
('VN4', 'AR8', '2005-10-30'),
('VN3', 'AR9', '2005-08-24'),
('VN7', 'AR9', '2005-08-25');

