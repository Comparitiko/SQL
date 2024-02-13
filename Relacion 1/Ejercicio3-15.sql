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
WHERE nom_al LIKE '%A%';

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
WHERE r.id_prof LIKE 'P01';

/* 10.- Mostrar el nombre y la nota de los alumnos que les de clase el profesor ‘FERNAND0 GARCIA’. */
SELECT a.nom_al AS nombre_alumno, r.nota
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.nom_prof = "FERNANDO GARCIA";

/* 11.- Mostrar todos los alumnos (codigo) que hayan aprobado con el profesor P01. */
SELECT id_al
FROM relacion
WHERE nota >= 5
AND id_prof LIKE 'P01';

/* 12.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor P01. */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
WHERE r.nota >= 5
AND r.id_prof LIKE 'P01';

/* 13.- Mostrar todos los alumnos (nombre) que hayan aprobado con el profesor ‘CARMEN TORRES’. */
SELECT a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
JOIN profesores p ON p.id_prof LIKE r.id_prof
WHERE r.nota >= 5
AND nom_prof LIKE 'Carmen Torres';

/* 14.- Mostrar el alumno/s que haya obtenido la nota más alta con ‘P01’ */
SELECT a.nom_al AS nombre_alumno, r.nota, r.id_prof
FROM alumnos a
JOIN relacion r ON a.id_al = r.id_al
WHERE r.id_prof LIKE 'P01'
AND r.nota = (
	SELECT max(nota) FROM relacion WHERE id_prof LIKE "P01"
);

/* 15.- Mostrar los alumnos (nombre y codigo) que hayan aprobado todo.  */
SELECT DISTINCT a.id_al AS id_alumno, a.nom_al AS nombre_alumno
FROM alumnos a
JOIN relacion r ON r.id_al = a.id_al
WHERE NOT EXISTS (
	SELECT 1 FROM relacion r2
    WHERE r2.id_al = a.id_al AND r2.nota < 5
);

/* Media de nota de los alumnos con cada profesor*/
SELECT ROUND(AVG(r.nota), 1) AS media_notas, p.nom_prof
FROM relacion r
JOIN profesores p ON p.id_prof LIKE r.id_prof
GROUP BY p.nom_prof;

/* Media de nota de los alumnos */
SELECT AVG(nota) AS media_notas, id_al
FROM relacion
GROUP BY id_al;

SELECT AVG(nota) AS media_notas, id_al
FROM relacion
GROUP BY id_al
HAVING AVG(nota) >= 7;

/* Mostrar nombre profesor o profesores ue tengan la mayor cantidad de alumnos*/
SELECT p.nom_prof, COUNT(r.id_al)
FROM profesores p
JOIN relacion r ON r.id_prof LIKE p.id_prof
GROUP BY p.nom_prof
HAVING COUNT(r.id_al) > 3
AND COUNT(id_al) = (
		SELECT COUNT(id_al)
        FROM relacion
        GROUP BY id_prof
		ORDER BY COUNT(id_al) DESC
		LIMIT 1
);

/* Mostrar nombre profesores que tengan mas de 3 alumnos */
SELECT p.nom_prof, COUNT(r.id_al)
FROM profesores p
JOIN relacion r ON r.id_prof LIKE p.id_prof
GROUP BY p.nom_prof
HAVING COUNT(r.id_al) > 3;