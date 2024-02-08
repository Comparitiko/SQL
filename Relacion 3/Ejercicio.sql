DROP DATABASE IF EXISTS relacion3;
CREATE DATABASE IF NOT EXISTS relacion3;

USE relacion3;

CREATE TABLE IF NOT EXISTS provincias (
	id_prov CHAR(3) PRIMARY KEY,
    nom_prov VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS ciudades (
	id_ciud CHAR(3) PRIMARY KEY,
    nom_ciud VARCHAR(20) NOT NULL,
    num_hab INTEGER NOT NULL,
    id_prov CHAR(3) NOT NULL,
    FOREIGN KEY (id_prov) REFERENCES provincias(id_prov)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS zonas (
	id_zona CHAR(3),
    nom_zona VARCHAR(10) NOT NULL,
    id_ciud CHAR(3),
    PRIMARY KEY (id_zona, id_ciud),
    FOREIGN KEY (id_ciud) REFERENCES ciudades(id_ciud)
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS carteros (
	id_cart CHAR(3) PRIMARY KEY,
    nom_cart VARCHAR(25) NOT NULL,
    sueldo INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS periodos (
	id_per CHAR(3) PRIMARY KEY,
    fecha_ini DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS relacion2 (
	id_zona CHAR(3),
    id_ciud CHAR(3),
    id_cart CHAR(3),
    id_per CHAR(3),
    PRIMARY KEY (id_zona, id_ciud, id_cart, id_per),
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona)
    ON DELETE CASCADE,
    FOREIGN KEY (id_ciud) REFERENCES ciudades(id_ciud)
    ON DELETE CASCADE,
    FOREIGN KEY (id_cart) REFERENCES carteros(id_cart)
    ON DELETE CASCADE,
    FOREIGN KEY (id_per) REFERENCES periodos(id_per)
    ON DELETE CASCADE
);
INSERT INTO provincias VALUES
('P01', 'Sevilla'),
('P02', 'Granada'),
('P03', 'Almeria');

INSERT INTO ciudades VALUES
('C01', 'Ciudad1', 890000, 'P01'),
('C02', 'Ciudad2', 110000, 'P02'),
('C03', 'Ciudad3', 98000, 'P03'),
('C04', 'Ciudad4', 65000, 'P01');

INSERT INTO zonas VALUES
('Z01', 'Centro', 'C01'),
('Z02', 'Este', 'C01'),
('Z03', 'Oeste', 'C01'),
('Z04', 'Norte', 'C01'),
('Z05', 'Sur', 'C01'),
('Z01', 'Centro', 'C02'),
('Z02', 'Poligono', 'C02'),
('Z03', 'Oeste', 'C02'),
('Z04', 'Norte', 'C02'),
('Z05', 'Sur', 'C02'),
('Z01', 'Centro', 'C03'),
('Z02', 'Este', 'C03'),
('Z03', 'Barriadas', 'C03'),
('Z04', 'Norte', 'C03'),
('Z05', 'Sur', 'C03'),
('Z01', 'Centro', 'C04'),
('Z02', 'Bulevard', 'C04'),
('Z03', 'Oeste', 'C04'),
('Z04', 'Norte', 'C04'),
('Z05', 'Rivera', 'C04');

INSERT INTO periodos VALUES
('PE1', '2000-05-01', '2000-03-30'),
('PE2', '2000-03-30', '2000-08-15'),
('PE3', '2000-08-15', '2000-11-20'),
('PE4', '2000-11-20', '2000-12-25'),
('PE5', '2000-12-25', '2001-03-03');

INSERT INTO carteros VALUES 
('CT1', 'Juan Perez', 1100),
('CT2', 'Ana Torres', 1080),
('CT3', 'Pepa Fernandez', 1100),
('CT4', 'Vicente Valles', 1790),
('CT5', 'Fernando Gines', 1013),
('CT6', 'Lisa Tormes', 897),
('CT7', 'Waldo Perez', 899),
('CT8', 'Kika Garcia', 987),
('CT9', 'Lola Gimenez', 1123);

INSERT INTO relacion2 VALUES
('Z01', 'C01', 'CT1', 'PE1'),
('Z01', 'C02', 'CT2', 'PE1'),
('Z01', 'C03', 'CT3', 'PE1'),
('Z01', 'C04', 'CT4', 'PE1'),
('Z02', 'C01', 'CT5', 'PE1'),
('Z02', 'C02', 'CT6', 'PE1'),
('Z02', 'C03', 'CT7', 'PE1'),
('Z02', 'C04', 'CT8', 'PE1'),
('Z03', 'C01', 'CT9', 'PE1'),
('Z03', 'C02', 'CT1', 'PE2'),
('Z03', 'C03', 'CT2', 'PE2'),
('Z03', 'C04', 'CT3', 'PE2'),
('Z04', 'C01', 'CT4', 'PE2'),
('Z04', 'C02', 'CT5', 'PE2'),
('Z04', 'C03', 'CT6', 'PE2'),
('Z04', 'C04', 'CT7', 'PE2'),
('Z05', 'C01', 'CT8', 'PE2'),
('Z05', 'C02', 'CT9', 'PE2'),
('Z05', 'C03', 'CT1', 'PE3'),
('Z05', 'C04', 'CT2', 'PE3'),
('Z01', 'C01', 'CT3', 'PE3'),
('Z02', 'C02', 'CT4', 'PE3'),
('Z03', 'C01', 'CT5', 'PE3'),
('Z04', 'C01', 'CT6', 'PE3'),
('Z05', 'C01', 'CT7', 'PE3'),
('Z01', 'C01', 'CT8', 'PE4'),
('Z02', 'C03', 'CT9', 'PE3'),
('Z03', 'C04', 'CT1', 'PE4'),
('Z04', 'C01', 'CT2', 'PE4'),
('Z05', 'C01', 'CT3', 'PE4');

/* 1.-NOMBRE DE CIUDAD CON MÁS HABITANTES. */
SELECT nom_ciud
FROM ciudades
WHERE num_hab = (
	SELECT max(num_hab)
    FROM ciudades
);
/* 2.- NOMBRE DEL CARTERO CON MAYOR SUELDO */
SELECT nom_cart
FROM carteros
WHERE sueldo = (
	SELECT max(sueldo)
    FROM carteros
);
/* 3.- NOMBRE CIUDADES, Nº HABITANTES DE LA PROVINCIA DE SEVILLA */
SELECT nom_ciud, num_hab
FROM ciudades
WHERE id_prov = (
	SELECT id_prov
    FROM provincias
    WHERE nom_prov = 'Sevilla'
);
/* 4.- CARTEROS ORDENADOS POR SULEDO. */
SELECT *
FROM carteros
ORDER BY sueldo DESC;
/* 5.- NOMBRE DE CIUDAD Y NOMBRE DE ZONA */
SELECT c.nom_ciud, z.nom_zona
FROM zonas z
JOIN ciudades c ON z.id_ciud = c.id_ciud;
/* 6.- ZONAS DE LA "C02" */
SELECT *
FROM zonas
WHERE id_ciud = 'C02';
/* 7.- ZONAS DE LA CIUDAD “CIUDAD3”. */
SELECT z.*
FROM zonas z
JOIN ciudades c ON z.id_ciud = c.id_ciud
WHERE c.nom_ciud = 'Ciudad3';
/* 8.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA “Z01,C02” */
SELECT car.nom_cart AS nombre_cartero
FROM carteros car
JOIN relacion2 r ON car.id_cart = r.id_cart
WHERE r.id_zona = 'Z01' AND r.id_ciud = 'C02';
/* 9.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA CENTRO DE LA CIUDAD1 */
SELECT car.nom_cart AS nombre_cartero
FROM carteros car
JOIN relacion2 r ON car.id_cart = r.id_cart
JOIN zonas z ON r.id_zona = z.id_zona
JOIN ciudades c ON z.id_ciud = c.id_ciud
WHERE z.nom_zona = 'Centro'
AND c.nom_ciud = 'Ciudad1';
/* 10.- NOMBRE DE LOS CARTEROS (Y FECHAS DE INICIO Y FIN) QUE HAN TRABAJADO EN LA RIVERA DE LA CIUDAD 4. */
SELECT car.nom_cart AS nombre_cartero, p.fecha_ini AS inicio, p.fecha_fin AS fin
FROM carteros car
JOIN relacion2 r ON car.id_cart = r.id_cart
JOIN zonas z ON r.id_zona = z.id_zona
JOIN ciudades c ON z.id_ciud = c.id_ciud
JOIN periodos p ON r.id_per = p.id_per
WHERE z.nom_zona = 'Rivera'
AND c.nom_ciud = 'Ciudad4';
/* 11.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE SEVILLA */
SELECT DISTINCT car.nom_cart AS nombre_cartero
FROM carteros car
JOIN relacion2 r ON car.id_cart = r.id_cart
JOIN ciudades c ON r.id_ciud = c.id_ciud
JOIN provincias p ON c.id_prov = p.id_prov
WHERE p.nom_prov = 'Sevilla';
/* 12.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN EL PERIODO PE4 Y NOMBRE DE LA CIUDAD EN QUE ESTABAN TRABAJANDO. */
SELECT DISTINCT car.nom_cart, c.nom_ciud
FROM carteros car
JOIN relacion2 r ON car.id_cart = car.id_cart
JOIN ciudades c ON r.id_ciud = c.id_ciud
WHERE r.id_per = 'PE4';
/* 13.- CARTEROS QUE HAN TRABAJADO EN LA CIUDAD CIUDAD1 Y FECHA DE INICIO Y FIN EN QUE LO HAN HECHO. */
/*Haciendo esto*/
SELECT DISTINCT car.nom_cart, c.nom_ciud
FROM carteros car
JOIN relacion2 r ON car.id_cart = car.id_cart
JOIN ciudades c ON r.id_ciud = c.id_ciud
WHERE r.id_per = 'PE4'
/* 14.- CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE ALMERIA NOMBRE DE ZONA Y CIUDAD Y FECHAS EN QUE LO HAN HECHO. */
/* 15.- NUMERO DE HABITANTES DE CADA PROVINCIA. */
/* 16.- NOMBRE Y SUELDO DEL CARTERO QUE MÁS PERIODOS HA TRABAJADO */
/* 17.- NOMBRE DE LACIUDAD QUE MAS CARTEROS HA TENIDO. */
/* 18.- NOMBRE DE LA ZONA QUE MAS CARTEROS HA TENIDO (Y Nº DE CARTEROS) */
/* 19.- NOMBRE/S Y SUELDO/S DEL CARTERO QUE HA REPARTIDO EN EL ESTE DE LA CIUDAD3. */
/* 20.- NOMBRE DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA PROVINCIA DE SEVILLA */
/* 21.- NOMBRE Y SUELDO DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA RIVERA DE LA CIUDAD4. */
/* 22.- FECHA DE INICIO Y FIN DE LOS PERIODOS EN QUE MAS CARTEROS HAN TRABAJADO. */