--Hugo de Cristobal Gomez

USE ventas;
GO

--Base Datos Ventas
--Ejercicio 01
BEGIN
	DECLARE @numComerciantes INT;
	BEGIN
		SET @numComerciantes = (SELECT COUNT(comercial.id)
										FROM comercial
										WHERE id IN (
											SELECT id_comercial
											FROM pedido
											WHERE id_cliente IN(
												SELECT id
												FROM cliente
												WHERE ciudad = 'Granada')));
		PRINT 'El número de comerciales con clientes en Granada es:' + CAST(@numComerciantes AS NVARCHAR (10))
	END
END
GO

--Ejercicio 02

BEGIN
	DECLARE @pedidoAlmeria INT;
	DECLARE @peidoAntonio INT;

	BEGIN
		SET @pedidoAlmeria = (SELECT COUNT(pedido.id)
								FROM pedido
								WHERE id_cliente IN(
								SELECT id
								FROM cliente
								WHERE ciudad = 'Almería'));
		SET @peidoAntonio = (SELECT COUNT(pedido.id)
							FROM pedido
							WHERE id_comercial IN (
								SELECT id
								FROM comercial 
								WHERE CONCAT(nombre , ' ', apellido1, ' ', apellido2) = 'Antonio Carretero Ortega'))

		PRINT 'El número de pedidos realizados por comerciales cone clientes en Almería es: ' + CAST(@pedidoAlmeria AS NVARCHAR(10))
		PRINT 'El total de los pedidos hechos por el comercial Antonio Carretero Ortega: ' + CAST(@peidoAntonio AS NVARCHAR(10))
	END
END
GO

--Ejercicio 03

BEGIN
	DECLARE @idMayorComision FLOAT;

	BEGIN
		SET @idMayorComision = (SELECT id
								FROM comercial
								WHERE comision >=(
									SELECT MAX(comision)
									FROM comercial));


		PRINT 'El código del empleado con la comisión más alta es: ' + CAST(@idMayorComision AS NVARCHAR(10))
	END
END
GO

--Ejercicio 04

BEGIN
	DECLARE @numPedidos INT;
	DECLARE @idCliente INT = 1;
	DECLARE @totalClientes INT = (SELECT COUNT(id)
									FROM cliente)
	WHILE @idCliente < @totalClientes + 1
	BEGIN
		SET @numPedidos = (SELECT COUNT(id)
							FROM pedido
							WHERE id_cliente = @idCliente);

		IF(@numPedidos > 0)
			PRINT 'El cliente con ID '+ CAST(@idCliente AS NVARCHAR(10)) + ' ha realizado ' +  CAST(@numPedidos AS NVARCHAR(10)) + ' pedidos.'
		ELSE
			PRINT 'El cliente con ID '+ CAST(@idCliente AS NVARCHAR(10)) + ' no ha realizado ningún pedido.'
		SET @idCliente = @idCliente + 1;
	END
END
GO

--Ejercicio 05

BEGIN
	DECLARE @numPedidos INT
	DECLARE @idCliente INT = 1;
	DECLARE @totalClientes INT = (SELECT COUNT(id)
									FROM cliente)
	WHILE @idCliente < @totalClientes + 1
	BEGIN
		SET @numPedidos = (SELECT COUNT(id)
							FROM pedido
							WHERE id_cliente = @idCliente);
		SELECT
			CASE
				WHEN @numPedidos = 0 THEN 'El cliente con ID '+ CAST(@idCliente AS NVARCHAR(10)) + ' es un cliente nuevo.'
				WHEN @numPedidos > 1 AND @numPedidos < 6 THEN 'El cliente con ID '+ CAST(@idCliente AS NVARCHAR(10)) + ' es un cliente ocasional.'
				ELSE 'El cliente con ID '+ CAST(@idCliente AS NVARCHAR(10)) + ' es un cliente frecuente.'
			END	AS Mensaje
		SET @idCliente = @idCliente + 1;
	END
END
GO

--Base Datos Universidad

USE universidad;
GO

--Ejercicio 06

BEGIN
	DECLARE @grado NVARCHAR(50) = 'Grado en Ingeniería Informática (Plan 2015)'
	DECLARE @numEsudiantes INT = (SELECT COUNT(DISTINCT id_alumno)
									FROM alumno_se_matricula_asignatura
									WHERE id_asignatura IN(
										SELECT id
										FROM asignatura
										WHERE id_grado IN(
											SELECT id
											FROM grado
											WHERE nombre = @grado)));
	PRINT 'Grado: Grado en ' + @grado + ' - Total de estudiantes inscritos: ' + CAST(@numEsudiantes AS NVARCHAR(10));
END
GO

--Ejercicio 07

BEGIN
	DECLARE @asignatura NVARCHAR(50) = 'Introducción a la programación'
	DECLARE @numEsudiantes INT = (SELECT COUNT(DISTINCT id_alumno)
									FROM alumno_se_matricula_asignatura
									WHERE id_asignatura IN(
										SELECT id
										FROM asignatura
										WHERE nombre = @asignatura));
	PRINT 'Asignatura: ' + @asignatura + ' - Total de estudiantes inscritos: ' + CAST(@numEsudiantes AS NVARCHAR(10));
END
GO

--Ejercicio 08

BEGIN
	DECLARE @asignatura NVARCHAR(50) = 'Introducción a la programación'
	DECLARE @mujeres INT = (SELECT COUNT(DISTINCT id_alumno)
									FROM alumno_se_matricula_asignatura
									INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
									WHERE id_asignatura IN(
										SELECT id
										FROM asignatura
										WHERE nombre = @asignatura)
									AND persona.sexo = 'M');

	DECLARE @hombres INT = (SELECT COUNT(DISTINCT id_alumno)
									FROM alumno_se_matricula_asignatura
									INNER JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
									WHERE id_asignatura IN(
										SELECT id
										FROM asignatura
										WHERE nombre = @asignatura)
									AND persona.sexo = 'H');

	DECLARE @numEsudiantes INT = (SELECT COUNT(DISTINCT id_alumno)
									FROM alumno_se_matricula_asignatura
									WHERE id_asignatura IN(
										SELECT id
										FROM asignatura
										WHERE nombre = @asignatura));

	PRINT 'Total de alumnos matriculados: ' + CAST(@numEsudiantes AS NVARCHAR(10));
	PRINT 'Total de hombres matriculados: ' + CAST(@hombres AS NVARCHAR(10));
	PRINT 'Total de mujeres matriculadas: ' + CAST(@mujeres AS NVARCHAR(10));
END
GO

--Ejercicio 09

BEGIN
	DECLARE @asignatura NVARCHAR(50) = 'Introducción a la programación';
	DECLARE @nombreProfesor NVARCHAR(50) = (SELECT CONCAT(persona.nombre, ' ', persona.apellido1, ' ', apellido2)
											FROM persona
											RIGHT JOIN profesor ON profesor.id_profesor = persona.id
											RIGHT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
											WHERE asignatura.nombre = @asignatura) 
	IF(@nombreProfesor != '')
		PRINT 'Profesor que imparte la asignatura "' + @asignatura + '": ' + @nombreProfesor
	ELSE
		PRINT 'Sin profesor'
END
GO

--EJercicio 10

BEGIN
	DECLARE @nombreAlumno NVARCHAR(50) = 'Salvador Sánchez' 
	DECLARE @Asignatura NVARCHAR(50) = 'Álgebra lineal y matemática discreta'

	IF EXISTS (SELECT @nombreAlumno
		FROM persona
		INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
		INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
		WHERE asignatura.nombre = @Asignatura)
		PRINT 'El estudiante ' +  @nombreAlumno + ' SI está matriculdo en ' + CAST(@Asignatura AS NVARCHAR(50))
	ELSE
		PRINT 'El estudiante ' + @nombreAlumno + ' NO está matriculado en ' + CAST(@Asignatura AS NVARCHAR(50))
END


