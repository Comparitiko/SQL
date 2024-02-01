USE relacion1;

/*3.- Mostrar todos los nombres de los alumnos con sus teléfonos.*/
SELECT nom_al, telf_al FROM alumnos;

/*4.- Mostrar los nombres de los alumnos ordenados en orden creciente y decreciente.*/
SELECT nom_al FROM alumnos
ORDER BY nom_al DESC;

SELECT nom_al FROM alumnos
ORDER BY nom_al ASC;

/* 5.- Mostrar los alumnos ordenados por edad. */
SELECT * FROM alumnos
ORDER BY fech_al ASC;

/* 6.- Mostrar nombre de alumnos que contengan alguna ‘A’ en el nombre. */
SELECT nom_al AS nombre FROM alumnos
WHERE nom_al LIKE 'A%';

/* 7.- Mostrar id_al ordenado por nota. */
SELECT id_al AS ID from relacion
ORDER BY nota;

/* 8.- Mostrar nombre alumno y nombre de sus respectivos profesores. */
SELECT a.nom_al AS nombre_alumno, p.nom_prof AS nombre_profesor
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof = r.id_prof;

/* 9.- Mostrar el nombre de los alumnos que les de clase el profesor P01 */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof = "P01";

/* 10.- Mostrar el nombre y la nota de los alumnos que les de clase el profesor ‘FERNAND0 GARCIA’. */
SELECT a.nom_al AS nombre_alumno, r.nota
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.nom_prof = "FERNANDO GARCIA";

/* 11.- Mostrar todos los alumnos (codigo) que hayan aprobado con el profesor P01. */
SELECT a.id_al AS id_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof = "P01"
WHERE r.nota >= 5;

/* 12.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor P01. */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof = "P01"
WHERE r.nota >= 5;

/* 13.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor ‘CARMEN TORRES’. */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.nom_prof = "CARMEN TORRES"
WHERE r.nota >= 5;

/* 14.- Mostrar el alumno/s que haya obtenido la nota más alta con ‘P01’ */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof = "P01"
ORDER BY r.nota DESC
LIMIT 1;

/* 15.- Mostrar los alumnos (nombre y codigo) que hayan aprobado todo.  */
SELECT DISTINCT a.id_al AS id_alumno, a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON r.id_al = a.id_al
WHERE NOT EXISTS (
	SELECT 1 FROM relacion r2
    WHERE r2.id_al = a.id_al AND r2.nota < 5
);