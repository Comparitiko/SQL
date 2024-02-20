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
    FOREIGN KEY (cdjefe) REFERENCES empleado (cdemp)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    FOREIGN KEY (cddep) REFERENCES departamento (cddep)
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
('C01', 'Juan Rojo', '1997-02-03', 'A03', '01'),
('B02', 'Maria Azul', '1996-01-09', 'A03', '01'),
('A03', 'Pedro Rojo', '1995-03-07', 'A11', '01'),
('C04', 'Ana Verde', NULL, 'A07', '02'),
('C05', 'Alfonso Amarillo', '1998-12-03', 'B06', '02'),
('B06', 'Carmen Violeta', '1997-02-03', 'A07', '02'),
('A07', 'Elena Blanco', '1994-04-09', 'A11', '02'),
('C08', 'Javier Naranja', NULL, 'B09', '03'),
('B09', 'Pablo Verde', '1998-10-12', 'A11', '03'),
('A10', 'Dolores Blanco', '1998-11-15', 'A11', '04'),
('A11', 'Esperanza Amarillo', '1993-09-23', NULL, '04'),
('B12', 'Juan Negro', '1997-02-03', 'A11', '05'),
('A13', 'Jesus Marron', '1999-02-21', 'A11', '05'),
('A14', 'Manuel Amarillo', '2000-09-01', 'A11', NULL);

INSERT INTO poyectos VALUES
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
SELECT e.nombre
FROM empleado e
JOIN proy