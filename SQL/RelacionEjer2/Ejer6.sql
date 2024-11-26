--Hugo de Cristobal Gomez
--Ejercicio6
CREATE TABLE trabajador(
idTrabajador NVARCHAR(9),
nombreTrabajador NVARCHAR(200) NOT NULL,
apellido1Trabajador NVARCHAR(200) NOT NULL,
apellido2Trabajador NVARCHAR(200) NOT NULL,
fechaNacTrabajador DATE NOT NULL,
CONSTRAINT pk_idTrabajador PRIMARY KEY(idTrabajador));