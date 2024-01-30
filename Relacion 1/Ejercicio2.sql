USE relacion1;

INSERT INTO alumnos (id_al, nom_al, fech_al, telf_al) VALUES
('A01', 'Juan Muñoz', '1978-09-04', '676543456'),
('A02', 'ANA TORRES', '1980-12-05', '654786756'),
('A03', 'PEPE GARCIA', '1982-08-09', '950441234'),
('A04', 'JULIO GOMEZ', '1983-12-23', '678909876'),
('A05', 'KIKO ANDRADES', '1979-01-30', '666123456');

INSERT INTO profesores (id_prof, nom_prof, fech_prof, telf_prof) VALUES
("P01", "CARMEN TORRES", "1966-09-08", "654789654"),
("P02", "FERNANDO GARCIA", "1961-07-09", "656894123");

INSERT INTO relacion (id_al, id_prof, nota) VALUES
('A01', 'P01', 3.56),
('A01', 'P02', 4.57),
('A02', 'P01', 5.78),
('A02', 'P02', 7.80),
('A03', 'P01', 4.55),
('A03', 'P02', 5),
('A04', 'P02', 10),
('A05', 'P01', 2.75),
('A05', 'P02', 8.45);