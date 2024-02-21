DROP DATABASE IF EXISTS relacion5;
CREATE DATABASE IF NOT EXISTS relacion5;

USE relacion5;

CREATE TABLE IF NOT EXISTS departamentos (
	cddep CHAR(2) PRIMARY KEY,
    nombre VARCHAR(30),
    ciudad VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS empleados (
	cdemp CHAR(3) PRIMARY KEY,
    nombre VARCHAR(30),
    fecha_ingreso DATE,
    cdjefe CHAR(3),
    cddep CHAR(2),
    FOREIGN KEY (cdjefe) REFERENCES empleados (cdemp)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (cddep) REFERENCES departamentos (cddep)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS proyectos (
	cdpro CHAR(3) PRIMARY KEY,
    nombre VARCHAR(30),
    cddep CHAR(2),
    FOREIGN KEY (cddep) REFERENCES departamentos (cddep)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS trabaja (
	cdemp CHAR(3),
    cdpro CHAR(3),
    nhoras INTEGER,
    PRIMARY KEY (cdemp, cdpro),
    FOREIGN KEY (cdemp) REFERENCES empleados (cdemp)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (cdpro) REFERENCES proyectos (cdpro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO departamentos VALUES
('01', 'Contabilidad-1', 'Almeria'),
('02', 'Ventas', 'Almeria'),
('03', 'I+D', 'Malaga'),
('04', 'Gerencia', 'Cordoba'),
('05', 'Administracion', 'Cordoba'),
('06', 'Contabilidad-2', 'Cordoba');

INSERT INTO empleados VALUES
('A11', 'Esperanza Amarillo', '1993-09-23', NULL, '04'),
('A03', 'Pedro Rojo', '1995-03-07', 'A11', '01'),
('C01', 'Juan Rojo', '1997-02-03', 'A03', '01'),
('A07', 'Elena Blanco', '1994-04-09', 'A11', '02'),
('B02', 'Maria Azul', '1996-01-09', 'A03', '01'),
('C04', 'Ana Verde', NULL, 'A07', '02'),
('B06', 'Carmen Violeta', '1997-02-03', 'A07', '02'),
('C05', 'Alfonso Amarillo', '1998-12-03', 'B06', '02'),
('B09', 'Pablo Verde', '1998-10-12', 'A11', '03'),
('C08', 'Javier Naranja', NULL, 'B09', '03'),
('A10', 'Dolores Blanco', '1998-11-15', 'A11', '04'),
('B12', 'Juan Negro', '1997-02-03', 'A11', '05'),
('A13', 'Jesus Marron', '1999-02-21', 'A11', '05'),
('A14', 'Manuel Amarillo', '2000-09-01', 'A11', NULL);

INSERT INTO proyectos VALUES
('GRE', 'Gestion residuos', '03'),
('DAG', 'Depuracion de aguas', '03'),
('AEE', 'Analisis economico energias', '04'),
('MES', 'Marketing de energia solar', '02');

INSERT INTO trabaja VALUES
('C01', 'GRE', 10),
('C08', 'GRE', 54),
('C01', 'DAG', 5),
('C08', 'DAG', 150),
('B09', 'DAG', 100),
('A14', 'DAG', 10),
('A11', 'AEE', 15),
('C04', 'AEE', 20),
('A11', 'MES', 0),
('A03', 'MES', 0);

/* 1. Nombre de los empleados que han trabajado más de 50 horas en proyectos. */
SELECT e.nombre, t.cdpro, t.nhoras
FROM empleados e
JOIN trabaja t ON  e.cdemp = t.cdemp
WHERE t.nhoras >= 50;

/* 2. Nombre de los departamentos que tienen empleados con apellido “Verde” */
SELECT d.nombre
FROM departamentos d
JOIN empleados e ON e.cddep = d.cddep
WHERE e.nombre LIKE '% Verde';

/* 3. Nombre de los proyectos en los que trabajan más de dos empleados. */
SELECT p.nombre
FROM proyectos p
JOIN trabaja t ON t.cdpro = p.cdpro
JOIN empleados e ON e.cdemp = t.cdemp
GROUP BY t.cdpro
HAVING COUNT(t.cdemp) > 2;

/* 4. Lista de los empleados y el departamento al que pertenecen, con indicación del dinero total que
deben percibir, a razón de 35 euros la hora. La lista se presentará ordenada por orden alfabético
de nombre de empleado, y en caso de que no pertenezcan a ningún departamento (NULL) debe
aparecer la palabra “DESCONOCIDO” */
SELECT e.nombre AS empleado, COALESCE(d.nombre, 'Desconocido') AS departamento, t.nhoras * 35 AS salario
FROM empleados e
LEFT JOIN departamentos d ON d.cddep = e.cddep
JOIN trabaja t ON t.cdemp = e.cdemp
ORDER BY e.nombre;

/* 5. Lista de los nombres de todos los empleados, y el número de proyectos en los que está
trabajando (ten en cuenta que algunos empleados no trabajan en ningún proyecto). */
SELECT DISTINCT e.nombre, COUNT(t.cdpro)
FROM empleados e
LEFT JOIN trabaja t ON t.cdemp = e.cdemp
LEFT JOIN proyectos p ON p.cdpro = t.cdpro
GROUP BY e.cdemp;

/* 6. Lista de empleados que trabajan en Málaga o en Almería. */
SELECT e.*
FROM empleados e
JOIN departamentos d ON d.cddep = e.cddep
WHERE d.ciudad IN ('Malaga', 'Almeria');

/* 7. Lista alfabética de los nombres de empleado y los nombres de sus jefes. Si el empleado no tiene
jefe debe aparecer la cadena “Sin Jefe” */
SELECT e.nombre, COALESCE(e2.nombre, 'Sin jefe') AS nombre_jefe
FROM empleados e
LEFT JOIN empleados e2 ON e2.cdemp = e.cdjefe;

/* 8. Fechas de ingreso mínima. y máxima, por cada departamento */
SELECT d.nombre, COALESCE(MIN(e.fecha_ingreso), 'Sin fecha') AS fecha_minima, COALESCE(MAX(e.fecha_ingreso), 'Sin fecha') AS fecha_maxima
FROM departamentos d
LEFT JOIN empleados e ON e.cddep = d.cddep
GROUP BY d.cddep;

/* 9. Nombres de empleados que trabajan en el mismo departamento que Carmen Violeta */
SELECT nombre
FROM empleados
WHERE cddep = (
	SELECT cddep
    FROM empleados
    WHERE nombre LIKE 'Carmen Violeta'
);

/* 10. Media del año de ingreso en la empresa de los empleados que trabjan en algún proyecto. */
SELECT ROUND(AVG(YEAR(e.fecha_ingreso)))
FROM empleados e
JOIN trabaja t ON t.cdemp = e.cdemp;

/* 11. Nombre de los empleados que tienen de apellido Verde o Rojo, y simultáneamente su jefa es
Esperanza Amarillo. */
SELECT e.nombre
FROM empleados e
JOIN empleados e2 ON e2.cdemp = e.cdjefe
WHERE e.nombre LIKE '% Verde' OR e.nombre LIKE '% Rojo'
AND e2.nombre LIKE 'Esperanza Amarillo';

/* 12. Suponiendo que la letra que forma parte del código de empleado es la categoría laboral, listar los
empleados de categoría B que trabajan en algún proyecto. */
SELECT e.*
FROM empleados e
JOIN trabaja t ON t.cdemp = e.cdemp
WHERE e.cdemp LIKE 'B%';

/* 13. Listado de nombres de departamento, ciudad del departamento y número de empleados del
departamento. Ordenada por nombre de ciudad y a igualdad de esta por el nombre del
departamento */
SELECT d.nombre, d.ciudad, COUNT(e.nombre)
FROM departamentos d
LEFT JOIN empleados e ON e.cddep = d.cddep
GROUP BY d.cddep
ORDER BY d.ciudad, d.nombre;

/* 14. Lista de nombres de proyecto y suma de horas trabajadas en él, de los proyectos en los que se ha
trabajado más horas de la media de horas trabajadas en todos los proyectos */
SELECT p.nombre, SUM(t.nhoras)
FROM proyectos p
JOIN trabaja t ON t.cdpro = p.cdpro
GROUP BY t.cdpro
HAVING SUM(t.nhoras) > (
	SELECT AVG(nhoras)
    FROM trabaja
);

/* 15. Nombre de proyecto y horas trabajadas, del proyecto en el que más horas se ha trabajado. */
SELECT p.nombre, SUM(t.nhoras)
FROM proyectos p
JOIN trabaja t ON t.cdpro = p.cdpro
GROUP BY t.cdpro
HAVING SUM(t.nhoras) = (
	SELECT SUM(t2.nhoras)
    FROM trabaja t2
    GROUP BY t2.cdpro
    ORDER BY 1 DESC
    LIMIT 1
);

/* 16. Lista de nombres de empleado que hayan trabajado entre 15 y 100 horas, entre todos los
proyectos en los que trabajan */
SELECT e.nombre
FROM empleados e
JOIN trabaja t ON t.cdemp = e.cdemp
GROUP BY t.cdemp
HAVING SUM(t.nhoras) BETWEEN 15 AND 100;

/* 17. Lista de empleados que no son jefes de ningún otro empleado */
SELECT e.*
FROM empleados e
WHERE NOT EXISTS (
	SELECT 1
    FROM empleados e2
    WHERE e2.cdjefe = e.cdemp
);

/* 18. Se quiere premiar a los empleados del departamento que mejor productividad tenga. Para ello se
decide que una medida de la productividad puede ser el número de horas trabajadas por
empleados del departamento en proyectos, dividida por los empleados de ese departamento.
¿Qué departamento es el más productivo? */
SELECT d.nombre
FROM departamentos d
JOIN empleados e ON e.cddep = d.cddep
JOIN trabaja t ON t.cdemp = e.cdemp
GROUP BY d.cddep
HAVING SUM(t.nhoras) / COUNT(DISTINCT e.nombre) = (
	SELECT SUM(t2.nhoras) / COUNT(DISTINCT e2.nombre)
    FROM trabaja t2
    JOIN empleados e2 ON e2.cdemp = t2.cdemp
    JOIN departamentos d2 ON d2.cddep = e2.cddep
    GROUP BY d2.cddep
    ORDER BY 1 DESC
    LIMIT 1
);

/* 19. Lista donde aparezcan los nombres de empleados, nombres de sus departamentos y nombres de
proyectos en los que trabajan. Los empleados sin departamento, o que no trabajen en proyectos
aparecerán en la lista y en lugar del departamento o el proyecto aparecerá “*****”. */ 
SELECT DISTINCT e.nombre AS empleado, COALESCE(d.nombre, '*****') AS departamento, COALESCE(p.nombre, '*****') AS proyecto
FROM empleados e
LEFT JOIN departamentos d ON d.cddep = e.cddep
LEFT JOIN trabaja t ON t.cdemp = e.cdemp
LEFT JOIN proyectos p ON p.cdpro = t.cdpro;

/* 20. Lista de los empleados indicando el número de días que llevan trabajando en la empresa */
SELECT nombre, DATEDIFF(NOW(), fecha_ingreso) AS dias_trabajando
FROM empleados;

/* 21. Número de proyectos en los que trabajan empleados de la ciudad de Córdoba. */
SELECT COUNT(*) AS num_proyectos
FROM proyectos p
JOIN trabaja t ON t.cdpro = p.cdpro
JOIN empleados e ON e.cdemp = t.cdemp
JOIN departamentos d ON d.cddep = e.cddep
WHERE d.ciudad LIKE 'Cordoba';

/* 22. Lista de los empleados que son jefes de más de un empleado, junto con el número de empleados
que están a su cargo. */ 
SELECT e.nombre, COUNT(e2.cdemp)
FROM empleados e
JOIN empleados e2 ON e2.cdjefe = e.cdemp
GROUP BY e.cdemp
HAVING COUNT(e.cdemp) > 1;

/* 23. Listado que indique años y número de empleados contratados cada año, todo ordenado por orden
ascendente de año. */
SELECT DISTINCT YEAR(fecha_ingreso), COUNT(cdemp) AS cantidad_empleados
FROM empleados
GROUP BY fecha_ingreso
ORDER BY 1;

/* 24. Listar los nombres de proyectos en los que aparezca la palabra “energía”, indicando también el
nombre del departamento que lo gestiona */
SELECT p.nombre AS proyecto, d.nombre AS departamento
FROM proyectos p
JOIN departamentos d ON d.cddep = p.cddep
WHERE p.nombre LIKE '%energia%';

/* 25. Lista de departamentos que están en la misma ciudad que el departamento “Gerencia” */
SELECT nombre AS departamento
FROM departamentos
WHERE ciudad LIKE (
	SELECT ciudad
    FROM departamentos
    WHERE nombre LIKE 'Gerencia'
);

/* 26. Lista de departamentos donde exista algún trabajador con apellido “Amarillo”. */

/* 27. Lista de los nombres de proyecto y departamento que los gestiona, de los proyectos que tienen 0
horas de trabajo realizadas */

/* 28. Asignar el empleado “Manuel Amarillo” al departamento “05” */ 

/* 29. Borrar los departamentos que no tienen empleados */

/* 30. Añadir todos los empleados del departamento 02 al proyecto MES */