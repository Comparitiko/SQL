DROP DATABASE IF EXISTS relacion1;
CREATE DATABASE IF NOT EXISTS relacion1;

USE relacion1;

CREATE TABLE IF NOT EXISTS alumnos (
	id_al CHAR(3) PRIMARY KEY,
    nom_al VARCHAR(40),
    fech_al DATE,
    telf_al VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS profesores (
	id_prof CHAR(3) PRIMARY KEY,
    nom_prof VARCHAR(40),
    fech_prof DATE,
    telf_prof VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS relacion (
	id_al CHAR(3),
    id_prof CHAR(3),
    nota DOUBLE,
    PRIMARY KEY(id_al, id_prof),
    FOREIGN KEY (id_al) REFERENCES alumnos(id_al),
    FOREIGN KEY (id_prof) REFERENCES profesores(id_prof)
)
