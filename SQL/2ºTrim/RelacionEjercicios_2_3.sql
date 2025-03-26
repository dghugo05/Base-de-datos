--Hugo de Cristobal Gomez

USE empleados;

--Ejercicio1

SELECT apellidos FROM empleado;

--Ejercicio2

SELECT DISTINCT apellidos FROM empleado;

--Ejercicio3

SELECT * FROM empleado;

--EJercicio4

SELECT nombre, apellidos FROM empleado;

--Ejercicio5

SELECT departamento FROM empleado;

--Ejercicio6

SELECT DISTINCT departamento FROM empleado;

--Ejercicio7

SELECT CONCAT(nombre, ' ', apellidos) FROM empleado;

--Ejercicio8

SELECT UPPER(CONCAT(nombre, ' ', apellidos)) FROM empleado;

--Ejercicio9

SELECT LOWER(CONCAT(nombre, ' ', apellidos)) FROM empleado;

--Ejercicio10

SELECT dni, SUBSTRING(dni, 0, 9), SUBSTRING(dni, 9, 1) FROM empleado;

--Ejercicio11

SELECT nombre, (presupuesto - gastos) AS a FROM departamento;

--Ejercicio12

SELECT nombre, presupuesto  AS a FROM departamento
ORDER BY a ASC;

--Ejercicio13

SELECT nombre FROM departamento ORDER BY nombre;

--Ejercicio14

SELECT nombre FROM departamento ORDER BY nombre DESC;

--Ejercicio15

SELECT nombre, apellidos FROM empleado
ORDER BY apellidos ASC, nombre;

--Ejercicio16

SELECT TOP 3 nombre, presupuesto FROM departamento
ORDER BY presupuesto DESC;

--Ejercicio17

SELECT nombre, presupuesto FROM departamento
ORDER BY presupuesto;

--Ejercicio18

SELECT TOP 2 nombre, gastos FROM departamento
ORDER BY gastos DESC;

--Ejercicio19

SELECT TOP 2 nombre, gastos FROM departamento
ORDER BY gastos ASC;

--Ejercicio20
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto >= 15000;
