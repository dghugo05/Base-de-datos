--Hugo de Cristóbal Gómez
USE relacionejer2;
--Ejercicio2
CREATE TABLE region(
idRegion INT IDENTITY(1,1),
nombreRegion NVARCHAR(300),
hemisferioRegion NVARCHAR(50),
CONSTRAINT pk_region PRIMARY KEY(idRegion),
CONSTRAINT ch_hemisferio_region CHECK(hemisferioRegion IN('NORTE', 'SUR')));