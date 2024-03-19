DROP DATABASE IF EXISTS examengabriel;
CREATE DATABASE IF NOT EXISTS examengabriel;

USE examengabriel;

CREATE TABLE IF NOT EXISTS cliente (
	id_cli CHAR(3) PRIMARY KEY,
    nom_cli VARCHAR(25),
    telf_cli VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS provincia (
	id_prov CHAR(2) PRIMARY KEY,
    provincia VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS localidad (
	c_postal CHAR(5) PRIMARY KEY,
    localidad VARCHAR(20),
    id_prov CHAR(2),
    FOREIGN KEY (id_prov) REFERENCES provincia (id_prov)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS alojamientos (
	id_aloj CHAR(3) PRIMARY KEY,
    nom_aloj VARCHAR(25),
    habitaciones INTEGER,
    categoria VARCHAR(5),
    c_postal CHAR(5),
    FOREIGN KEY (c_postal) REFERENCES localidad (c_postal)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS cli_aloj (
	id_cli CHAR(3),
    id_aloj CHAR(3),
    fech_entrada DATE,
    fech_salida DATE,
    precio DOUBLE,
    PRIMARY KEY (id_cli, id_aloj, fech_entrada),
    FOREIGN KEY (id_cli) REFERENCES cliente (id_cli)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_aloj) REFERENCES alojamientos  (id_aloj)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS empleado (
	id_emp CHAR(3) PRIMARY KEY,
    nom_emp VARCHAR(25),
    sueldo DOUBLE,
    id_aloj CHAR(3),
    FOREIGN KEY (id_aloj) REFERENCES alojamientos (id_aloj)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO cliente VALUES
('C01', 'Juan Fernandez', '898765678'),
('C02', 'Ana Garcia', '678987567'),
('C03', 'Pepa Flores', '432123456'),
('C04', 'Jose Linares', '950122145'),
('C05', 'Luis Garcia', '954678763'),
('C06', 'Xavi Perez', '900873221'),
('C07', 'Luisa Juanes', '878909876'),
('C08', 'Hilario Pino', '675121234'),
('C09', 'Carmen Consuegra', '123234789'),
('C10', 'Vicente Ferrer', '924866378'),
('C11', 'Olvia Ginesa', '789123456'),
('C12', 'Juanjo Diaz', '911234321');

INSERT INTO provincia VALUES 
('04', 'ALMERIA'),
('18', 'GRANADA');

INSERT INTO localidad VALUES 
('04620', 'VERA', '04'),
('04610', 'CUEVAS DEL ALMANZORA', '04'),
('18500', 'GUADIX','18'),
('18004', 'GRANADA', '18');

INSERT INTO alojamientos VALUES
('A01', 'Terraza Carmona', 100, '***', '04620'),
('A02', 'Valle del Este', 250, '****', '04620'),
('A03', 'Hostal Lucero', 17, '**', '04610'),
('A04', 'Vera Playa', 350, '****', '04620'),
('A05', 'Hotel Mexico', 80, '****', '04610'),
('A06', 'Hotel Guadix', 40, '**', '18500'),
('A07', 'Alhambra Palace', 120, '*****', '18004');

INSERT INTO cli_aloj VALUES
('C01', 'A01', '2023/03/01', '2023/03/10', 345),
('C02', 'A01', '2022/04/01', '2022/04/02', 60),
('C03', 'A01', '2021/03/02', '2021/03/11', 540),
('C04', 'A02', '2018/04/03', '2018/04/10', 420),
('C05', 'A02', '2019/05/04', '2019/05/10', 395),
('C06', 'A02', '2013/06/05', '2013/06/10', 145),
('C07', 'A02', '2013/07/06', '2013/07/10', 450),
('C08', 'A03', '2013/08/07', '2013/08/10', 344),
('C09', 'A03', '2013/08/08', '2013/08/10', 349),
('C10', 'A03', '2013/10/09', '2013/10/10', 145),
('C11', 'A03', '2013/11/11', '2013/11/15', 245),
('C12', 'A03', '2013/12/21', '2013/12/30', 600),
('C01', 'A04', '2013/09/05', '2013/09/07', 148),
('C02', 'A03', '2013/10/07', '2013/10/14', 849),
('C03', 'A03', '2013/03/11', '2013/03/15', 248),
('C04', 'A03', '2013/03/21', '2013/03/30', 345),
('C05', 'A01', '2013/03/11', '2013/03/19', 149),
('C06', 'A02', '2013/06/21', '2013/06/30', 315),
('C01', 'A01', '2013/01/11', '2013/01/20', 319),
('C03', 'A04', '2014/02/14', '2014/02/16', 200),
('C04', 'A07', '2014/02/14', '2014/02/16', 500), 
('C09', 'A05', '2014/03/07', '2014/03/09', 400),
('C01', 'A06', '2023/01/01', '2023/01/04', 200);

INSERT INTO empleado VALUES
('E01', 'MANUEL MURCIA', 1400, 'A01'),
('E02', 'GINÉS ASENSIO FERNÁNDEZ', 1500, 'A01'),
('E03', 'BALTASAR PARRA GIMÉNEZ', 950, 'A02'),
('E04', 'ROSA PÉREZ GARCÍA', 1300, 'A03'),
('E05', 'JOSÉ MIGUEL MARTÍNEZ CANO', 1150, 'A04'),
('E06', 'ANTONIO FERNÁNDEZ SOTO', 1200, 'A05'),
('E07', 'Ana Garcia Gimenez', 1100, 'A04'),
('E08', 'MARÍA CAPARROS GÓMEZ', 1300, 'A04'), 
('E09', 'ALICIA FLORES DÍAZ', 1500, 'A05'),
('E10', 'JUAN TORRES NUÑEZ', 2500, 'A07'),
('E11', 'MARIA FLORES RODRIGUEZ', 1100, 'A06');

/* 1. Nombre o nombres de los alojamientos de cuatro estrellas que tienen menor
número de habitaciones. */
SELECT nom_aloj
FROM alojamientos
WHERE categoria = '****' 
AND habitaciones = (
	SELECT MIN(habitaciones)
    FROM alojamientos
    WHERE categoria = '****'
);

/* 2. Datos de los empleados cuyo sueldo está comprendido entre 1000 y 1500 euros
ordenados de mayor a menor sueldo. */
SELECT *
FROM empleado
WHERE sueldo BETWEEN 1000 AND 1500
ORDER BY sueldo DESC;

/* 3. Datos de los empleados cuyo sueldo es mayor que la media de todos los
empleados. */
SELECT *
FROM empleado
WHERE sueldo > (
	SELECT AVG(sueldo)
    FROM empleado
);

/* 4. Nombre de los clientes que se han hospedado en la provincia de Granada. */
SELECT c.nom_cli
FROM cliente c
INNER JOIN cli_aloj ca ON ca.id_cli = c.id_cli
INNER JOIN alojamientos a ON a.id_aloj = ca.id_aloj
INNER JOIN localidad l ON l.c_postal = a.c_postal
INNER JOIN provincia p ON p.id_prov = l.id_prov
WHERE p.provincia = 'Granada';

/* 5. Nombres de los clientes y dinero total que se han gastado en alojarse cada uno
de ellos. */
SELECT c.nom_cli, SUM(precio)
FROM cliente c
INNER JOIN cli_aloj ca ON ca.id_cli = c.id_cli
GROUP BY c.id_cli;

/* 6. Nombre de los alojamientos y fechas en los que ha estado hospedado el cliente
JUAN FERNÁNDEZ, ordenado por el nombre del hotel. */
SELECT a.nom_aloj, ca.fech_entrada, ca.fech_salida
FROM alojamientos a
INNER JOIN cli_aloj ca ON ca.id_aloj = a.id_aloj
INNER JOIN cliente c ON c.id_cli = ca.id_cli 
WHERE c.nom_cli LIKE 'Juan Fernandez'
ORDER BY a.nom_aloj;

/* 7. Datos del cliente/s que más establecimientos ha visitado. */
SELECT c.*
FROM cliente c
INNER JOIN cli_aloj ca ON ca.id_cli = c.id_cli
GROUP BY c.id_cli
HAVING COUNT(ca.id_aloj) = (
	SELECT COUNT(ca2.id_aloj)
    FROM cli_aloj ca2
    GROUP BY ca2.id_cli
    ORDER BY 1 DESC
    LIMIT 1
);

/* 8. Listado de alojamientos, donde aparezca el nombre de cada alojamiento y el
dinero que ha ganado en los hospedajes ordenados por nombre del alojamiento. */
SELECT a.nom_aloj, SUM(precio) AS ganancias
FROM alojamientos a
INNER JOIN cli_aloj ca ON ca.id_aloj = a.id_aloj
GROUP BY a.id_aloj
ORDER BY a.nom_aloj;

/* 9. El nombre del empleado y nombre del alojamiento en que trabaja el empleado
que menor sueldo tiene. */
SELECT e.nom_emp, a.nom_aloj
FROM empleado e
INNER JOIN alojamientos a ON a.id_aloj = e.id_aloj
WHERE sueldo = (
	SELECT MIN(sueldo)
    FROM empleado
);

/* 10. Nombre del alojamiento o alojamientos con mayor número de empleados. */
SELECT a.nom_aloj
FROM alojamientos a
INNER JOIN empleado e ON e.id_aloj = a.id_aloj
GROUP BY a.id_aloj
HAVING COUNT(e.id_emp) = (
	SELECT COUNT(id_emp)
    FROM empleado
    GROUP BY id_aloj
    ORDER BY 1 DESC
    LIMIT 1
);

/* 11. Nombre de la Provincia con menor número de alojamientos. */
SELECT p.provincia
FROM provincia p
INNER JOIN localidad l ON l.id_prov = p.id_prov
INNER JOIN alojamientos a ON a.c_postal = l.c_postal
GROUP BY p.id_prov
HAVING COUNT(a.id_aloj) = (
	SELECT COUNT(a2.id_aloj)
    FROM alojamientos a2
    INNER JOIN localidad l2 ON l2.c_postal = a2.c_postal
    GROUP BY l2.id_prov
    ORDER BY 1
    LIMIT 1
);

/* 12. Numero de alojamientos por Cada provincia. */
SELECT p.provincia, COUNT(a.id_aloj) AS alojamientos
FROM provincia p
INNER JOIN localidad l ON l.id_prov = p.id_prov
INNER JOIN alojamientos a ON a.c_postal = l.c_postal
GROUP BY p.id_prov;

/* 13. Listado que contenga la media del sueldo de los empleados por cada
alojamiento. Donde aparezca la media del sueldo de los empleados y el nombre
del alojamiento. */
SELECT a.nom_aloj, AVG(e.sueldo) AS 'Media sueldo'
FROM alojamientos a
INNER JOIN empleado e ON e.id_aloj = a.id_aloj
GROUP BY a.id_aloj;

/* 14. El sueldo de los empleados que trabajan en la provincia de Almería se
incrementa en un 10% (es decir se actualiza la tabla empleados). */
UPDATE empleado
SET sueldo = sueldo * 1.1+0
WHERE id_aloj IN (
	SELECT DISTINCT a.id_aloj
    FROM alojamientos a
    INNER JOIN localidad l ON l.c_postal = a.c_postal
    INNER JOIN provincia p ON p.id_prov = l.id_prov
    WHERE p.provincia = 'Almeria'
);

/* Comprobacion */
SELECT DISTINCT e.nom_emp, e.sueldo
FROM empleado e
INNER JOIN alojamientos a ON a.id_aloj = e.id_aloj
INNER JOIN localidad l ON a.c_postal = a.c_postal
INNER JOIN provincia p ON p.id_prov = l.id_prov
WHERE p.provincia = 'Almeria';

/* 15. El alojamiento Terraza Carmona incrementa el número de habitaciones a 75. */
SET SQL_SAFE_UPDATES = 0; /*EJECUTAR ESTO PARA QUE FUNCIONE LA ACTUALIZACION DE ABAJO*/

UPDATE alojamientos
SET habitaciones = habitaciones + 75
WHERE nom_aloj = 'Terraza Carmona';

/* Comprobacion */
SELECT * FROM alojamientos
WHERE nom_aloj = 'Terraza Carmona';

/* 16. Borra los empleados que trabajen en Terraza Carmona. */
DELETE FROM empleado
WHERE id_aloj = (
	SELECT id_aloj
    FROM alojamientos
    WHERE nom_aloj = 'Terraza Carmona'
);

/* Comprobacion */
SELECT * 
FROM empleado e
INNER JOIN alojamientos a ON a.id_aloj = e.id_aloj
WHERE a.nom_aloj = 'Terraza Carmona';