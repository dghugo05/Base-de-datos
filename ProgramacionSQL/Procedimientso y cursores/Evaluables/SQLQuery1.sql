--Hugo de Cristobal Gomez

USE universidad

--Ejercicio 01

CREATE OR ALTER PROC ejercicio01
@nombre NVARCHAR(50)
AS
BEGIN
	INSERT INTO departamento (nombre) VALUES(@nombre);
END

ejercicio01 @nombre = 'Electrónica';
SELECT * FROM departamento;


--Ejercicio 02

CREATE OR ALTER PROC ejercicio02
@nif NVARCHAR(9),
@nombre NVARCHAR(25),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@ciudad NVARCHAR(25),
@direccion NVARCHAR(50),
@telefono NVARCHAR(9),
@nacimiento DATE,
@sexo CHAR(1),
@tipo NVARCHAR(10)
AS
BEGIN
	INSERT INTO persona(nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo, tipo) VALUES(@nif, @nombre, @apellido1, @apellido2, @ciudad, @direccion, @telefono, @nacimiento, @sexo, @tipo);
END

ejercicio02 @nif = '79044053E', @nombre = 'Hugo', @apellido1 = 'de Cristóba', @apellido2 = 'Gómez', @ciudad = 'Málaga', @direccion = 'Calle Pirandello', @telefono = '690231676', @nacimiento = '2005-07-08', @sexo = 'H', @tipo = 'alumno';

SELECT * FROM persona


--Ejercicio 03

CREATE OR ALTER PROC ejercicio03
@nombre NVARCHAR(25),
@apellido1 NVARCHAR(50),
@apellido2 NVARCHAR(50),
@departamento NVARCHAR(50),
@sexo CHAR(1)
AS
BEGIN
	IF NOT EXISTS(SELECT id 
					FROM persona
					WHERE tipo = 'profesor'
					AND nombre = @nombre
					AND apellido1 = @apellido1
					AND apellido2 = @apellido2)

		IF @sexo = 'M'
			BEGIN
				THROW 50001, 'La persona no existe en la base de datos o no es una profesora.', 1;
				RETURN;
			END
		ELSE
			BEGIN
				THROW 50002, 'La persona no existe en la base de datos o no es un profesor.', 1;
				RETURN;
			END
	IF NOT EXISTS(SELECT id
					FROM departamento
					WHERE nombre = @departamento)
		BEGIN
			THROW 50003, 'El departamento no existe en la base de datos', 1;
		END

	DECLARE @id_profesor INT = (SELECT id 
								FROM persona
								WHERE tipo = 'profesor'
								AND nombre = @nombre
								AND apellido1 = @apellido1
								AND apellido2 = @apellido2),
			
			@id_departamento INT = (SELECT id
									FROM departamento
									WHERE nombre = @departamento)

	IF EXISTS(SELECT id_profesor FROM profesor WHERE id_profesor = @id_profesor)
		BEGIN
			INSERT INTO profesor(id_profesor, id_departamento) VALUES(@id_profesor, @id_departamento)
			IF @sexo = 'M'
				PRINT 'La profesora ha sido asignada al departamento correctamente.';
			ELSE
				PRINT 'El profesor ha sido asignado al departamento correctamente.';
		END
END

ejercicio03 @nombre = 'Alfredo', @apellido1 = 'Stiedemann', @apellido2 = 'Morissette', @departamento = 'Educación', @sexo = 'H';


SELECT * FROM persona WHERE id NOT IN(SELECT id_profesor
									FROm profesor)
						AND tipo = 'profesor';

SELECT * FROM profesor;

SELECT * FROM departamento;

