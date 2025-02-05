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
AND nombre_equipo = 'Timberwolves';

--Ejercicio 07 

SELECT * FROM estadistica;

