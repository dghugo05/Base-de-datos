--Hugo de Cristobal Gomez
--Ejercicio10

CREATE TABLE pub(
codigo NVARCHAR(50),
nombre NVARCHAR(50) NOT NULL,
licencia_Fiscal NVARCHAR(50) NOT NULL,
domicilio NVARCHAR(100),
fecha_Apertura DATE NOT NULL,
horario NVARCHAR(50) NOT NULL,
codigo_Localidad INT,
CONSTRAINT pk_codigo PRIMARY KEY(codigo),
CONSTRAINT ch_horario CHECK(horario IN('HORARIO1','HORARIO2','HORARIO3')),
CONSTRAINT fk_pub_localidad FOREIGN KEY(codigo_localidad) REFERENCES localidad(codigo_Localidad));

CREATE TABLE titular(
DNI_Titular NVARCHAR(9),
nombre NVARCHAR(50) NOT NULL,
domicilio NVARCHAR(100),
codigo_Pub NVARCHAR(50),
CONSTRAINT pk_dniTitular PRIMARY KEY(DNI_Titular),
CONSTRAINT fk_titular_pub FOREIGN KEY(codigo_Pub) REFERENCES pub(codigo));

CREATE TABLE empleado(
DNI_Empleado NVARCHAR(9),
nombre NVARCHAR(50) NOt NULL,
domicilio NVARCHAR(100),
CONSTRAINT pk_dniEmpleado PRIMARY KEY(DNI_Empleado));

CREATE TABLE articulo(
codigo_Articulo NVARCHAR(50),
nombre NVARCHAR(50) NOT NULL,
cantidad INT NOT NULL,
precio INT NOT NULL,
codigo_Pub NVARCHAR(50),
CONSTRAINT pk_codigoArticulo PRIMARY KEY(codigo_Articulo),
CONSTRAINT ch_articulo_precio CHECK(precio > 0));

CREATE TABLE localidad(
codigo_Localidad INT,
nombre NVARCHAR(50) NOT NULL,
CONSTRAINT pk_codigoLocalidad PRIMARY KEY(codigo_Localidad));

CREATE TABLE pub_empleado(
codigo_Pub NVARCHAR(50),
DNI_Empleado NVARCHAR(9),
funcion NVARCHAR(50),
CONSTRAINT fk_pubEmpleado_pub FOREIGN KEY(codigo_Pub) REFERENCES pub(codigo),
CONSTRAINT fk_pubEmpleado_empleado FOREIGN KEY(DNI_Empleado) REFERENCES empleado(DNI_Empleado),
CONSTRAINT pk_pubEmpleado PRIMARY KEY(funcion, codigo_Pub, DNI_Empleado),
CONSTRAINT ch_pubEmpleado_funcion CHECK(funcion IN('CAMARERO','SEGURIDAD','LIMPIEZA')));