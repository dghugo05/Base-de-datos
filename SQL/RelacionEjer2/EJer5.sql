--Hugo de Cristobal Gomez
--Ejercicio5
CREATE TABLE trabajo(
idTrabajo NVARCHAR(10),
nombreTrabajo NVARCHAR(35) NOT NULL,
salarioMin DECIMAL(10,2) NOT NULL,
salarioMax DECIMAL(10,2) NOT NULL,
CONSTRAINT ch_salarioMax_trabajo CHECK(salarioMax<=25000),
CONSTRAINT pk_idTrabajo PRIMARY KEY(idTrabajo));