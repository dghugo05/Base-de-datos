--Hugo de Cristobal Gomez
--Ejercicio11

CREATE TABLE recinto(
codigo_Recinto INT IDENTITY(1,1),
nombre_Recinto NVARCHAR(50) NOT NULL,
direccion_Recinto NVARCHAR(50) NOT NULL,
ciudad_Recinto NVARCHAR(50) NOT NULL,
telefono_Recinto INT NOT NULL,
horario_Recinto TIME NOT NULL,
CONSTRAINT pk_codRecinto PRIMARY KEY(codigo_Recinto));

CREATE TABLE espectador(
DNI_Espectador NVARCHAR(9),
nombre_Espectador NVARCHAR(50) NOT NULL,
direccion_Espectador NVARCHAR(50) NOT NULL,
telefono_Espectador INT NOT NULL,
ciudad_Espectador NVARCHAR(50) NOT NULL,
CONSTRAINT pk_dniEspectador PRIMARY KEY(DNI_Espectador));

CREATE TABLE espectaculo(
codigo_Espectaculo INT IDENTITY(1,1),
nombre_Espectaculo NVARCHAR(50) NOT NULL,
tipo_Espectaculo NVARCHAR(50) NOT NULL,
fechaInicio_Espectaculo DATE NOT NULL,
fechaFinal_Espectaculo DATE NOT NULL,
interprete_Espectaculo NVARCHAR(50) NOT NULL,
codigo_Recinto INT,
CONSTRAINT pk_codigoEspectaculo PRIMARY KEY(codigo_Espectaculo),
CONSTRAINT fk_espectaculo_recinto FOREIGN KEY(codigo_Espectaculo) REFERENCES recinto(codigo_Recinto));

CREATE TABLE representacion(
codigo_Representacion INT IDENTITY(1,1),
codigo_Espectaculo INT NOT NULL,
fecha_Representacion DATE NOT NULL,
hora_Representacion TIME NOT NULL,
CONSTRAINT pk_codigoRepresentacion PRIMARY KEY(codigo_Representacion),
CONSTRAINT fk_representacion_espectaculo FOREIGN KEY(codigo_Espectaculo) REFERENCES espectaculo(codigo_Espectaculo));

CREATE TABLE precio_representacion(
codigo_Espectaculo INT,
codigo_Representacion INT,
pvp_Espectaculo INT,
CONSTRAINT pk_precioRepresentacion PRIMARY KEY(codigo_Espectaculo, codigo_Representacion),
CONSTRAINT fk_precioRepresentacion_espectaculo FOREIGN KEY(codigo_Espectaculo) REFERENCES espectaculo(codigo_Espectaculo),
CONSTRAINT fk_precioRepresentacion_representacion FOREIGN KEY(codigo_Representacion) REFERENCES representacion(codigo_Representacion));

CREATE TABLE asiento(
numero_Asiento INT,
fila_Asiento INT,
codigo_recinto INT,
CONSTRAINT pk_asiento PRIMARY KEY(numero_Asiento, fila_Asiento),
CONSTRAINT fk_asiento_recinto FOREIGN KEY(codigo_Recinto) REFERENCES recinto(codigo_Recinto));

CREATE TABLE entrada(
codigo_Entrada INT IDENTITY(1,1),
codigo_Representacion INT,
codigo_Recinto INT,
numero_Asiento INT,
fila_Asiento INT,
DNI_Espectador NVARCHAR(9),
CONSTRAINT pk_codigoEntrada PRIMARY KEY(codigo_Entrada),
CONSTRAINT fk_entrada_Representacion FOREIGN KEY(codigo_Representacion) REFERENCES representacion(codigo_Representacion),
CONSTRAINT fk_entrada_recinto FOREIGN KEY(codigo_Recinto) REFERENCES recinto(codigo_Recinto),
CONSTRAINT fk_entrada_asiento FOREIGN KEY(numero_Asiento) REFERENCES asiento(numero_Asiento),
CONSTRAINT fk_entrada_asiento FOREIGN KEY(fila_Asiento) REFERENCES asiento(fila_Asiento),
CONSTRAINT fk_entrada_dniEspectador FOREIGN KEY(DNI_Espectador) REFERENCES espectador(DNI_Espectador));

