--Hugo de Cristóbal Gómez
USE grandes_almacenes;

--Ejercicio1
ALTER TABLE venta
DROP CONSTRAINT fk_venta_cajero;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_cajero FOREIGN KEY (cajero) REFERENCES cajero(codigo) ON DELETE CASCADE;

DELETE cajero
WHERE codigo = 1;

--Ejercicio2
ALTER TABLE venta
DROP CONSTRAINT fk_venta_producto;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_producto FOREIGN KEY(producto) REFERENCES producto(codigo) ON DELETE CASCADE;


DELETE producto
WHERE precio > 100;

--Ejercicio3

DELETE maquina_registradora
WHERE piso = 2;

--Ejercicio4
DELETE cajero
WHERE codigo = 2;

--Ejercicio5

DELETE producto
WHERE nombre LIKE 'C%';

--Ejercicio6

DELETE cajero
WHERE nombrecompleto LIKE 'Kumar%';

--Ejercicio7

DELETE producto
WHERE precio BETWEEN 50 AND 150;

--Ejercicio8

DELETE maquina_registradora
WHERE piso BETWEEN 3 AND 4;

--Ejercicio9

DELETE venta
WHERE producto = 5
AND maquina = 3;

SELECT * FROM maquina_registradora;
SELECT * FROM producto;
SELECT * FROM cajero;
SELECT * FROM venta;