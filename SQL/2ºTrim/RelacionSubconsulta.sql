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
FROm equipo
WHERE 