DROP DAtABASE IF EXISTS meteo;
CREATE DATABASE IF NOT EXISTS meteo;

USE meteo;

CREATE TABLE IF NOT EXISTS estacion (
	identificador INTEGER AUTO_INCREMENT PRIMARY KEY,
    latitud DOUBLE,
    longitud DOUBLE,
    altitud DOUBLE
);

CREATE TABLE IF NOT EXISTS muestra (
	identificadorEstacion INTEGER PRIMARY KEY,
    fecha DATE,
    temp_min DOUBLE,
    temp_max DOUBLE,
    precipitaciones INTEGER,
    hum_min DOUBLE,
    hum_max DOUBLE,
    vel_viento_min DOUBLE,
    vel_viento_max DOUBLE,
    FOREIGN KEY (identificadorEstacion) REFERENCES estacion(identificador)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);