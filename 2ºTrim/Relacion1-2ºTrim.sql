--Hugo de Crist�bal G�mez
USE instituto;

--Ejercicio1

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Laura', 'G�mez', 'Garc�a', '2000-03-15', 'no', 654987321);

--Ejercicio2

DELETE FROM alumno
WHERE tel�fono = 692735409;

--Ejercicio3

UPDATE alumno
SET es_repetidor = 'no'
WHERE nombre = 'Irene'
AND apellido1 = 'Guti�rrez'
AND apellido2 = 'S�nchez';

--Ejercicio4

INSERT INTO alumno(nombre,apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Carlos', 'L�pez', 'Mart�nez', '1997-05-10', 's�', NULL);

--Ejercicio5

DELETE FROM alumno
WHERE id = 3;

--Ejercicio6

UPDATE alumno
SET tel�fono = 699123456
WHERE nombre = 'Cristina'
AND apellido1 = 'Fern�ndez'
AND apellido2 = 'Ram�rez';

--Ejercicio7

INSERT INTO alumno ( nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Ra�l', 'S�nchez', 'Ruiz', '1995-12-25', 'no', 622345678)

--Ejercicio8

DELETE FROM alumno
WHERE tel�fono is NULL;

--Ejercicio9

UPDATE alumno
SET apellido1 = 'Sancho'
WHERE apellido1 = 'S�nchez';

--Ejercicio10

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Ana', 'Torres', 'Garc�a', '1999-11-30', 's�', 697654321)

--Ejercicio11

DELETE alumno
WHERE es_repetidor = 's�';

--Ejercicio12

UPDATE alumno
SET nombre = 'David'
WHERE id = 10;

--Ejercicio13

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Marta', 'P�rez', 'L�pez', '1993-08-20', 'no', 634567890);

--Ejercicio14

DELETE alumno
WHERE fecha_nacimiento < '1990-01-01';

--Ejercicio15

UPDATE alumno
SET tel�fono = 600000000
WHERE tel�fono = 'NULL';

--Ejercicio16

INSERT INTO alumno ( nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Javier', 'Rodr�guez', 'Garc�a', '1992-01-05', 'no', NULL);

--Ejercicio17

DELETE alumno
WHERE nombre = 'Antonio';

--Ejercicio18

UPDATE alumno
SET es_repetidor = 's�'
WHERE fecha_nacimiento > '1995-01-01';

--Ejercicio19

INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono)
VALUES ('Sof�a', 'Mart�nez', 'Ruiz', '1998-10-10', 's�', 609876543);

--Ejercicio20

DELETE alumno
WHERE apellido2 = 'Ortega';	

SELECT * FROM alumno;