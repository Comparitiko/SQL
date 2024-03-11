DROP DATABASE IF EXISTS relacion6;
CREATE DATABASE IF NOT EXISTS relacion6;

USE  relacion6;

CREATE TABLE clientes (
	id_cli CHAR(3) PRIMARY KEY,
    nom_cli VARCHAR(25),
    telf_cli VARCHAR(9)
);

CREATE  TABLE alojamientos (
	id_aloj CHAR(3) PRIMARY KEY,
    nom_aloj VARCHAR(25),
    habitaciones INTEGER,
    categoria VARCHAR(5)
);

CREATE TABLE cli_aloj (
	id_cli CHAR(3),
    id_aloj CHAR(3),
    fech_entrada DATE,
    fech_salida DATE,
    precio DOUBLE,
    PRIMARY KEY (id_cli, id_aloj, fech_entrada),
    FOREIGN KEY (id_cli) REFERENCES clientes (id_cli)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (id_aloj) REFERENCES alojamientos (id_aloj)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE empleados (
	id_emp CHAR(3) PRIMARY KEY,
   nom_emp VARCHAR(25),
   sueldo DOUBLE,
   id_aloj CHAR(3),
   FOREIGN KEY (id_aloj) REFERENCES alojamientos (id_aloj)
);

INSERT INTO clientes VALUES
('C01', 'JUAN FERNÁNDEZ', '898765678'),
('C02', 'ANA GARCÍA', '678987567'),
('C03', 'PEPA FLORES', '432123456'),
('C04', 'JOSÉ LINARES', '950122145'),
('C05', 'LUIS JARCIA', '954678763'),
('C06', 'XAVI PÉREZ', '900873221'),
('C07', 'LUISA JUANES', '878909876'),
('C08', 'HILARIO PINO', '675121234'),
('C09', 'CARMEN CONSUEGRA', '123234789'),
('C10', 'VICENTA FERRER', '924866378'),
('C11', 'OLIVIA GINESA', '789123456'),
('C12', 'JUANJO DÍAZ', '911234321');

INSERT INTO alojamientos VALUES
('A01', 'TERRAZA CARMONA', 100, '***'),
('A02', 'VALLE DEL ESTE', 250, '****'),
('A03', 'HOSTAL LUCERO', 17, '**'),
('A04', 'VERA PLAYA', 350, '****'),
('A05', 'HOTEL MEXICO', 80, '****');

INSERT INTO cli_aloj VALUES
('C01', 'A01', '2013-03-01', '2013-03-10', 345),
('C02', 'A01', '2013-04-01', '2013-04-02', 60),
('C03', 'A01', '2013-03-02', '2013-03-11', 540),
('C04', 'A02', '2013-04-03', '2013-04-10', 420),
('C05', 'A02', '2013-05-04', '2013-05-10', 395),
('C06', 'A02', '2013-06-05', '2013-06-10', 145),
('C07', 'A02', '2013-07-06', '2013-07-10', 450),
('C08', 'A03', '2013-08-07', '2013-08-10', 344),
('C09', 'A03', '2013-08-08', '2013-08-10', 349),
('C10', 'A03', '2013-10-09', '2013-10-10', 145),
('C11', 'A03', '2013-11-11', '2013-11-15', 245),
('C12', 'A03', '2013-12-21', '2013-12-30', 600),
('C01', 'A04', '2013-09-05', '2013-09-07', 148),
('C02', 'A03', '2013-10-07', '2013-10-14', 849),
('C03', 'A03', '2013-03-11', '2013-03-15', 248),
('C04', 'A03', '2013-03-21', '2013-03-30', 345),
('C05', 'A01', '2013-03-11', '2013-03-19', 149),
('C06', 'A02', '2013-06-21', '2013-06-30', 315),
('C01', 'A01', '2013-01-11', '2013-01-20', 319),
('C03', 'A04', '2014-02-14', '2014-02-16', 200),
('C04', 'A05', '2014-02-14', '2014-02-16', 300),
('C09', 'A05', '2014-03-07', '2014-03-09', 400);

INSERT INTO empleados VALUES
('E01', 'MANUEL MURCIA', 1400, 'A01'),
('E02', 'GINÉS ASENSIO FERNÁNDEZ', 1500, 'A01'),
('E03', 'BALTASAR PARRA GIMÉNEZ', 950, 'A02'),
('E04', 'ROSA PÉREZ GARCÍA', 1300, 'A03'),
('E05', 'JOSÉ MIGUEL MARTÍNEZ CANO', 1150, 'A04'),
('E06', 'ANTONIO FERNÁNDEZ SOTO', 1200, 'A05'),
('E07', 'ANA GARCÍA GIMÉNEZ', 1100, 'A04'),
('E08', 'MARÍA CAPARROS GÓMEZ', 1300, 'A04'),
('E09', 'ALICIA FLORES DÍAZ', 1500, 'A05');

/* 1. Nombre de los alojamientos de cuatro estrellas que tienen mayor número de
habitaciones. */


/*
2. Datos de los empleados cuyo sueldo está comprendido entre 900 y 1200 euros
ordenados de mayor a menor sueldo.
3. Datos de los empleados cuyo sueldo es mayor que la media de todos los
empleados.
4. Nombre de los clientes que se han hospedado en el Alojamiento Vera Playa.
5. Nombres de los clientes y dinero total que se han gastado en alojarse.
6. Nombre de los alojamientos y fechas en los que ha estado hospedado el cliente
XAVI PÉREZ, ordenado por el nombre del hotel.
7. Datos del cliente/s que más establecimientos ha visitado.
8. Listado de alojamientos, donde aparezca el nombre de cada alojamiento y el
dinero que ha ganado en los hospedajes ordenados por nombre del alojamiento.
9. El nombre del empleado y nombre del alojamiento en que trabaja el empleado
que menor sueldo tiene.
10. Nombre del alojamiento o alojamientos con mayor número de empleados.
11. Listado que contenga la media del sueldo de los empleados por cada
alojamiento. Donde aparezca la media del sueldo y el nombre del alojamiento.
12. El sueldo de los empleados que trabajan en el alojamiento HOSTAL LUCERO
se incrementa en un 20% (es decir se actualiza la tabla empleados).
13. El alojamiento Terraza Carmona reduce el número de habitaciones a 75.
14. Añade un nuevo empleado con los datos que tu quieras menos el sueldo que
será la media de todos empleados que ya tenemos y el número de empleado que
será ‘E10’.
15. Borra los empleados que trabajen en Terraza Carmona.
*/
