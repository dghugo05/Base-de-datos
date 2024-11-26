--Hugo de Cristobal Gomez
CREATE DATABASE relacionejer2;
USE relacionejer2;

--Ejercicio1
CREATE TABLE pais(
idPais INT IDENTITY(1,1),
nombrePais NVARCHAR(100) NOT NULL,
CONSTRAINT pk_pais PRIMARY KEY(idPais));