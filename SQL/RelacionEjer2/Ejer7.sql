--Hugo de Cristobal Gomez
--Ejercicio7
CREATE TABLE historial_trabajos(
idTrabajador NVARCHAR(9),
idTrabajo NVARCHAR(10),
fecha_comienzo DATE NOT NULL,
fecha_finalizacion DATE NOT NULL,
CONSTRAINT fk_trabajador_historialTrabajos FOREIGN KEY(idTrabajador) REFERENCES trabajador(idTrabajador) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fk_trabajo_historialTrabajos FOREIGN KEY(idTrabajo) REFERENCES trabajo(idTrabajo) ON UPDATE CASCADE ON DELETE CASCADE);