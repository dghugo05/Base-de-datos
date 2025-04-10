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

CREATE OR ALTER PROC uni01
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
								AND apellido2 = @apellido2
								AND tipo = 'profesor'),

			@sexoprof NVARCHAR(2) = (SELECT sexo
									FROM persona
									WHERE nombre = @nombre
									AND apellido1 = @apellido1
									AND apellido2 = @apellido2
									AND tipo = 'profesor');
	IF NOT EXISTS(SELECT id
					FROM persona
					WHERE nombre = @nombre
					AND apellido1 = @apellido1
					AND apellido2 = @apellido2
					AND tipo = 'profesor')
		BEGIN
			THROW 50001, 'El profesor o profesora no existe en la base de datos.', 1;
			RETURN;
		END
	IF NOT EXISTS(SELECT id
				FROM departamento
				WHERE nombre = @departament)
		BEGIN
			THROW 50002, 'El departamento especificado no existe.', 1;
			RETURN;
		END
	UPDATE profesor
	SET id_departamento = @codigodept
	WHERE id_profesor = @codigoprof;

	IF(@sexoprof = 'M')
		PRINT 'La profesora ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2 + ' ha sido asignada al departamento "' + @departament + '".';
	ELSE
		PRINT 'El profesor ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2 + ' ha sido asignado al departamento "' + @departament + '".';
	
END

EXEC uni01 @nombre = 'David', @apellido1 = 'Schmidt', @apellido2 = 'Fisher', @departament = 'Electrónica';


--Ejercicio 02

CREATE OR ALTER PROC uni02 
@nombre_grado NVARCHAR(200)
AS
BEGIN 
	DECLARE @nombre_asig NVARCHAR(200),
		@creditos INT,
		@tipo NVARCHAR(50),
		@curso INT,
		@cuatrimestre INT

	IF NOT EXISTS(SELECT id
				FROM grado
				WHERE nombre = @nombre_grado)
		BEGIN
			THROW 50001, 'El grado especificado no existe', 1;
			RETURN;
		END

	DECLARE cursor_uni02 CURSOR FOR
		SELECT nombre, creditos, tipo, curso, cuatrimestre
		FROM asignatura
		WHERE id_grado IN(
						SELECT id
						FROM grado
						WHERE nombre = @nombre_grado)
		GROUP BY nombre, creditos, tipo, curso, cuatrimestre
		ORDER BY curso, cuatrimestre;
	
	OPEN cursor_uni02;
	FETCH NEXT FROm cursor_uni02 INTO @nombre_asig, @creditos, @tipo, @curso, @cuatrimestre
	IF(@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Asignaturas del grado "' +  @nombre_grado + '":';
		WHILE(@@FETCH_STATUS = 0)
			BEGIN
				PRINT 'Asignatura :' + @nombre_asig + ', créditos: ' + CAST(@creditos AS NVARCHAR(10)) + ', tipo: ' + @tipo + ', curso: ' + CAST(@curso AS NVARCHAR(10)) + ', cuatrimestre: ' + CAST(@cuatrimestre AS NVARCHAR(10));
				FETCH NEXT FROm cursor_uni02 INTO @nombre_asig, @creditos, @tipo, @curso, @cuatrimestre;
			END
	END
	CLOSE cursor_uni02;
	DEALLOCATE cursor_uni02;
END

EXEC uni02 @nombre_grado = 'Grado en Ingeniería Informática (Plan 2015)';


--Pelicuilas

USE peliculas;

--Ejercicio 01

CREATE OR ALTER PROC peli01
@año INT
AS
BEGIN
	
	DECLARE @titulo NVARCHAR(100),
		@duracion INT,
		@fecha DATE

	IF NOT EXISTS(SELECT peli_id
					FROM pelicula
					WHERE peli_anio = @año)
		BEGIN
			PRINT 'No se encontraron películas para el año ' + CAST(@año AS NVARCHAR(10));
			RETURN;
		END

	DECLARE cursor_peli01 CURSOR FOR
		SELECT peli_titulo, peli_duracion, peli_estreno
		FROm pelicula
		WHERE peli_anio = @año;

	OPEN cursor_peli01
	FETCH NEXT FROM cursor_peli01 INTO @titulo, @duracion, @fecha

	IF(@@FETCH_STATUS = 0)
		BEGIN
			PRINT 'Películas del año ' + CAST(@año AS NVARCHAR(10)) + ':';

			WHILE(@@FETCH_STATUS = 0)
				BEGIN
					PRINT 'Título: ' + @titulo + ',año de estreno: ' + CAST(@año AS NVARCHAR(10)) + ', duración: ' + CAST(@duracion AS NVARCHAR(20)) + ', fecha de estreno: ' + CAST(@fecha AS NVARCHAR(100))
					FETCH NEXT FROM cursor_peli01 INTO @titulo, @duracion, @fecha
				END
		END
		CLOSE cursor_peli01;
		DEALLOCATE cursor_peli01;
END

EXEC peli01 @año = 1950


--Ejercicio 02

CREATE OR ALTER PROC peli02
@genero NVARCHAR(50)
AS
BEGIN
	
	DECLARE @numero_pelis INT = (SELECT COUNT(gen_id)
								FROM peli_genero
								WHERE gen_id IN(SELECT gen_id
												FROM genero
												WHERE gen_titulo = @genero)),
			@titulo_peli NVARCHAR(100),
			@año INT,
			@duracion INT

	IF NOT EXISTS(SELECT gen_id
					FROM genero
					WHERE gen_titulo = @genero)
		BEGIN
			THROW 50001, 'El género especificado no existe.', 1;
			RETURN;
		END

	DECLARE cursor_peli02 CURSOR FOR
		SELECT peli_titulo, peli_anio, peli_duracion
		FROM pelicula
		WHERE peli_id IN(SELECT peli_id
					FROM peli_genero
					WHERE gen_id IN(SELECT gen_id
									FROM genero
									WHERE gen_titulo = @genero))
		GROUP BY peli_titulo, peli_anio, peli_duracion
		ORDER BY peli_titulo DESC
	OPEN cursor_peli02;
	FETCH NEXT FROM cursor_peli02 INTO @titulo_peli, @año, @duracion
	
	IF(@@FETCH_STATUS = 0)
		PRINT 'El número de películas del género "' + @genero + '" es: ' + CAST(@numero_pelis AS NVARCHAR(10));
		PRINT 'Lista de películas del género "' + @genero + '":';

		BEGIN
			WHILE(@@FETCH_STATUS = 0)
				BEGIN
					PRINT 'Título: ' + @titulo_peli + ', Año: ' + CAST(@año AS NVARCHAR(10)) + ', Duración: ' + CAST(@duracion AS NVARCHAR(20)) + ' minutos'
					FETCH NEXT FROM cursor_peli02 INTO @titulo_peli, @año, @duracion
				END
		END
		CLOSE cursor_peli02;
		DEALLOCATE cursor_peli02;
END

EXEC peli02 @genero = 'Ciber';


--Ejercicio 03

CREATE OR ALTER PROC peli03
@director NVARCHAR(150)
AS
BEGIN
	
	DECLARE @titulo NVARCHAR(150)

	IF NOT EXISTS(SELECT dir_id
					FROM director
					GROUP BY dir_nombre, dir_apellidos, dir_id
					HAVING CONCAT(dir_nombre, ' ', dir_apellidos) = @director)
		BEGIN
			THROW 50001, 'El director especificado no existe.',1;
			RETURN;
		END

	DECLARE cursor_peli02 CURSOR FOR
		SELECT peli_titulo
		FROM pelicula
		WHERE peli_id IN(
						SELECT peli_id
						FROM peli_dir
						WHERE dir_id IN(
										SELECT dir_id
										FROM director
										GROUP BY dir_nombre, dir_apellidos, dir_id
										HAVING CONCAT(dir_nombre, ' ', dir_apellidos) = @director))

	OPEN cursor_peli02
	FETCH NEXT FROM cursor_peli02 INTO @titulo

	IF(@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Películas del director"' + @director + '":'
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			PRINT 'Título: ' + @titulo
			FETCH NEXT FROM cursor_peli02 INTO @titulo
		END
	END
	CLOSE cursor_peli02;
	DEALLOCATE cursor_peli02
END

EXEC peli03 @director = 'Corleone';


--Ejercicio 04

CREATE OR ALTER PROC peli04
@genero1 NVARCHAR(100),
@genero2 NVARCHAR(100)
AS
BEGIN
	
	DECLARE @titulo NVARCHAR(150),
	@año INT,
	@valoracion INT,
	@media_contraria DECIMAL(10,2)= (SELECT AVG(val_estrellas)
									FROM valoracion
									WHERE peli_id IN(SELECT peli_id
													FROM pelicula
													WHERE peli_id IN(
																	SELECT peli_id
																	FROM peli_genero
																	WHERE gen_id IN(
																					SELECT gen_id
																					FROM genero
																					WHERE gen_titulo = 'Drama'))))

	IF NOT EXISTS(SELECT gen_id
					FROM genero
					WHERE gen_titulo = @genero1)
		BEGIN
			THROW 50001, 'El primer género no existe en la base de datos', 1;
			RETURN;
		END
	IF NOT EXISTS(SELECT gen_id
					FROM genero
					WHERE gen_titulo = @genero2)
		BEGIN
			THROW 50002, 'El segundo género no existe en la base de datos', 1;
			RETURN;
		END
	
	DECLARE cursor_peli04 CURSOR FOR
	SELECT pelicula.peli_titulo, pelicula.peli_anio, valoracion.val_estrellas
	FROM pelicula
	INNER JOIN valoracion ON valoracion.peli_id = pelicula.peli_id
	INNER JOIN peli_genero ON peli_genero.peli_id = pelicula.peli_id
	INNER JOIN genero ON genero.gen_id = peli_genero.gen_id
	WHERE genero.gen_titulo = @genero1
	AND valoracion.val_estrellas > @media_contraria
	GROUP BY pelicula.peli_titulo, pelicula.peli_anio, valoracion.val_estrellas
	ORDER BY pelicula.peli_titulo

	OPEN cursor_peli04;
	FETCH NEXT FROM cursor_peli04 INTO @titulo, @año, @valoracion

	IF(@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Películas del género ' + @genero1 + ' con valoración superior a la media del género ' + @genero2 + ' (' + CAST(@media_contraria AS NVARCHAR(10)) + '):';
		PRINT '-------------------------------------------------------------';

		WHILE(@@FETCH_STATUS = 0)
		BEGIN 
			PRINT 'Título: ' + @titulo + ', Año: ' + CAST(@año AS NVARCHAR(20)) + ', Valoración: ' + CAST(@valoracion AS NVARCHAR(10));
			FETCH NEXT FROM cursor_peli04 INTO @titulo, @año, @valoracion
		END
	END
	CLOSE cursor_peli04;
	DEALLOCATE cursor_peli04;
END

EXEC peli04 @genero1 = 'Acción', @genero2 = 'Ciber';


--Ejercicio 05

CREATE OR ALTER PROC peli05
@nombre_actor NVARCHAR(50),
@apellido_actor NVARCHAR(50)
AS
BEGIN
	
	DECLARE @titulo NVARCHAR(50),
	@papel NVARCHAR(50)

	IF NOT EXISTS(SELECT act_id
					FROM actor
					WHERE act_nombre = @nombre_actor
					AND act_apellidos = @apellido_actor)
	BEGIN
		THROW 50001, 'El actor no existe en la base de datos.', 1;
		RETURN;
	END

	DECLARE cursor_peli05 CURSOR FOR
	SELECT pelicula.peli_titulo, peli_elenco.papel
	FROM pelicula
	INNER JOIN peli_elenco ON peli_elenco.peli_id = pelicula.peli_id
	INNER JOIN actor ON peli_elenco.act_id = actor.act_id
	WHERE actor.act_nombre = @nombre_actor
	AND actor.act_apellidos = @apellido_actor

	OPEN cursor_peli05;
	FETCH NEXT FROM cursor_peli05 INTO @titulo, @papel

	IF(@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Papeles interpretados por ' + @nombre_actor + ' ' + @apellido_actor + ':'
		PRINT '-------------------------------------------------------------------------------------';

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			PRINT 'Película: ' + @titulo + ', Papel: ' + @papel;
			FETCH NEXT FROM cursor_peli05 INTO @titulo, @papel
		END
	END
	CLOSE cursor_peli05;
	DEALLOCATE cursor_peli05;
END

EXEC peli05 @nombre_actor = 'Tom', @apellido_actor = 'Hank';


--Ejercicio 06

CREATE OR ALTER PROC peli06
@peli NVARCHAR(200)
AS
BEGIN
	
	DECLARE @actor NVARCHAR(100),
	@papel NVARCHAR(100)

	IF NOT EXISTS(SELECT peli_id
					FROM pelicula
					WHERE peli_titulo = @peli)
		BEGIN
			THROW 50001, 'La película no existe en la base de datos.', 1;
			RETURN;
		END

	DECLARE cursor_peli06 CURSOR FOR
	SELECT CONCAT(actor.act_nombre, ' ', actor.act_apellidos), peli_elenco.papel
	FROM pelicula
	INNER JOIN peli_elenco ON peli_elenco.peli_id = pelicula.peli_id
	INNER JOIN actor ON peli_elenco.act_id = actor.act_id
	WHERE pelicula.peli_titulo = @peli

	OPEN cursor_peli06;
	FETCH NEXT FROM cursor_peli06 INTO @actor, @papel

	IF(@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Lista de actores de ' + @peli;

		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			PRINT '	Actor: ' + @actor + ', Papel: ' + @papel
			FETCH NEXT FROM cursor_peli06 INTO @actor, @papel
		END
	END
	CLOSE cursor_peli06;
	DEALLOCATE cursor_peli06;
END

EXEC peli06 @peli = 'Avengers: Endgame'

SELECT * FROM critico
SELECT * FROM valoracion
SELECT * FROM pelicula
SELECT * FROM actor
SELECT * FROM peli_elenco