--Hugo de Cristobal Gomez
--G.F.G.S Desarrollo de Aplicaciones Multiplataforma
--Bases de datos
--2024-2025

USE jardineria;
GO

--Ejercicio 01

SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';
GO

--Ejercicio 02

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'Representante Ventas';
GO

--Ejercicio 03

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(DAY, fecha_entrega, fecha_esperada) >= 2;
GO

--Ejercicio 04

SELECT codigo_pedido, codigo_cliente, fecha_pedido, estado
FROM pedido
WHERE YEAR(fecha_pedido) = '2009'
AND estado = 'Rechazado';
GO

--Ejercico 05
º1
