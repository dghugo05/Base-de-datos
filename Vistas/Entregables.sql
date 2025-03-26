--Hugo de Cristobal Gomez

USE NBA;
GO

--Ejercicio 01

CREATE VIEW ejercicio01 AS
	SELECT equipo.nombre, COUNT(partido.equipo_local) AS victorias_local
	FROM partido
	INNER JOIN equipo ON partido.equipo_local = equipo.nombre
	WHERE puntos_local > puntos_visitante
	group by equipo.nombre;

SELECT * FROM ejercicio01;

--Ejercicio 02

CREATE VIEW ejercicio02 AS
	SELECT equipo.nombre, CAST(AVG(jugador.altura) AS decimal(10,2)) AS altura_promedio
	FROM equipo
	INNER JOIN jugador ON jugador.nombre_equipo = equipo.nombre
	GROUP BY equipo.nombre;

SELECT * FROM ejercicio02;

--Ejercicio 03

CREATE VIEW ejercicio04 AS
	SELECT equipo.nombre, COUNT(jugador.nombre_equipo) AS cantidad_jugadores
	FROM equipo
	INNER JOIN jugador ON equipo.nombre = jugador.nombre_equipo
	GROUP BY equipo.nombre
	HAVING COUNT(jugador.nombre_equipo) > 10;

SELECT * FROM ejercicio04;

--Ejercicio 04

CREATE VIEW ejercicio06 AS
	SELECT jugador.nombre, jugador.nombre_equipo, CAST(AVG(estadistica.asistencias_por_partido) AS decimal(10,2)) AS promedio_asistencias
	FROM jugador
	INNER JOIN estadistica ON jugador.codigo = estadistica.jugador
	GROUP BY jugador.nombre, jugador.nombre_equipo
	HAVING AVG(estadistica.asistencias_por_partido) > 5;

SELECT * FROM ejercicio06;
	