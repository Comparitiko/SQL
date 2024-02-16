DROP DATABASE IF EXISTS relacion4;
CREATE DATABASE IF NOT EXISTS relacion4;

USE relacion4;

CREATE TABLE mecanicos (
	id_mec CHAR(3) PRIMARY KEY,
    nom_mec VARCHAR(50) NOT NULL,
    sueldo DOUBLE NOT NULL,
    fec_nac DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tipos (
	id_tipo CHAR(3) PRIMARY KEY,
    nom_tipo VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE coches (
	mat_co CHAR(9) PRIMARY KEY,
    mod_co VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE piezas (
	id_piez CHAR(3) PRIMARY KEY,
    nom_piez VARCHAR(50) NOT NULL,
    id_tipo CHAR(3) NOT NULL,
    FOREIGN KEY (id_tipo) REFERENCES tipos (id_tipo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE periodos (
	id_per CHAR(3) PRIMARY KEY,
    fec_ini DATE NOT NULL,
    fec_fin DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE relacion (
	id_mec CHAR(3),
    mat_co CHAR(9),
    id_per CHAR(3),
    id_piez CHAR(3),
    precio FLOAT,
    PRIMARY KEY(id_mec, mat_co, id_per, id_piez),
    FOREIGN KEY (id_mec) REFERENCES mecanicos (id_mec)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (mat_co) REFERENCES coches (mat_co)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_per) REFERENCES periodos (id_per)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_piez) REFERENCES piezas (id_piez)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO mecanicos VALUES
('ME1', 'JUAN ROMUALDO', 1289, '1970-09-05'),
('ME2', 'RAMON FERNANDEZ', 1678, '1976-07-05'),
('ME3', 'ANA LUCAS', 1100, '1968-09-04');

INSERT INTO tipos VALUES
('TI1', 'Chapa'),
('TI2', 'Mecanica'),
('TI3', 'Electricidad'),
('TI4', 'Accesorios');

INSERT INTO coches VALUES
('1234-CDF', 'SEAT LEON', 'GRIS', 'DIESEL'),
('0987-CCC', 'RENAULT MEGANE', 'BLANCO', 'GASOLINA'),
('0123-BVC', 'OPEL ASTRA', 'AZUL', 'DIESEL'),
('1456-BNL', 'FORD FOCUS', 'VERDE', 'DIESEL'),
('1111-CSA', 'SEAT TOLEDO', 'ROJO', 'GASOLINA'),
('4567-BCB', 'VOLKSWAGEN POLO', 'BLANCO', 'DIESEL'),
('0987-BFG', 'FORD FIESTA', 'NEGRO', 'GASOLINA');

INSERT INTO periodos VALUES
('PE1', '2003-04-09', '2003-04-10'),
('PE2', '2004-05-12', '2004-05-17'),
('PE3', '2004-06-17', '2004-06-27'),
('PE4', '2005-08-22', '2005-09-1'),
('PE5', '2005-09-10', '2005-09-15'),
('PE6', '2005-10-1', '2005-10-17');

INSERT INTO piezas VALUES
('PI1', 'Filtro', 'TI4'),
('PI2', 'Bateria', 'TI3'),
('PI3', 'Aceite', 'TI2'),
('PI4', 'Radio', 'TI4'),
('PI5', 'Embrague', 'TI2'),
('PI6', 'Aleta', 'TI1'),
('PI7', 'Piloto', 'TI3'),
('PI8', 'Calentador', 'TI2'),
('PI9', 'Correas', 'TI4');

INSERT INTO relacion VALUES
('ME1', '1234-CDF', 'PE1', 'PI1', 23),
('ME1', '0123-BVC', 'PE2', 'PI2', 98),
('ME1', '1456-BNL', 'PE3', 'PI6', 124),
('ME1', '4567-BCB', 'PE4', 'PI5', 245),
('ME2', '0987-CCC', 'PE1', 'PI9', 345),
('ME2', '0987-CCC', 'PE1', 'PI8', 232),
('ME2', '0987-BFG', 'PE2', 'PI1', 17),
('ME2', '4567-BCB', 'PE3', 'PI7', 99),
('ME2', '1111-CSA', 'PE4', 'PI4', 124),
('ME2', '1111-CSA', 'PE4', 'PI2', 153),
('ME3', '1456-BNL', 'PE6', 'PI3', 89),
('ME3', '1456-BNL', 'PE1', 'PI4', 232),
('ME3', '1234-CDF', 'PE2', 'PI8', 235),
('ME3', '1111-CSA', 'PE3', 'PI9', 567),
('ME3', '0123-BVC', 'PE5', 'PI6', 232),
('ME3', '0987-CCC', 'PE4', 'PI2', 78),
('ME1', '0987-BFG', 'PE5', 'PI3', 64),
('ME2', '1234-CDF', 'PE6', 'PI5', 234),
('ME1', '0987-BFG', 'PE6', 'PI9', 345),
('ME2', '1234-CDF', 'PE6', 'PI1', 12),
('ME1', '1234-CDF', 'PE1', 'PI6', 187),
('ME3', '1111-CSA', 'PE3', 'PI4', 345),
('ME1', '0123-BVC', 'PE2', 'PI3', 72),
('ME2', '0123-BVC', 'PE6', 'PI3', 89);

/* 1.- DATOS DEL EMPLEADO DE MAYOR SUELDO. */
SELECT *
FROM mecanicos
WHERE sueldo = (
	SELECT MAX(sueldo)
    FROM mecanicos
);

/* 2.- DATOS DEL EMPLEADO MAYOR. */
SELECT * 
FROM mecanicos
WHERE fec_nac = (
	SELECT fec_nac
    FROM mecanicos
    ORDER BY fec_nac
    LIMIT 1
);

/* 3.- DATOS DEL EMPLEADO MENOR. */
SELECT * 
FROM mecanicos
WHERE fec_nac = (
	SELECT fec_nac
    FROM mecanicos
    ORDER BY fec_nac DESC
    LIMIT 1
);

/* 4.- DATOS DE TODOS LOS COCHES DIESEL. */
SELECT *
FROM coches
WHERE tipo LIKE 'Diesel';

/* 5.- DATOS DEL COCHE QUE MAS HA IDO AL TALLER. */
SELECT c.*
FROM coches c
JOIN relacion r ON r. mat_co LIKE c.mat_co
GROUP BY c.mat_co
HAVING COUNT(c.mat_co) = (
	SELECT COUNT(r2.mat_co)
    FROM coches c2
	JOIN relacion r2 ON r2.mat_co LIKE c2.mat_co
    GROUP BY c2.mat_co
    ORDER BY COUNT(r2.mat_co) DESC
    LIMIT 1
);

/* 6.- PRECIO TOTAL DE TODAS LAS REPARACIONES. */
SELECT SUM(precio) AS 'Precio total'
FROM relacion;

/* 7.- NOMBRE DE PIEZA Y TIPO DE LA PIEZA MAS USADA. */
SELECT p.nom_piez AS 'Nombre pieza', t.nom_tipo AS 'Nombre tipo'
FROM piezas p
JOIN tipos t ON t.id_tipo = p.id_tipo
JOIN (
	SELECT id_piez, COUNT(*) AS total_piezas
    FROM relacion
    GROUP BY id_piez
    ORDER BY COUNT(*) DESC
    LIMIT 1
    
) AS max_piezas ON p.id_piez = max_piezas.id_piez;

/* 8.- NOMBRE Y TIPO DE LA PIEZA MENOS USADA. */
SELECT p.nom_piez AS 'Nombre pieza', t.nom_tipo AS 'Nombre tipo'
FROM piezas p
JOIN tipos t ON t.id_tipo = p.id_tipo
JOIN relacion r ON r.id_piez = p.id_piez
GROUP BY r.id_piez
HAVING COUNT(r.id_piez) = (
	SELECT COUNT(*) AS total_piezas
    FROM relacion
    GROUP BY id_piez
    ORDER BY COUNT(*)
    LIMIT 1
);

/* 9.- MATRICULA, MARCA, MODELO COLOR PIEZA Y TIPO DE TODOS LOS COCHES REPARADOS. */
SELECT DISTINCT c.mat_co AS matricula, c.mod_co AS marca, c.color, p.nom_piez AS pieza, c.tipo
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
JOIN piezas p ON p.id_piez = r.id_piez;

/* 10.- MODELO DE PIEZA Y TIPO PUESTAS A ‘0123-BVC’ */
SELECT p.nom_piez AS 'Nombre pieza', t.nom_tipo AS 'Nombre tipo'
FROM piezas p
JOIN tipos t ON t.id_tipo = p.id_tipo
JOIN relacion r ON r.id_piez = p.id_piez
WHERE r.mat_co = '0123-BVC';

/* 11.-DINERO QUE HA GASTADO EN REPARACIONES 1234-CDF */
SELECT SUM(precio) AS dinero_gastado
FROM relacion
WHERE mat_co = '1234-CDF';

/* 12.- DATOS DEL COCHE QUE MAS HA GASTADO EN REPARACIONES */
SELECT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
GROUP BY c.mat_co
HAVING SUM(r.precio) = (
	SELECT SUM(precio)
    FROM relacion
    GROUP BY mat_co
    ORDER BY SUM(precio) DESC
    LIMIT 1
);

/* 13- DATOS DEL COCHE QUE MENOS HA GASTADO EN REPARACIONES. */
SELECT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
GROUP BY c.mat_co
HAVING SUM(r.precio) = (
	SELECT SUM(precio)
    FROM relacion
    GROUP BY mat_co
    ORDER BY SUM(precio)
    LIMIT 1
);

/* 14.- DATOS DEL COCHE QUE MENOS HA GASTADO EN EL TALLER. */
SELECT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
GROUP BY c.mat_co
HAVING SUM(r.precio) = (
	SELECT SUM(precio)
    FROM relacion
    GROUP BY mat_co
    ORDER BY SUM(precio)
    LIMIT 1
);

/* 15.- TOTAL DE TODAS LAS REPARACIONES DE ‘ANA LUCAS’. */
SELECT SUM(r.precio) AS precio_reparaciones
FROM relacion r
JOIN mecanicos m ON m.id_mec = r.id_mec
WHERE m.nom_mec = 'Ana Lucas';

/* 16.- DATOS DE LOS COCHES Y LAS PIEZAS PUESTAS POR ‘JUAN ROMUALDO’. */
SELECT DISTINCT c.*, p.nom_piez
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
JOIN piezas p ON p.id_piez = r.id_piez
JOIN mecanicos m ON m.id_mec = r.id_mec
WHERE nom_mec = 'Juan Romualdo';

/* 17.- FECHA DE INICIO Y FIN DEL PERIODO EN QUE MAS SE HA TRABAJADO. */
SELECT pe.fec_ini, pe.fec_fin
FROM periodos pe
JOIN relacion r ON r.id_per = pe.id_per
GROUP BY r.id_per
HAVING COUNT(r.id_per) = (
	SELECT COUNT(id_per)
    FROM relacion
    GROUP BY id_per
    ORDER BY COUNT(id_per) DESC
    LIMIT 1
);

/* 18.- FECHA DE INICIO Y FIN DEL PERIODO QUE MENOS SE HA TRABAJADO. */
SELECT pe.fec_ini, pe.fec_fin
FROM periodos pe
JOIN relacion r ON r.id_per = pe.id_per
GROUP BY r.id_per
HAVING COUNT(r.id_per) = (
	SELECT COUNT(id_per)
    FROM relacion
    GROUP BY id_per
    ORDER BY COUNT(id_per)
    LIMIT 1
);

/* 19.-DINERO QUE SE HA HECHO EN EL PERIODO PE2 */
SELECT SUM(r.precio) AS total_dinero
FROM relacion r
WHERE id_per = 'PE2';

/* 20.- DATOS DE LOS COCHES LA QUE SE LE HALLA PUESTO UN EMBRAGUE */
SELECT DISTINCT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
JOIN piezas p ON p.id_piez = r.id_piez
WHERE p.nom_piez = 'Embrague';

/* 21.- DATOS DE LOS COCHES A LOS QUE SE LES HALLA CAMBIADO EL ACEITE. */
SELECT DISTINCT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
JOIN piezas p ON p.id_piez = r.id_piez
WHERE p.nom_piez = 'Aceite';

/* 22.- DATOS DE LOS MECANICOS QUE HALLAN PUESTO ALGUNA PIEZA DE TIPO ‘ELECTRICIDAD’. */
SELECT DISTINCT c.*
FROM coches c
JOIN relacion r ON r.mat_co = c.mat_co
JOIN piezas p ON p.id_piez = r.id_piez
JOIN tipos t ON t.id_tipo = p.id_tipo
WHERE t.nom_tipo = 'Electricidad';

/* 23.- MONTANTE ECONOMICO DE TODAS LAS PIEZAS DE TIPO CHAPA. */
SELECT SUM(r.precio) AS precio, nom_piez
FROM relacion r
JOIN piezas p ON p.id_piez = r.id_piez
JOIN tipos t ON t.id_tipo = p.id_tipo
GROUP BY p.nom_piez, t.nom_tipo
HAVING t.nom_tipo = 'Chapa';

/* 24.- TIPO DE PIEZA QUE MAS DINERO HA DEJADO EN EL TALLER. */
SELECT t.nom_tipo AS tipo
FROM tipos t
JOIN piezas p ON p.id_tipo = t.id_tipo
JOIN relacion r ON r.id_piez = p.id_piez
GROUP BY p.id_tipo
HAVING SUM(r.precio) = (
	SELECT SUM(r2.precio)
    FROM relacion r2
    JOIN piezas p2 ON p2.id_piez = r2.id_piez
    GROUP BY p2.id_tipo
    ORDER BY SUM(r2.precio) DESC
    LIMIT 1
);

/* 25.-DATOS DEL MECANICO QUE MENOS HA TRABAJADO. */
SELECT m.*
FROM mecanicos m
JOIN relacion r ON m.id_mec = r.id_mec
JOIN periodos pe ON pe.id_per = r.id_per
GROUP BY m.id_mec
HAVING SUM(DATEDIFF(pe.fec_fin, pe.fec_ini)) = (
	SELECT SUM(DATEDIFF(pe2.fec_fin, pe2.fec_ini))
    FROM periodos pe2
    JOIN relacion r2 ON r2.id_per = pe2.id_per
    JOIN mecanicos m2 ON m2.id_mec = r2.id_mec
    GROUP BY m2.id_mec
    ORDER BY SUM(DATEDIFF(pe2.fec_fin, pe2.fec_ini))
    LIMIT 1
);
