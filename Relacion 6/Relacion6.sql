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

/* 1.- CIUDAD DONDE MAS SE VENDIO */
SELECT c.nom_ciudad
FROM ciudades c
JOIN tiendas t ON t.id_ciudad = c.id_ciudad
JOIN vendedores v ON v.id_tienda = t.id_tienda
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
GROUP BY c.id_ciudad
HAVING SUM(a.precio) = (
	SELECT SUM(a2.precio)
    FROM articulos a2
    JOIN vendart va2 ON va2.id_art = a2.id_art
    JOIN vendedores v2 ON v2.id_vend = va2.id_vend
    JOIN tiendas t2 ON t2.id_tienda = v2.id_tienda
	GROUP BY t2.id_ciudad
    ORDER BY 1 DESC
    LIMIT 1
);

/* 2.- TIENDA DONDE MAS SE VENDIO */
SELECT t.nom_tienda
FROM tiendas t
JOIN vendedores v ON v.id_tienda = t.id_tienda
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
GROUP BY t.id_tienda
HAVING SUM(a.precio) = (
	SELECT SUM(a2.precio)
    FROM articulos a2
    JOIN vendart va2 ON va2.id_art = a2.id_art
    JOIN vendedores v2 ON v2.id_vend = va2.id_vend
    GROUP BY v2.id_tienda
    ORDER BY 1 DESC
    LIMIT 1
);

/* 3.- VENDEDOR QUE MAS VENDIO */
SELECT v.nom_vend
FROM vendedores v
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
GROUP BY v.id_vend
HAVING SUM(a.precio) = (
	SELECT SUM(a2.precio)
    FROM articulos a2
    JOIN vendart va2 ON va2.id_art = a2.id_art
    GROUP BY va2.id_vend
    ORDER BY 1 DESC
    LIMIT 1
);

/* 4.-NOMBRE DE CIUDAD, VENDEDOR, ARTICULO, TIENDA TIPO Y PRECIO DE TODO LO VENDIDO */
SELECT DISTINCT c.nom_ciudad, v.nom_vend, a.nom_art, t.nom_tienda, ti.nom_tipo, a.precio
FROM ciudades c
JOIN tiendas t ON t.id_ciudad = c.id_ciudad
JOIN vendedores v ON v.id_tienda = t.id_tienda
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
JOIN tiposart ti ON ti.id_tipo = a.id_tipo;

/* 5.- NOMBRE DEL TIPO DE ARTICULO MAS CARO */
SELECT ti.nom_tipo
FROM tiposart ti
JOIN articulos a ON a.id_tipo = ti.id_tipo
WHERE a.precio = (
	SELECT MAX(precio)
    FROM articulos
);

/* 6.- DATOS DEL VENDEDOR QUE MAS GANA */
SELECT *
FROM vendedores
WHERE salario = (
	SELECT MAX(salario)
	FROM vendedores
);

/* 7.- MONTANTE DE TODOS LOS ARTICULOS DE TIPO BAZAR */
SELECT SUM(a.precio)
FROM articulos a
JOIN tiposart ti ON ti.id_tipo = a.id_tipo
WHERE ti.nom_tipo = 'Bazar';

/* 8.- MONTANTE DE TODO LO QUE SE VENDIO EN ALMERIA */
SELECT SUM(a.precio)
FROM articulos a
JOIN vendart va ON va.id_art = a.id_art
JOIN vendedores v ON v.id_vend = va.id_vend
JOIN tiendas t ON t.id_tienda = v.id_tienda
JOIN ciudades c ON c.id_ciudad = t.id_ciudad
GROUP BY c.nom_ciudad
HAVING c.nom_ciudad = 'Almeria';

/* 9.- MONTANTE DE TODO LO QUE SE VENDIO EN LUNA */
SELECT SUM(a.precio)
FROM articulos a
JOIN vendart va ON va.id_art = a.id_art
JOIN vendedores v ON v.id_vend = va.id_vend
JOIN tiendas t ON t.id_tienda = v.id_tienda
GROUP BY t.nom_tienda
HAVING t.nom_tienda = 'Luna';

/* 10.- NOMBRE DE ARTICULO, TIPO, PRECIO, TIENDA, CIUDAD Y FECHA DE LO QUE VENDIO MANUEL */
SELECT a.nom_art, ti.nom_tipo, a.precio, t.nom_tienda, c.nom_ciudad, va.fech_venta
FROM ciudades c
JOIN tiendas t ON t.id_ciudad = c.id_ciudad
JOIN vendedores v ON v.id_tienda = t.id_tienda
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
JOIN tiposart ti ON ti.id_tipo = a.id_tipo
WHERE v.nom_vend = 'Manuel';

/* 11.- TOTAL DEL SALARIO DE TODOS LOS TRABAJADORES DE ALMERIA */
SELECT SUM(v.salario)
FROM vendedores v
JOIN tiendas t ON t.id_tienda = v.id_tienda
JOIN ciudades c ON c.id_ciudad = t.id_ciudad
GROUP BY c.nom_ciudad
HAVING c.nom_ciudad = 'Almeria';

/* 12.- NOMBRE DE LOS QUE VENDIERON LECHE */
SELECT DISTINCT v.nom_vend
FROM vendedores v
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
WHERE a.nom_art = 'Leche';

/* 13.- NOMBRE DE LOS QUE VENDIERON ARTICULOS DE TIPO BAZAR. */
SELECT DISTINCT v.nom_vend
FROM vendedores v
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
JOIN tiposart ti ON ti.id_tipo = a.id_tipo
WHERE ti.nom_tipo = 'Bazar';

/* 14.- ARTICULOS DE TIPO BAZAR MAS VENDIDOS */
SELECT a.nom_art, COUNT(va.id_art)
FROM articulos a
JOIN vendart va ON va.id_art = a.id_art
JOIN tiposart ti ON ti.id_tipo = a.id_tipo
GROUP BY ti.nom_tipo, a.nom_art
HAVING ti.nom_tipo = 'Bazar'
AND COUNT(va.id_art) = (
	SELECT COUNT(va2.id_art)
    FROM vendart va2
    JOIN articulos a2 ON a2.id_art = va2.id_art
    JOIN tiposart ti2 On ti2.id_tipo = a2.id_tipo
    GROUP BY ti2.nom_tipo, a2.nom_art
	HAVING ti2.nom_tipo = 'Bazar'
    ORDER BY 1 DESC
    LIMIT 1
);

/* 15.- NOMBRE DEL TIPO CON QUE MAS SE GANA */
SELECT ti.nom_tipo
FROM tiposart ti
JOIN articulos a ON a.id_tipo = ti.id_tipo
GROUP BY ti.id_tipo
HAVING SUM(precio) = (
	SELECT SUM(precio)
    FROM articulos
    GROUP BY id_tipo
    ORDER BY 1 DESC
    LIMIT 1
);

/* 16.- SALARIO Y NOMBRE DE TODOS LOS QUE VENDIERON BOMBILLAS. */
SELECT DISTINCT v.nom_vend, v.salario
FROM vendedores v
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
WHERE a.nom_art = 'Bombilla';

/* 17.- TIENDAS Y CIUDAD DONDE SE VENDIO ALGUNA RADIO. */
SELECT DISTINCT t.nom_tienda, c.nom_ciudad
FROM tiendas t
JOIN ciudades c ON c.id_ciudad = t.id_ciudad
JOIN vendedores v ON v.id_tienda = t.id_tienda
JOIN vendart va ON va.id_vend = v.id_vend
JOIN articulos a ON a.id_art = va.id_art
WHERE a.nom_art = 'Radio';

/* 18.- SUBIR EL SUELDO UN 2% A LOS EMPLEADOS DE SEVILLA */
UPDATE vendedores
SET salario = salario * 1.02
WHERE id_tienda IN (
	SELECT DISTINCT t.id_tienda
    FROM tiendas t
    JOIN ciudades c ON c.id_ciudad = t.id_ciudad
    WHERE nom_ciudad = 'Sevilla'
);

/* 19.- BAJA EL SUELDO UN 1% A LOS QUE NO HAYAN VENDIDO LECHE */
SET SQL_SAFE_UPDATES = 0;

UPDATE vendedores
SET salario = salario * 1.01
WHERE id_vend NOT IN (
	SELECT DISTINCT va.id_vend
    FROM vendart va
    JOIN articulos a ON a.id_art = va.id_art
    WHERE a.nom_art = 'Leche'
);

/* 20.- SUBIR EL PRECIO UN 3% AL ARTICULO MAS VENDIDO */
UPDATE articulos
SET precio = precio * 1.03
WHERE id_art IN (
		SELECT id_art
        FROM vendart
        GROUP BY id_art
		HAVING COUNT(id_art) = (
			SELECT COUNT(id_art)
            FROM vendart
            GROUP BY id_art
            ORDER BY 1 DESC
            LIMIT 1
        )
);

/* 21.- SUBIR EL SUELDO UN 2% A LOS ARTICULOS DE TIPO MAS VENDIDO */
UPDATE articulos
SET precio = precio * 1.02
WHERE id_tipo IN (
	SELECT ti.id_tipo
    FROM (
		SELECT ti2.id_tipo
        FROM tiposart ti2
		JOIN articulos a  ON ti.id_tipo = a.id_tipo
		GROUP BY a.id_tipo
		HAVING SUM(a.precio) = (
			SELECT SUM(a.precio)
			FROM articulos a
			JOIN tiposart ti ON ti.id_tipo = a.id_tipo
			GROUP BY a.id_tipo
			ORDER BY 1
			LIMIT 1
		) AS subquery
    )
);



/*
22.- BAJAR UN 3% TODOS LOS ARTICULOS DE PAPELERIA
23.- SUBIR EL PRECIO UN 1% A TODOS LOS ARTICULOS VENDIDOS EN ALMERIA
24.- BAJAR EL PRECIO UN 5% AL ARTICULO QUE MAS HACE QUE NO SE VENDE
25.- CERRAR LA TIENDA QUE MENOS HA VENDIDO
26.- LA TIENDA LUNA PASA A LLAMARSE SOL Y LUNA
27.- DESPEDIR AL TRABAJADOR QUE MAS VENDIO
28.- LAS TIENDAS QUE NO VENDIERON LAPICES PASAN TODAS A SEVILLA
29.- DESPEDIR AL QUE MENOS DINERO HA HECHO VENDIENDO.
30.- EL ARTICULO QUE MENOS SE HA VENDIDO DEJAR DE ESTAR EN STOCK
31.- EL ARTICULO QUE MENOS DINERO HA GENERADO DEJA DE ESTAR EN STOCK
32.- EL TIPO DE ARTICULO MENOS VENDIDO DEJA DE ESTAR EN STOCK
33.- EL TIPO DE ARTICULO CON EL QUE MENOS SE HA GANADO DEJA DE ESTAR EN STOCK
34.- SE DESPIDEN A TODOS LOS TRABAJADORES QUE NO HAN VENDIDO ARTICULOS DE BAZAR
35.- SE CIERRA LA TIENDA QUE MENOS DINERO HA GANADO.
36.- TODOS LOS TRABAJADORES DE SEVILLA PASAN A LA TIENDA JOYMON
*/