--Hugo de Cristobal Gomez
--Ejercicio11

--El orden de las tablas van desde las que no tienen claves foraneas hasta las que necesitan de varias tablas para las claaves foraneas.
CREATE TABLE recinto(
--He elgido el tipo INT IDENTITY para crear un codigo que no se puede repetir.
codigo_Recinto INT IDENTITY(1,1),
--He elegido el tipo NVARCHAR de 50 caracteres para cualquier nombre.
nombre_Recinto NVARCHAR(50) NOT NULL,
--Utilizo NVARCHAR de 50 caracteres para que me quepan las direcciones, incluso las mas largas.
direccion_Recinto NVARCHAR(50) NOT NULL,
--Utilizo NVARCHAR de 50 caracteres para guardar correctamente el nombre de cualquier ciudad.
ciudad_Recinto NVARCHAR(50) NOT NULL,
--Utilizo el INT porque el numero de telefono solo posee numeros.
telefono_Recinto INT NOT NULL,
--Utilizo TIME porque el horario sera la comprension de 2 rangos de horas.
horario_Recinto TIME NOT NULL,
--Utilizo un CONSTRAINT de UNIQUE porque el numero telefonico es unico para cada persona.
CONSTRAINT uq_telefonoRecinto UNIQUE(telefono_Recinto),
--Utilizo una restriccion pk porque codigo_Recinto es la clave primaria de la tabla recinto.
CONSTRAINT pk_codRecinto PRIMARY KEY(codigo_Recinto));

CREATE TABLE espectador(
--Utilizo NVARCHAR de 9 caraacteres porque el DNI son una combinacion de numeros y una letra que siempre es de 9 caracteres.
DNI_Espectador NVARCHAR(9),
--Utilizo NVARCHAR porque el nombre es un cadena de caracteres.
nombre_Espectador NVARCHAR(50) NOT NULL,
--Utilizo NVARCHAR de 50 caracteres para que me quepan las direcciones, incluso las mas largas.
direccion_Espectador NVARCHAR(50) NOT NULL,
--Utilizo el INT porque el numero de telefono solo posee numeros.
telefono_Espectador INT NOT NULL,
--Utilizo NVARCHAR de 50 caracteres para guardar correctamente el nombre de cualquier ciudad.
ciudad_Espectador NVARCHAR(50),
--Utilizo INT porque este atributo solo guarda los numeros de una tarjeta.
numero_Tarjeta INT NOT NULL,
--Utilizo una restriccion pk porque DNI_Espectador es la clave primaria de la tabla espectador.
CONSTRAINT pk_dniEspectador PRIMARY KEY(DNI_Espectador));

CREATE TABLE espectaculo(
--He elgido el tipo INT IDENTITY para crear un codigo que no se puede repetir.
codigo_Espectaculo INT IDENTITY(1,1),
--He elegido el tipo NVARCHAR de 50 caracteres para cualquier nombre.
nombre_Espectaculo NVARCHAR(50) NOT NULL,
--He elegido el tipo NVARCHAR para guardar nombre del tipo de espectaculo.
tipo_Espectaculo NVARCHAR(50) NOT NULL,
--Utilizo el tipo DATE pra guardar la fecha en la que empieza el espectaculo.
fechaInicio_Espectaculo DATE NOT NULL,
--Utilizo el tipo DATE pra guardar la fecha en la que termina el espectaculo.
fechaFinal_Espectaculo DATE NOT NULL,
--utilizo el tipo NVARCHAR pra guardar el nombre del interprete del espectaculo.
interprete_Espectaculo NVARCHAR(50) NOT NULL,
--Esta es la clave foranea con el mismo tipo de dato que el atributo al que referencia.
codigo_Recinto INT,
--He creado una restriccion pk para codigo_Espectaculo porque es la clave primaria de la tabla espectaculo.
CONSTRAINT pk_codigoEspectaculo PRIMARY KEY(codigo_Espectaculo),
--He creado una restriccion de tipo fk, porque codigo_Recinto es la clave foranea de la tabla espectaculo que referencia la clave primaria de la tabla recinto.
CONSTRAINT fk_espectaculo_recinto FOREIGN KEY(codigo_Espectaculo) REFERENCES recinto(codigo_Recinto));

CREATE TABLE representacion(
--He elgido el tipo INT IDENTITY para crear un codigo que no se puede repetir.
codigo_Representacion INT IDENTITY(1,1),
--Esta es la clave foranea con el mismo tipo de dato que el atributo al que referencia.
codigo_Espectaculo INT,
--Utilizo el tipo DATE pra guardar la fecha en la que se realiza la representacion.
fecha_Representacion DATE NOT NULL,
--Utilizo TIME para recoger la hora de la representacion
hora_Representacion TIME NOT NULL,
--Creo una restriccion pk para el atributo codigo_Representacion porque es la clave primaria de la tabla representacion.
CONSTRAINT pk_codigoRepresentacion PRIMARY KEY(codigo_Representacion),
--Creo una restriccion fk para el atributo codigo_Espectaculo porque es la clave foranea de la tabla representacionq que hace referencia al atributo codigo_Espectaculo de la tabla espectaculo.
CONSTRAINT fk_representacion_espectaculo FOREIGN KEY(codigo_Espectaculo) REFERENCES espectaculo(codigo_Espectaculo));

CREATE TABLE precio_representacion(
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
codigo_Espectaculo INT,
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
codigo_Representacion INT,
--Utilizo el tipo DECIMAL para guardar el precio del espectaculo teniendo este 8 digitos y 2 decimales, con un DEFAULT de 10 en caso de que no se introduzca ningun dato.
pvp_Espectaculo DECIMAL(10,2) DEFAULT(10) NOT NULL,
--Creo una restriccion pk para el atributo codigo_espectaculo y codigo_Representacion porque son las claves primarias de la tabla precio_representacion.
CONSTRAINT pk_precioRepresentacion PRIMARY KEY(codigo_Espectaculo, codigo_Representacion),
--Creo una restriccion fk para el atributo codigo_Espectaculo porque referencia al atributo codigo_Espectaculo de la tabla espectaculo.
CONSTRAINT fk_precioRepresentacion_espectaculo FOREIGN KEY(codigo_Espectaculo) REFERENCES espectaculo(codigo_Espectaculo),
--Creo una restriccion fk para el atributo codigo_Representacion porque referencia al atributo codigo_Representacion de la tabla representacion.
CONSTRAINT fk_precioRepresentacion_representacion FOREIGN KEY(codigo_Representacion) REFERENCES representacion(codigo_Representacion),
--Creo una restriccion ch pra el atributo pvp_Espectaculo, indicancdo que el dato introducido no puede ser menor o igual a 0.
CONSTRAINT ch_pvpEspectaculo CHECK(pvp_Espectaculo > 0));

CREATE TABLE asiento(
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
numero_Asiento INT,
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
fila_Asiento INT,
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
codigo_recinto INT,
--Creo una restriccion pk para los atributos numero_Asientos y fila_Asientos porque son las claves primarias.
CONSTRAINT pk_asiento PRIMARY KEY(numero_Asiento, fila_Asiento),
--Creo una restriccion fk para el atributo codigo_Recinto porque hace referencia al atributo codigo_Recinto en la tabla recinto
CONSTRAINT fk_asiento_recinto FOREIGN KEY(codigo_Recinto) REFERENCES recinto(codigo_Recinto));

CREATE TABLE entrada(
--He elgido el tipo INT IDENTITY para crear un codigo que no se puede repetir.
codigo_Entrada INT IDENTITY(1,1),
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
codigo_Representacion INT,
--Esta es una clave foranea y usa el tipo de dato INT como el atributo al que hace referencia.
codigo_Recinto INT,
--Utilizo el tipo INT para guardar el numero de asiento.
numero_Asiento INT,
--Utilizo el tipo INT para guardar la fila de asiento.
fila_Asiento INT,
--Esta es una clave foranea y usa el tipo de dato NVARCHAR como el atributo al que hace referencia.
DNI_Espectador NVARCHAR(9),
--Creo una restriccion pk para el atributo codigo_Entrada porque es la clave primaria.
CONSTRAINT pk_codigoEntrada PRIMARY KEY(codigo_Entrada),
--Creo una restriccion fk para el atributo codigo_Representacion porque hace referencia al atributo codigo_Representacion de la tabla representacion.
CONSTRAINT fk_entrada_Representacion FOREIGN KEY(codigo_Representacion) REFERENCES representacion(codigo_Representacion),
--Creo una restriccion fk para el atributo codigo_Recinto porque hace referencia al atributo codigo_Recinto de la tabla reinto.
CONSTRAINT fk_entrada_recinto FOREIGN KEY(codigo_Recinto) REFERENCES recinto(codigo_Recinto),
--Creo una restriccion fk para el atributo DNI_Espectador porque hace referencia al atributo DNI_Espectador de la tabla espectador
CONSTRAINT fk_entrada_dniEspectador FOREIGN KEY(DNI_Espectador) REFERENCES espectador(DNI_Espectador),
--Creo una restriccion fk para el atributo numero_Asiento porque hace referencia al atributo numero_Asiento de la tabla asiento.
CONSTRAINT fk_entrada_asiento_numeroAsiento FOREIGN KEY(numero_Asiento) REFERENCES asiento(numero_Asiento),
--Creo una restriccion fk para el atributo fila_Asiento porque hace referencia al atributo fila_Asiento de la tabla asiento.
CONSTRAINT fk_entrada_asiento_fila_Asiento FOREIGN KEY(fila_Asiento) REFERENCES asiento(fila_Asiento));





