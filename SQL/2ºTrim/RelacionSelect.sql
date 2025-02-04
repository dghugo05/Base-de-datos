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
SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama = 'Ornamentales'
AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;
GO

--Ejercicio 06
SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas 
FROM cliente
WHERE ciudad = 'Madrid'
AND (codigo_empleado_rep_ventas = 11 OR 
codigo_empleado_rep_ventas = 30);
GO

--Ejercicio 07

SELECT cliente.nombre_cliente, nombre_completo_empleado = CONCAT(empleado.nombre, ' ', empleado.apellido1, ' ', empleado.apellido2), oficina.ciudad
FROM cliente
INNER JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
INNER JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina;
GO

--Ejercicio 08

SELECT cliente.nombre_cliente, fecha_entrega, fecha_esperada
FROM pedido
INNER JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE DATEDIFF(DAY, fecha_esperada, fecha_entrega) >= 2
ORDER BY YEAR(fecha_entrega) ASC;
GO

--Ejercicio 09

SELECT oficina.linea_direccion1, oficina.linea_direccion2, oficina.ciudad
FROM oficina
INNER JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.ciudad = 'Fuenlabrada';
GO

--Ejercicio 10

SELECT cliente.nombre_cliente, producto.gama
FROM cliente
INNER JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto = producto.codigo_producto
GROUP BY cliente.nombre_cliente, producto.gama
ORDER BY gama ASC, nombre_cliente ASC;

--Ejercicio 11

SELECT oficina.codigo_oficina, oficina.ciudad, oficina.pais
FROM oficina
INNER JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
INNER JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
INNER JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
INNER JOIN linea_pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
INNER JOIN producto ON linea_pedido.codigo_producto = producto.codigo_producto
WHERE producto.gama = 'Frutales'
GROUP BY oficina.codigo_oficina, oficina.ciudad, oficina.pais;
GO

--Ejercicio 12

SELECT empleado.* 
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_empleado_rep_ventas IS NULL;
GO

--Ejercicio 13

SELECT CONCAT(empleado.nombre, ', ', empleado.apellido1, ', ', empleado.apellido2) AS nombre_empleado, CONCAT(jefe.nombre, ', ', jefe.apellido1, ', ', jefe.apellido2) AS nombre_jefe , CONCAT(jefe_jefe.nombre, ', ', jefe_jefe.apellido1, ', ', jefe_jefe.apellido2) AS nombre_jefe_jefe 
FROM empleado
LEFT JOIN empleado jefe ON empleado.codigo_jefe = jefe.codigo_empleado
LEFT JOIN empleado jefe_jefe ON jefe.codigo_jefe = jefe_jefe.codigo_empleado;
GO
