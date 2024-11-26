--Hugo de Cristobal Gomez
USE relacionejer2;
--Ejercicio3
ALTER TABLE pais
ADD idRegion INT;

ALTER TABLE pais
ADD CONSTRAINT fk_region_pais FOREIGN KEY(idRegion) REFERENCES region(idRegion);