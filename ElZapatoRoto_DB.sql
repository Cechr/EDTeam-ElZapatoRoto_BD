/*==============================================================*/
/* Nombre del DBMS:      MySQL 8.0                              */
/* Fecha de creación:    05/06/2020 10:00:00 a. m.              */
/* Autor:   			 Carlos Eduardo Chan Rodríguez          */
/* Notas:    			 Sé que al tio* Alexys le gusta más		*/
/*						 PostgreSQL, perdón =)					/*
/*						 *Con todo cariño y respeto.           	*/
/*==============================================================*/

CREATE DATABASE ElZapatoRoto_DB;

USE ElZapatoRoto_DB;

CREATE TABLE inventario (
	id_inventario int PRIMARY KEY AUTO_INCREMENT,
	id_producto int NOT NULL, 
	tipoMovimiento boolean NOT NULL, /* Se utiliza un valor booleano ya que sólo existen 2 estados posibles: 1= Entrada y 2= Salida */
	fecha date NOT NULL,
	hora time NOT NULL, /* Se agregó este campo para mejorar la precisión de los datos y la integridad del registro */
	cantidad int NOT NULL,
	razon text DEFAULT "VENTA" NOT NULL /* Se agregó este campo para una mejor comprensión de los eventos ocurridos */
);

CREATE TABLE productos (
	id_producto int PRIMARY KEY AUTO_INCREMENT,
	nombre varchar(30) NOT NULL, 
	presentacion varchar(25) NOT NULL,
	valor DECIMAL(7,2) NOT NULL,
	existencia int NOT NULL, /* Se agregó este campo para saber la disponibilidad del producto*/
	estatus boolean DEFAULT 1 NOT NULL /* Se agregó este campo por si ocurre que ya no se maneja el producto y no borrar el registro*/
);

/* Se crea esta nueva tabla para cumplir con la 3era forma normal del proceso de normalización de la BD*/
CREATE TABLE detallesFacturas (
	id_detalleFactura int NOT NULL, /* Este campo hace referencia a la llave primaria de la tabla facturaciones */
	id_producto int NOT NULL, 
	cantidad int NOT NULL, /* Registro de los productos comprados */
	impuesto DECIMAL(7,2) NOT NULL, /* El valor del IVA en Perú es del 18%, valor constante a menos que cambie las reglas del negocio */
	descuento DECIMAL(7,2) NOT NULL, /* Puede ser variable y se aplica después de agregar el impuesto a la compra total */
	valorPagar DECIMAL(7,2) NOT NULL /* Valor final despúes de los impuestos y descuento correspondiente */
);

CREATE TABLE facturaciones (
	id_factura int PRIMARY KEY AUTO_INCREMENT,
	id_cliente int NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL, /* Se agregó este campo para mejorar la precisión de los datos y la integridad del registro */
	valorTotal DECIMAL(7,2) DEFAULT 0.00 NOT NULL /* Suma total de los valores a pagar registrados en los detalles de la Factura*/
);

CREATE TABLE clientes (
	id_cliente int PRIMARY KEY AUTO_INCREMENT,
	codigoISO char(2) NOT NULL,
	identificacion char(10) NOT NULL, /*La restricción de carácteres se creó tomando en cuenta la nomenclatura utilizada en Perú*/
	nombre varchar(25) NOT NULL,
	apellidos varchar(50) NOT NULL /* Se agregó este campo para mejorar la precisión de los datos y la integridad del registro */
);

CREATE TABLE paises (
	codigoISO char(2) PRIMARY KEY CHECK (CHAR_LENGTH(codigoISO)=2), /* Se utiliza la nomenclatura ISO 3166-1 como PK ya que cumple con los requerimientos*/
	nombre varchar(20) NOT NULL
);

ALTER TABLE inventario
	ADD CONSTRAINT FK_inventario_eferences_productos FOREIGN KEY(id_producto)
	REFERENCES productos(id_producto)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE detallesFacturas
	ADD CONSTRAINT FK_detallesFacturas_references_facturaciones FOREIGN KEY(id_detalleFactura)
	REFERENCES facturaciones(id_factura)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE detallesFacturas
	ADD CONSTRAINT FK_detallesFacturas_references_productos FOREIGN KEY(id_producto)
	REFERENCES productos(id_producto)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE facturaciones
	ADD CONSTRAINT FK_facturaciones_references_clientes FOREIGN KEY(id_cliente)
	REFERENCES clientes(id_cliente)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

ALTER TABLE clientes
	ADD CONSTRAINT FK_clientes_references_paises FOREIGN KEY(codigoISO)
	REFERENCES paises(codigoISO)
		ON UPDATE CASCADE
		ON DELETE CASCADE;

/* 
   Creación del Trigger para llevar el registro de los productos en el inventario.
   Descripción: Cada vez que se añada en la tabla productos un nuevo registro por automático se deduce que es una adquisición y de las 
   misma manera se lleva el registro en el inventario.

   Nota: De la misma manera se podrían crear algunas funciones o procedimientos almacenados.
*/

delimiter |
CREATE TRIGGER Productos_Modificacion
	AFTER INSERT
	ON productos
	FOR EACH ROW
BEGIN
	INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (NEW.id_producto, 1, CURDATE(), CURTIME(), NEW.existencia, 'ADQUISICION');
END;
|
delimiter ;