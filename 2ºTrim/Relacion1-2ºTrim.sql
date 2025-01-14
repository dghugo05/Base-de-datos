--Hugo de Cristóbal Gómez
USE instituto;

--Ejercicio1

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Laura', 'Gómez', 'García', '2000-03-15', 'no', 654987321);

--Ejercicio2

DELETE FROM alumno
WHERE teléfono = 692735409;

--Ejercicio3

UPDATE alumno
SET es_repetidor = 'no'
WHERE nombre = 'Irene'
AND apellido1 = 'Gutiérrez'
AND apellido2 = 'Sánchez';

--Ejercicio4

INSERT INTO alumno(nombre,apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Carlos', 'López', 'Martínez', '1997-05-10', 'sí', NULL);

--Ejercicio5

DELETE FROM alumno
WHERE id = 3;

--Ejercicio6

UPDATE alumno
SET teléfono = 699123456
WHERE nombre = 'Cristina'
AND apellido1 = 'Fernández'
AND apellido2 = 'Ramírez';

--Ejercicio7

INSERT INTO alumno ( nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Raúl', 'Sánchez', 'Ruiz', '1995-12-25', 'no', 622345678)

--Ejercicio8

DELETE FROM alumno
WHERE teléfono is NULL;

--Ejercicio9

UPDATE alumno
SET apellido1 = 'Sancho'
WHERE apellido1 = 'Sánchez';

--Ejercicio10

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Ana', 'Torres', 'García', '1999-11-30', 'sí', 697654321)

--Ejercicio11

DELETE alumno
WHERE es_repetidor = 'sí';

--Ejercicio12

UPDATE alumno
SET nombre = 'David'
WHERE id = 10;

--Ejercicio13

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Marta', 'Pérez', 'López', '1993-08-20', 'no', 634567890);

--Ejercicio14

DELETE alumno
WHERE fecha_nacimiento < '1990-01-01';

--Ejercicio15

UPDATE alumno
SET teléfono = 600000000
WHERE teléfono = 'NULL';

--Ejercicio16

INSERT INTO alumno ( nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Javier', 'Rodríguez', 'García', '1992-01-05', 'no', NULL);

--Ejercicio17

DELETE alumno
WHERE nombre = 'Antonio';

--Ejercicio18

UPDATE alumno
SET es_repetidor = 'sí'
WHERE fecha_nacimiento > '1995-01-01';

--Ejercicio19

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono)
VALUES ('Sofía', 'Martínez', 'Ruiz', '1998-10-10', 'sí', 609876543);

--Ejercicio20

DELETE alumno
WHERE apellido2 = 'Ortega';	

SELECT * FROM alumno;