DROP DATABASE IF EXISTS ejemplo;
CREATE DATABASE IF NOT EXISTS ejemplo;

USE ejemplo;

DROP TABLE IF EXISTS holamundo

/* Crear tabla con el engine INNODB */
CREATE TABLE IF NOT EXISTS holamundo (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

/*Añadir una columna a la tabla*/
ALTER TABLE holamundo ADD descripcion VARCHAR(120) NOT NULL;

/* Modificar solo tipo de datos de un campo como puede ser de VARCHAR() a INTEGER o añadir NOT NULL*/
ALTER TABLE holamundo MODIFY descripcion INTEGER NOT NULL;

/* Cambiar nombre de la columna */
ALTER TABLE holamundo CHANGE id id_holamundo INTEGER PRIMARY KEY AUTO_INCREMENT;

/* Cambiar el default de una tabla */
ALTER TABLE holamundo ALTER descripcion SET DEFAULT 'Hola mundo';

/*Eliminar una columna de la tabla*/
ALTER TABLE holamundo DROP nombre;

/* Generar sentencia SQL para generar una tabla */
SHOW CREATE TABLE holamundo;

DESCRIBE holamundo;