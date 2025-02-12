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

--Ejercicio23

SELECT MAX(precio) AS precio_maximo, MIN(precio) AS precio_minimo, CAST(ROUND(AVG(precio),2) AS DECIMAL(10,2)) AS precio_medio FROM producto;

--Ejercicio24

SELECT SUM(precio) AS total_precio FROM producto;

--Ejercicio25

SELECT COUNT(precio) AS productos_mayor_100
FROM producto
WHERE precio > 100;

--Ejercicio26

SELECT AVG(precio) AS precio_menor_200
FROM producto
WHERE precio < 200;

--Ejercicio27

SELECT SUM(precio) AS total_precios_drive
FROM producto
WHERE nombre LIKE '%drive%';

--Ejercicio28

SELECT MIN(precio) AS precio_mas_barato, MAX(precio) AS precio_mas_caro
FROM producto
WHERE cod_fabricante = 2;

--Ejercicio29

SELECT COUNT(codigo) FROM producto;

--Ejercicio30

SELECT COUNT(codigo) FROM fabricante;

--Ejercicio31

SELECT COUNT(DISTINCT cod_fabricante) FROM producto;

--Ejercicio32

SELECT AVG(precio) FROM producto;

--Ejercicio33

SELECT MIN(precio) FROM producto;

--Ejercicio34

SELECT MAX(precio) FROM producto;

--EJercicio35

SELECT TOP 1 precio, nombre FROM producto
ORDER BY precio ASC;

--Ejercicio36

SELECT TOP 1 precio, nombre FROM producto
ORDER BY precio DESC;

--Ejercicio37

SELECT SUM(precio) FROM producto;

--Ejercicio38

SELECT COUNT(precio) from producto
WHERE precio >= 180;

--JOIN

--Ejercicio1

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo;

--Ejercicio2

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

--Ejercicio3

SELECT producto.precio, producto.nombre, fabricante.codigo, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo;

--Ejercicio4

SELECT TOP 1 producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
ORDER BY precio ASC;

--Ejercicio5

SELECT TOP 1 producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
ORDER BY precio DESC;

--Ejercicio6

SELECT producto.*
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Samsung';

--Ejercicio7

SELECT producto.*
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Seagate'
AND producto.precio > 200;

--Ejercicio8

SELECT producto.*, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus'
OR fabricante.nombre = 'Hewlett-Packard'
OR fabricante.nombre = 'Seagate';

--EJercicio9

SELECT producto.*, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

--Ejercicio10

SELECT producto.nombre, producto.precio
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

--Ejercicio11

SELECT producto.nombre, producto.precio
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

--Ejercicio12

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
INNER JOIN fabricante ON producto.cod_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

--Ejercicio13

SELECT fabricante.codigo, fabricante.nombre
FROM fabricante
RIGHT JOIN producto ON producto.cod_fabricante = fabricante.codigo;

--Ejercicio14




