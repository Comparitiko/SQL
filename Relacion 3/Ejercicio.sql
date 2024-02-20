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
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_ciud) REFERENCES ciudades(id_ciud)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_cart) REFERENCES carteros(id_cart)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_per) REFERENCES periodos(id_per)
    ON DELETE CASCADE
    ON UPDATE CASCADE
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
SELECT DISTINCT car.nom_cart AS nombre_cartero
FROM carteros car
JOIN relacion2 r ON car.id_cart = r.id_cart
JOIN zonas z ON r.id_zona = z.id_zona
JOIN ciudades c ON r.id_ciud = c.id_ciud
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
SELECT DISTINCT car.nom_cart AS nombre_cartero, p.fecha_ini AS inicio, p.fecha_fin AS fin
FROM carteros car
JOIN relacion2 r ON car.id_cart = car.id_cart
JOIN periodos p ON p.id_per = r.id_per
JOIN ciudades c ON r.id_ciud = c.id_ciud
WHERE c.nom_ciud = 'Ciudad1';
/* 14.- CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE ALMERIA NOMBRE DE ZONA Y CIUDAD Y FECHAS EN QUE LO HAN HECHO. */
SELECT DISTINCT car.nom_cart AS nombre_cartero, p.fecha_ini AS inicio, p.fecha_fin AS fin
FROM carteros car
JOIN relacion2 r ON car.id_cart = car.id_cart
JOIN periodos p ON p.id_per = r.id_per
JOIN ciudades c ON r.id_ciud = c.id_ciud
JOIN provincias pr ON c.id_prov = pr.id_prov
WHERE pr.nom_prov LIKE 'Almeria';
/* 15.- NUMERO DE HABITANTES DE CADA PROVINCIA. */
SELECT SUM(c.num_hab) AS numero_habitantes, p.nom_prov AS provincia
FROM ciudades c
JOIN provincias p ON p.id_prov LIKE c.id_prov
GROUP BY p.nom_prov;
/* 16.- NOMBRE Y SUELDO DEL CARTERO QUE MÁS PERIODOS HA TRABAJADO */
SELECT car.nom_cart AS nombre_cartero, car.sueldo, COUNT(p.id_per)
FROM carteros car
JOIN relacion2 r ON r.id_cart LIKE car.id_cart
JOIN periodos p ON p.id_per = r.id_per
GROUP BY car.nom_cart, car.sueldo
HAVING COUNT(p.id_per) = (
	SELECT COUNT(p2.id_per)
    FROM periodos p2
    JOIN relacion2 r2 ON r2.id_per = p2.id_per
    JOIN carteros c2 ON c2.id_cart = r2.id_cart
    GROUP BY c2.id_cart
    ORDER BY COUNT(p.id_per) DESC
	LIMIT 1
);
/* 17.- NOMBRE DE LA CIUDAD QUE MAS CARTEROS HA TENIDO. */
SELECT c.nom_ciud
FROM ciudades c
JOIN relacion2 r ON c.id_ciud LIKE r.id_ciud
JOIN carteros car ON car.id_cart LIKE r.id_cart
GROUP BY c.nom_ciud
HAVING  COUNT(car.id_cart) = (
	SELECT COUNT(car2.id_cart)
    FROM carteros car2
    JOIN relacion2 r2 ON r2.id_cart = car2.id_cart
    JOIN ciudades c2 ON c2.id_ciud = r2.id_ciud
    GROUP BY c2.id_ciud
    ORDER BY COUNT(car.id_cart) DESC
	LIMIT 1
);
/* 18.- NOMBRE DE LA ZONA QUE MAS CARTEROS HA TENIDO (Y Nº DE CARTEROS) */
SELECT z.nom_zona AS nombre_zona, COUNT(car.id_cart) AS numero_carteros
FROM zonas z
JOIN relacion2 r ON r.id_zona LIKE z.id_zona
JOIN carteros car ON car.id_cart LIKE r.id_cart
GROUP BY z.nom_zona
HAVING COUNT(car.id_cart) = (
	SELECT COUNT(car2.id_cart)
    FROM carteros car2
    JOIN relacion2 r2 ON r2.id_cart = car2.id_cart
    JOIN zonas z2 ON z2.id_zona = r2.id_zona
    GROUP BY z2.nom_zona
    ORDER BY COUNT(car2.id_cart) DESC
	LIMIT 1
);
/* 19.- NOMBRE/S Y SUELDO/S DEL CARTERO QUE HA REPARTIDO EN EL ESTE DE LA CIUDAD3. */
SELECT car.nom_cart, car.sueldo
FROM carteros car
JOIN relacion2 r ON r.id_cart LIKE car.id_cart
JOIN zonas z ON z.id_zona LIKE r.id_zona
JOIN ciudades c ON c.id_ciud LIKE z.id_ciud
WHERE c.nom_ciud LIKE 'Ciudad3'
AND z.nom_zona LIKE 'Este';
/* 20.- NOMBRE DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA PROVINCIA DE SEVILLA */
SELECT DISTINCT car.nom_cart
FROM carteros car
JOIN relacion2 r ON r.id_cart LIKE car.id_cart
JOIN ciudades c ON c.id_ciud LIKE r.id_ciud
JOIN provincias p ON p.id_prov LIKE c.id_prov
WHERE p.nom_prov NOT LIKE 'Sevilla';
/* 21.- NOMBRE Y SUELDO DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA RIVERA DE LA CIUDAD4. */
SELECT DISTINCT car.nom_cart
FROM carteros car
JOIN relacion2 r ON r.id_cart LIKE car.id_cart
JOIN zonas z ON z.id_zona LIKE r.id_zona
JOIN ciudades c ON c.id_ciud LIKE z.id_ciud
WHERE z.nom_zona NOT LIKE 'Rivera'
OR c.nom_ciud NOT LIKE 'Ciudad4';
/* 22.- FECHA DE INICIO Y FIN DE LOS PERIODOS EN QUE MAS CARTEROS HAN TRABAJADO. */
SELECT pe.fecha_ini, pe.fecha_fin
FROM periodos pe
JOIN relacion2 r ON r.id_per LIKE pe.id_per
JOIN carteros car ON car.id_cart LIKE r.id_cart
GROUP BY pe.fecha_ini, pe.fecha_fin
HAVING COUNT(car.id_cart) = (
	SELECT COUNT(car2.id_cart)
    FROM carteros car2
    JOIN relacion2 r2 ON car2.id_cart LIKE r2.id_cart
	JOIN periodos pe2 ON pe2.id_per LIKE r2.id_per
	GROUP BY pe2.fecha_ini, pe2.fecha_fin
    ORDER BY COUNT(car2.id_cart) DESC
    LIMIT 1
);