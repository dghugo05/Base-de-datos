--Hugo de Cristobal Gomez
USE tienda_informatica;

--SELECT

--Ejercicio1

SELECT * FROM fabricante;

--Ejercicio2

SELECT * FROM producto;

--Ejercicio3

SELECT nombre FROM fabricante;

--Ejercicio4

SELECT nombre, precio FROM producto;

--Ejercicio5

SELECT * FROM producto
WHERE precio > 100;

--Ejercicio6

SELECT * FROM fabricante
WHERE codigo > 3;

--Ejercicio7

SELECT UPPER(nombre) AS nombre_Mayuscula, precio
FROM producto;

--Ejercicio8

SELECT LOWER(nombre) AS nombre_Minuscula, precio
FROM producto;

--Ejercicio9

SELECT nombre, UPPER(SUBSTRING(nombre, 1,2))
FROM fabricante;

--Ejercicio10

SELECT nombre, ROUND(precio, 2)
FROM producto;

--Ejercicio11

SELECT * FROM producto
WHERE precio > 100
AND precio < 200;

--Ejercicio12

SELECT * FROM fabricante
WHERE nombre LIKE 'S%';

--Ejercicio13

SELECT * FROM producto
WHERE nombre LIKE '%drive%';

--Ejercicio14

SELECT * FROM producto
WHERE precio NOT LIKE 90;

--Ejercicio15

SELECT * FROM producto
ORDER BY precio ASC;

--Ejercicio16

SELECT * FROM fabricante
ORDER BY nombre DESC;

--Ejercicio17

SELECT * FROM producto
ORDER BY nombre, precio DESC;

--Ejercicio18

SELECT * FROM fabricante
ORDER BY codigo ASC;

--Ejercicio19

SELECT * FROM producto
ORDER BY precio ASC, nombre DESC;

--Ejercicio20

SELECT precio FROM producto
GROUP BY precio;

--Ejercicio21

SELECT COUNT(codigo) AS total_productos FROM producto;

--Ejercicio22

SELECT COUNT(codigo) AS total_fabricantes FROM fabricante;

--Ejercicio13

SELECT MAX(precio) AS precio_maximo, MIN(precio) AS precio_minimo, CAST(ROUND(AVG(precio),2) AS DECIMAL(10,2)) AS precio_medio FROM producto;
