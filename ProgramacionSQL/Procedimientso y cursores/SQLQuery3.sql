USE tienda_informatica;
GO

--Ejercicio 01

ALTER PROC totalProductos AS
BEGIN
	DECLARE @total INT = (SELECT COUNT(codigo)
							FROM producto)

	PRINT 'En la base de datos hay ' + CAST(@total AS NVARCHAR(10)) + ' productos.'
END

EXEC totalProductos;

--Ejercicio 02

ALTER PROC valorMedio
@id_Fabricante INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @valorMedio DECIMAL(10,2) = (SELECT AVG(precio)
							FROM producto
							WHERE cod_fabricante = @id_Fabricante);
	PRINT 'El precio medio de los productos del fabricante ' + CAST(@id_Fabricante AS NVARCHAR(10)) + ' es: ' + CAST(@valorMedio AS NVARCHAR(10));
END

EXEC valorMedio @id_Fabricante = 2;

--Ejercicio 03

CREATE PROC valorMax
@id_Fabricante INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @valorMax DECIMAL(10,2) = (SELECT MAX(precio)
										FROM producto
										WHERE cod_fabricante = @id_Fabricante);

	PRINT 'El precio máximo de los productos del fabricante ' + CAST(@id_Fabricante AS NVARCHAR(2)) + ' es: ' + CAST(@valorMax AS NVARCHAR(10));
END

EXEC valorMax @id_Fabricante = 3;



--Ejercicios cursores

USE jardineriav2;

--Ejercicio 01





ALTER PROC ejercicio01
	@pais NVARCHAR(100)
	AS
	BEGIN
	DECLARE cursor_ejercicio01 CURSOR FOR
	SELECT
		cliente.codigo_cliente,
		cliente.nombre_cliente,
		cliente.telefono,
		cliente.ciudad
	FROM cliente
	WHERE cliente.pais = @pais;

	DECLARE @codigo INT,
		@nombre NVARCHAR(100),
		@telefon NVARCHAR(20),
		@ciuda NVARCHAR(20);

	OPEN cursor_ejercicio01;
	FETCH NEXT FROM cursor_ejercicio01 INTO @codigo, @nombre, @telefon, @ciuda
		IF (@@FETCH_STATUS = 0)
		BEGIN
			WHILE @@FETCH_STATUS = 0
			BEGIN
				PRINT 'Código: ' + CAST(@codigo AS NVARCHAR(10)) +
					  ', Nombre: ' + @nombre + 
					  ', Teléfono: ' + @telefon +
					  ', Ciudad: ' + @ciuda;
				FETCH NEXT FROM cursor_ejercicio01 INTO @codigo, @nombre, @telefon, @ciuda
			END
			CLOSE cursor_ejercicio01;
			DEALLOCATE cursor_ejercicio01;
		END
		ELSE
			PRINT 'No hay clientes en ' + @pais;
	END
	
EXEC ejercicio01 @pais='Spain';

--Ejercicio 02

ALTER PROC ejercicio02
	@metodoPago NVARCHAR(100)
	AS
	BEGIN
		DECLARE @mensaje NVARCHAR(500) = 'No se encontraron pagos realizados mediante ' + @metodoPago,
				@maxPago FLOAT,
				@nombreCompleto NVARCHAR(200),
				@fechaPago DATE,
				@codTransaccion NVARCHAR(150);

		IF NOT EXISTS(SELECT codigo_pago
						FROM pago
						WHERE forma_pago = @metodoPago)
			BEGIN
				THROW 50001, @mensaje, 1;
				RETURN;
			END
		DECLARE cursor_ejercicio02 CURSOR FOR
		SELECT TOP 1
			MAX(linea_pedido.precio_unidad * linea_pedido.cantidad) AS maxt, 
			CONCAT(cliente.nombre_cliente, ' ', cliente.apellido_contacto),
			pago_pedido.fecha_pago,
			pago_pedido.id_transaccion
			FROM linea_pedido
			INNER JOIN pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
			INNER JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
			INNER JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
			INNER JOIN pago ON pago_pedido.codigo_pago = pago.codigo_pago
			WHERE pago.forma_pago = @metodoPago
			GROUP BY cliente.nombre_cliente, cliente.apellido_contacto, pago_pedido.fecha_pago, pago_pedido.id_transaccion
			ORDER BY maxt DESC;
		OPEN cursor_ejercicio02
		FETCH NEXT FROM cursor_ejercicio02 INTO @maxPago, @nombreCompleto, @fechaPago, @codTransaccion
		IF(@@FETCH_STATUS = 0)
			BEGIN
				WHILE @@FETCH_STATUS = 0
				BEGIN
					PRINT 'El pago de máximo valor realizado con la forma de pago ' + @metodoPago + ' es de ' + CAST(@maxPago AS NVARCHAR(20)) + ' Euros.';
					PRINT 'CLiente: ' + @nombreCompleto;
					PRINT 'Fecha de pago: ' + CAST(@fechaPago AS NVARCHAR(20));
					PRINT 'ID de transacción: ' + @codTransaccion;
					FETCH NEXT FROM cursor_ejercicio02 INTO @maxPago, @nombreCompleto, @fechaPago, @codTransaccion
				END
				CLOSE cursor_ejercicio02;
				DEALLOCATE cursor_ejercicio02;
			END
		ELSE
			PRINT 'No se encontraron pagos realizados mediante ' + @metodoPago;
	END

EXEC ejercicio02 @metodoPago = 'Criptomonedas';

--Ejercicio 03

ALTER PROC ejercicio03
	@metodoPago NVARCHAR(100)
	AS
	BEGIN
		DECLARE @mensaje NVARCHAR(500) = 'No se encontraron pagos realizados mediante ' + @metodoPago,
				@maxPago DECIMAL(10,2),
				@minPago DECIMAL(10,2),
				@avgPago DECIMAL(10,2),
				@sumTotal DECIMAL(10,2),
				@numPagos INT;
		IF NOT EXISTS(SELECT pago.codigo_pago
						FROM pago
						WHERE pago.forma_pago = @metodoPago)
			BEGIN
				THROW 50001, @mensaje, 1;
				RETURN;
			END 
		DECLARE cursor_ejercicio03 CURSOR FOR
		SELECT
			MAX(suma), 
			MIN(suma),
			AVG(suma),
			SUM(suma),
			COUNT(suma)
			FROM (
				SELECT
				SUM(linea_pedido.precio_unidad * linea_pedido.cantidad) AS suma
				FROM linea_pedido
				INNER JOIN pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
				INNER JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
				WHERE pago_pedido.codigo_pago IN(
												SELECT codigo_pago
												FROM pago
												WHERE forma_pago = @metodoPago)
				GROUP BY pago_pedido.id_transaccion) as sub;
		OPEN cursor_ejercicio03
		FETCH NEXT FROM cursor_ejercicio03 INTO @maxPago, @minPago, @avgPago, @sumTotal, @numPagos
		IF(@numPagos <> 0)
		BEGIN
			IF(@@FETCH_STATUS = 0)
				BEGIN
					WHILE @@FETCH_STATUS = 0
					BEGIN
						PRINT 'Estadísticas para la forma de pago: ' + @metodoPago;
						PRINT '---------------------------------------------------';
						PRINT 'Pago de máximo valor: ' + CAST(@maxPago AS NVARCHAR(30)) + ' Euros';
						PRINT 'Pago de mínimo valor: ' + CAST(@minPago AS NVARCHAR(30)) + ' Euros';
						PRINT 'Valor medio de los pagos: ' + CAST(@avgPago AS NVARCHAR(30)) + ' Euros';
						PRINT 'Suma total de los pagos: ' + CAST(@sumTotal AS NVARCHAR(30)) + ' Euros';
						PRINT 'Número de pagos realizados: ' + CAST(@numPagos AS NVARCHAR(10));
						FETCH NEXT FROM cursor_ejercicio03 INTO @maxPago, @minPago, @avgPago, @sumTotal, @numPagos
					END
				END
		CLOSE cursor_ejercicio03;
		DEALLOCATE cursor_ejercicio03;
		END
		ELSE
			BEGIN
				CLOSE cursor_ejercicio03;
				DEALLOCATE cursor_ejercicio03;
				PRINT 'No se encontraron pagos realizados mediante ' + @metodoPago;
			END
	END

EXEC ejercicio03 @metodoPago = 'Trueque';

--Ejercicio 04

CREATE OR ALTER PROC ejercicio04 
@codigoPedido INT
AS
	BEGIN
		DECLARE @mensaje NVARCHAR(100) = 'El pedido especificado no existe',
		@fechaPedido NVARCHAR(30),
		@fechaEsperada NVARCHAR(30),
		@fechaEntrega NVARCHAR(30),
		@estado NVARCHAR(50),
		@comentario NVARCHAR(200),
		@nombreCliente NVARCHAR(100),
		@formaPago NVARCHAR(50),
		@codigoLinea INT,
		@nombreProducto NVARCHAR(50),
		@cantidadProducto INT,
		@precioUnidad DECIMAL(10,2),
		@totalLinea DECIMAL(10,2);

		IF NOT EXISTS(SELECT codigo_pedido
						FROM pedido
						WHERE codigo_pedido = @codigoPedido)
			BEGIN
				THROW 50001, 'El pedido esperado no existe',1;
				RETURN;
			END

		DECLARE bodyPedido CURSOR FOR
			SELECT
				CAST(pedido.fecha_pedido AS NVARCHAR(30)),
				CAST(pedido.fecha_esperada AS NVARCHAR(30)),
				ISNULL(CAST(pedido.fecha_entrega AS NVARCHAR(30)), 'No entregado'),
				pedido.estado,
				ISNULL(pedido.comentarios, 'Ninguno'),
				CONCAT(cliente.nombre_cliente, '  ', cliente.nombre_contacto, ' ', cliente.apellido_contacto),
				pago.forma_pago
			FROM pedido
			INNER JOIN cliente ON pedido.codigo_cliente = cliente.codigo_cliente
			INNER JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
			INNER JOIN pago ON pago_pedido.codigo_pago = pago.codigo_pago
			WHERE pedido.codigo_pedido = @codigoPedido;

		DECLARE lineaPedido CURSOR FOR
			SELECT
				linea_pedido.numero_linea,
				producto.nombre,
				linea_pedido.cantidad,
				linea_pedido.precio_unidad,
				(linea_pedido.precio_unidad * linea_pedido.cantidad)
				FROM linea_pedido
				INNER JOIN producto ON producto.codigo_producto = linea_pedido.codigo_producto
				INNER JOIN pedido ON pedido.codigo_pedido = linea_pedido.codigo_pedido
				WHERE pedido.codigo_pedido = @codigoPedido;

		OPEN bodyPedido
		OPEN lineaPedido
		FETCH NEXT FROM bodyPedido INTO @fechaPedido, @fechaEsperada, @fechaEntrega, @estado, @comentario, @nombreCliente, @formaPago
		IF(@@FETCH_STATUS = 0)
			BEGIN
				PRINT 'Datos del pedido:';
				PRINT '-----------------';
				PRINT 'Código de pedido: ' + CAST(@codigoPedido AS NVARCHAR(10));
				PRINT 'Fecha de pedido: ' + @fechaPedido;
				PRINT 'Fecha esperada: ' + @fechaEsperada;
				PRINT 'Fecha de entrega: ' + @fechaEntrega;
				PRINT 'Estado: ' + CAST(@estado AS NVARCHAR(30));
				PRINT 'Comentarios: ' + CAST(@comentario AS NVARCHAR(200));
				PRINT 'Cliente: ' + @nombreCliente;
				PRINT 'Forma de pago: ' +  @formaPago;
				PRINT ' ';
				PRINT 'Líneas del pedido:';
				PRINT '------------------';
				PRINT 'Número de línea | Nombre del producto | Cantidad | Precio por unidad | Total de la línea';
				PRINT '----------------------------------------------------------------------------------------';
					FETCH NEXT FROM lineaPedido INTO @codigoLinea, @nombreProducto, @cantidadProducto, @precioUnidad, @totalLinea

					IF(@@FETCH_STATUS = 0)
						BEGIN
							WHILE(@@FETCH_STATUS = 0)
							BEGIN
								PRINT CAST(@codigoLinea AS NVARCHAR(20)) + ' | ' + @nombreProducto + ' | ' + CAST(@cantidadProducto AS NVARCHAR(10)) + ' | ' + CAST(@precioUnidad AS NVARCHAR(20))
								+ ' Euros | ' + CAST(@totalLinea AS NVARCHAR(20)) + ' Euros'
								FETCH NEXT FROM lineaPedido INTO @codigoLinea, @nombreProducto, @cantidadProducto, @precioUnidad, @totalLinea
							END
						CLOSE lineaPedido;
						DEALLOCATE lineaPedido;
						END
						FETCH NEXT FROM bodyPedido INTO @fechaPedido, @fechaEsperada, @fechaEntrega, @estado, @comentario, @nombreCliente, @formaPago
			END
		CLOSE bodyPedido;
		DEALLOCATE bodyPedido;
	END

EXEC ejercicio04 @codigoPedido = 8;


--Universidad

USE universidad;

--Ejercicio 01

CREATE PROC uni01
@nombre NVARCHAR(50),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@departament NVARCHAR(50)
AS
BEGIN
	DECLARE @codigodept INT = (SELECT id
								FROM departamento
								WHERE nombre = @departament),

			@codigoprof INT = (SELECT id
								FROM persona
								WHERE nombre = @nombre
								AND apellido1 = @apellido1
								AND apellido2 = @apellido2),

			@sexoprof NVARCHAR(2) = (SELECT sexo
									FROM persona
									WHERE nombre = @nombre
									AND apellido1 = @apellido1
									AND apellido2 = @apellido2);
	UPDATE profesor
	SET id_departamento = @codigodept
	WHERE id_profesor = @codigoprof;

	IF(@sexoprof = 'M')
		PRINT 'La profesora ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2 + ' ha sido asignada al departamento "' + @departament + '".';
	ELSE
		PRINT 'El profesor ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2 + ' ha sido asignado al departamento "' + @departament + '".';
	
END

EXEC uni01 @nombre = 'David', @apellido1 = 'Schmidt', @apellido2 = 'Fisher', @departament = 'Informática';

