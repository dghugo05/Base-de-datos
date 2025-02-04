--Hugo de Cristóbal Gómez
USE instituto;

--SELECT
--Ejercicio1

SELECT * FROM alumno
WHERE id = 1;

--Ejercicio2

SELECT * FROM alumno
WHERE teléfono = 692735409;

--Ejercicio3

SELECT * FROM alumno
WHERE es_repetidor = 'sí';

--Ejercicio4

SELECT * FROM alumno
WHERE es_repetidor = 'no';

--Ejercicio5

SELECT * FROM alumno
WHERE fecha_nacimiento < '1993-01-01';

--Ejercicio6

SELECT * FROM alumno
WHERE fecha_nacimiento > '1994-01-01';

--Ejercicio7

SELECT * FROM alumno
WHERE fecha_nacimiento > '1994-01-01'
AND es_repetidor = 'no';

--Ejercicio8

SELECT * FROM alumno
WHERE fecha_nacimiento LIKE '1998%';

--Ejercicio9

SELECT * FROM alumno
WHERE fecha_nacimiento NOT LIKE '1998%';

--Ejercicio10

SELECT * FROM alumno
WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-05-31';

--Ejercicio11

SELECT Nombre, Nombre_Invertido = REVERSE(nombre) FROM alumno;

--Ejercicio12

SELECT Nombre_Completo = CONCAT(nombre, ' ', apellido1, ' ', apellido2), Nombre_Completo_Invertido = REVERSE(CONCAT(nombre, ' ', apellido1, ' ',apellido2)) FROM alumno;

--Ejercicio13

SELECT Nombre_Completo = UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)), Nombre_Completo_Invertido = LOWER(REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2))) FROM alumno;

--Ejercicio14

SELECT Nombre_Completo = CONCAT(nombre, ' ', apellido1, ' ', apellido2), Numero_Caracteres = LEN(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) FROM alumno;

--Ejercicio15

SELECT Nombre_Completo = CONCAT(nombre, ' ', apellido1, ' ', apellido2), Correo_Electronico = LOWER(CONCAT(nombre, '.', apellido1, '@ies.org')) FROM alumno;

--Ejercicio16

SELECT Nombre_Completo = CONCAT(nombre, ' ', apellido1, ' ', apellido2), Correo_Electronico = LOWER(CONCAT(nombre, '.', apellido1, '@ies.org')), Contraseña = CONCAT(REVERSE(apellido2), YEAR(fecha_nacimiento)) FROM alumno;

--Ejercicio17

SELECT fecha_nacimiento,Día = DAY(fecha_nacimiento),Mes = MONTH(fecha_nacimiento),Año = YEAR(fecha_nacimiento)FROM alumno;

--Ejercicio18

SELECT fecha_nacimiento, Nombre_Día = DATENAME(weekday, fecha_nacimiento), Nombre_mes = DATENAME(month, fecha_nacimiento) FROM alumno;

--Ejercicio19

SELECT Fecha_Nacimiento, Días_Desde_Nacimiento = DATEDIFF(DAYOFYEAR, fecha_nacimiento, GETDATE()) FROM alumno;


--GROUP BY

--Ejercicio1

SELECT es_repetidor, COUNT(es_repetidor) AS numero_alumnos
FROM alumno
GROUP BY es_repetidor;

--Ejercicio2

SELECT YEAR(fecha_nacimiento) AS año_nacimiento, COUNT(YEAR(fecha_nacimiento)) AS numero_alumnos
FROM alumno
GROUP BY YEAR(fecha_nacimiento);

--Ejercicio3

SELECT SUBSTRING(apellido1, 1, 1), COUNT(SUBSTRING(apellido1,1,1))
FROM alumno
GROUP BY SUBSTRING(apellido1,1,1);

--Ejercicio4

SELECT es_repetidor, AVG(DATEDIFF(YEAR, fecha_nacimiento, GETDATE())) AS edad_promedio
FROM alumno
GROUP BY es_repetidor;

--Ejercicio5

SELECT MONTH(fecha_nacimiento) AS mes_nacimiento, COUNT(MONTH(fecha_nacimiento)) AS numero_alumnos
FROM alumno
GROUP BY MONTH(fecha_nacimiento);

SELECT * FROM alumno;
