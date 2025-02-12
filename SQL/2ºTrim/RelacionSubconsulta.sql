--Hugo de Cristobal Gomez
--C.F.G.S. Desarrollo de Aplicaciones Multiplataforma
--Base de datos
--2024-2025

USE NBA;
GO

--Ejercicio 01

SELECT * 
FROM jugador 
WHERE altura > (
SELECT AVG(altura)
FROM jugador);
GO

--Ejercicio 02

SELECT nombre FROM jugador
WHERE nombre_equipo IN(
	SELECT nombre
	FROM equipo
	WHERE nombre IN(
			SELECT equipo_visitante
			FROM partido
			WHERE equipo_local = 'Raptors')
		OR nombre IN (
		SELECT equipo_local
		FROM partido
		WHERE equipo_visitante = 'Raptors'))
AND codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE temporada = '98/99');

--Ejercicio 03

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE temporada = '06/07'
	AND puntos_por_partido < 15);

--Ejercicio 04

SELECT nombre 
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE temporada = '07/08'
	AND puntos_por_partido > 20)
AND nombre_equipo IN(
	SELECT nombre
	FROM equipo
	WHERE conferencia = 'East');

--Ejercicio 05

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE temporada = '05/06'
	AND tapones_por_partido > 0.8);

--Ejercicio 06

SELECT nombre
FROM jugador
WHERE altura > (
	SELECT AVG(altura)
	FROM jugador
	WHERE nombre_equipo = 'Timberwolves')

--Ejercicio 07

SELECT nombre
FROM equipo
WHERE nombre IN (
	SELECT nombre_equipo
	FROM jugador
	WHERE peso > 250)
AND nombre LIKE 'C%';

--Ejercicio 08

SELECT nombre
FROM jugador
WHERE codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido >(
		SELECT AVG(puntos_por_partido)
		FROM estadistica
		WHERE temporada = '06/07')
	AND temporada = '06/07'
		)
;

--Ejercicio 09

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE rebotes_por_partido >= 1
	AND temporada = '07/08');

--Ejercicio 10

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido >10
	AND temporada = '04/05');

--Ejercicio 11

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica	
	WHERE asistencias_por_partido < 3
	AND temporada = '03/04');

--Ejercicio 12

SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido > (
		SELECT AVG(puntos_por_partido)
		FROM estadistica
		WHERE temporada = '07/08')
	AND temporada = '07/08');

--Ejercicio 13

SELECT *
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	GROUP BY jugador 
	HAVING AVG(puntos_por_partido) >= 10)
AND nombre_equipo IN(
	SELECT nombre
	FROM equipo
	WHERE nombre IN(
		SELECT equipo_visitante
		FROM partido)
	AND conferencia = 'East')
ORDER BY codigo;

--Ejercicio 14

SELECT nombre
FROM jugador
WHERE codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE temporada = '07/08'
	GROUP BY jugador
	HAVING SUM(puntos_por_partido) > (
		SELECT AVG(puntos_por_partido)
		FROM estadistica
		WHERE temporada = '07/08'));

--Ejercicio 15

SELECT nombre
FROM jugador
WHERE codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE temporada = '05/06'
	OR temporada = '5.6'
	GROUP BY jugador
	HAVING SUM(asistencias_por_partido) < 5);

--Ejercicio 16
SELECT nombre
FROM jugador
WHERE codigo IN(
 SELECT jugador
 FROM estadistica
 WHERE puntos_por_partido >(
	SELECT AVG(puntos_por_partido)
	FROM estadistica
	WHERE jugador IN (
		SELECT codigo
		FROM jugador
		WHERE nombre_equipo IN (
			SELECT nombre
			FROM equipo
			WHERE nombre = 'Raptors'))))
ORDER BY nombre;



SELECT * FROM estadistica
WHERE jugador = 1;
SELECT * FROM equipo;

