--Ejerciico 01

CREATE PROC hola AS
BEGIN
	PRINT '¡Hola mundo!';
END
EXEC hola;
GO

--Ejercicio 02 y 03

CREATE PROC numeroReal
@num INT,
@salida NVARCHAR(500) OUTPUT
AS
BEGIN
	IF(@num < 0)
		SET @salida = CAST(@num AS NVARCHAR(10)) + ' es negativo';
	ELSE
		IF(@num = 0)
			SET @salida = 'El número es 0';
		ELSE
			SET @salida = CAST(@num AS NVARCHAR(10)) + ' es positivo';
END
BEGIN
	DECLARE @mensaje NVARCHAR(500);
	EXEC numeroReal @num = -2, @salida = @mensaje OUTPUT;
	PRINT @mensaje;
END

--Ejercicio 04, 05 y 06

ALTER PROC calc
@notas INT,
@mensaje NVARCHAR (100) OUTPUT
AS
BEGIN
	SET @mensaje = CASE
		WHEN @notas >= 0 AND @notas < 5 THEN CAST(@notas AS NVARCHAR(10)) + ': Insuficiente'
		WHEN @notas >= 5 AND @notas < 6 THEN CAST(@notas AS NVARCHAR(10)) + ': Aprobado'
		WHEN @notas >= 6 AND @notas < 7 THEN CAST(@notas AS NVARCHAR(10)) + ': Bien'
		WHEN @notas >= 7 AND @notas < 9 THEN CAST(@notas AS NVARCHAR(10)) + ': Notable'
		WHEN @notas >= 9 AND @notas <= 10 THEN CAST(@notas AS NVARCHAR(10)) + ': Sobresaliente'
		ELSE CAST(@notas AS NVARCHAR(10)) + ': Introduzca una nota válida'
	END
END

BEGIN
	DECLARE @contador INT = 0;
	DECLARE @salida NVARCHAR(100);
	WHILE @contador <= 11
	BEGIN
		EXEC calc @notas = @contador, @mensaje = @salida OUTPUT
		PRINT @salida;
		SET @contador = @contador + 1;
	END
END

--Ejercicio 07

CREATE PROC dia
@num INT,
@dia NVARCHAR(100) OUT
AS
BEGIN
	SET @dia = CASE
				WHEN @num = 1 THEN 'Lunes'
				WHEN @num = 2 THEN 'Martes'
				WHEN @num = 3 THEN 'Miércoles'
				WHEN @num = 4 THEN 'Jueves'
				WHEN @num = 5 THEN 'Viernes'
				WHEN @num = 6 THEN 'Sábado'
				WHEN @num = 7 THEN 'Domingo'
				ELSE 'Introduzca un valor válido'
	END
END
BEGIN
	DECLARE @contador INT = 1;
	DECLARE @salida NVARCHAR(100);
	WHILE @contador <= 8
	BEGIN
		EXEC dia @num = @contador, @dia = @salida OUTPUT
		PRINT @salida;
		SET @contador = @contador + 1;
	END
END

--Ejercicio 08

CREATE PROC parImpar
@num INT,
@mensaje NVARCHAR(8) OUT
AS
BEGIN
	IF(@num % 2 = 0)
		SET @mensaje = 'Par'
	ELSE
		SET @mensaje = 'Impar'
END
BEGIN
	DECLARE @contador INT = 0;
	DECLARE @salida NVARCHAR(100);
	WHILE @contador <= 11
	BEGIN
		EXEC parImpar @num = @contador, @mensaje = @salida OUTPUT
		PRINT @salida;
		SET @contador = @contador + 1;
	END
END

--Ejercicio 09

CREATE PROC mayor
@num1 INT,
@num2 INT,
@num3 INT,
@mensaje NVARCHAR (100) OUT
AS
BEGIN
	SET @mensaje = CASE
					WHEN @num1 > @num2 AND @num1 > @num3 THEN CAST(@num1 AS NVARCHAR(100))
					WHEN @num2 > @num1 AND @num2 > @num3 THEN CAST(@num2 AS NVARCHAR(100))
					WHEN @num3 > @num1 AND @num3 > @num2 THEN CAST(@num3 AS NVARCHAR(100))
	END
END
BEGIN
	DECLARE @salida NVARCHAR(100)
	EXEC mayor @num1 = 1, @num2 = 3, @num3 = 2, @mensaje = @salida OUT
	PRINT @salida
END