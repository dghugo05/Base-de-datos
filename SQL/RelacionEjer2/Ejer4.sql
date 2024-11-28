--Hugo de Cristobal Gomez
USE relacionejer2;
--Ejercicio4
ALTER TABLE pais
ADD CONSTRAINT ch_nombrepais_pais CHECK(nombrePais IN('Italia','India','China'));