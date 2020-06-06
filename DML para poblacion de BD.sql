INSERT INTO paises(codigoISO, nombre) 
VALUES	('MX','México'),
		('PE','Perú'),
		('CO','Colombia'),
		('CL','Chile'),
		('BO','Bolivia');

INSERT INTO clientes(codigoISO, identificacion, nombre, apellidos) 
VALUES	('PE','46968713-3','Álvaro', 'Felipe'),
		('PE','26154879-3', 'Alexys','Lozada'),
		('BO','89562315-3', 'Beto','Quiroga'),
		('MX','84956213-3', 'Juan','Villalvazo'),
		('MX','49875621-3', 'Carlos', 'Chan');

INSERT INTO productos(nombre, presentacion, valor, existencia) 
VALUES	('Zapatillas Spalding','AZUL/ROJO', 259, 10),
		('Zapatillas El Cachorro','NEGRO', 250, 10),
		('Zapatillas Jocare','PLATA', 310, 10),
		('Zapatillas Pirma','OXFORD/BLANCO/ROJO', 266, 10),
		('Zapatillas Ferrato','NGO/NGO TEX', 300, 10);

/*==============================================================*/
/* Cosas que se tomarón en cuenta en la población de los datos: */
/* 1. El dato a registrar en la columna impuestos es el precio  */
/* del producto ya calculado con el 18%.						*/
/* 2. El descuento se aplica a después de los impuestos (Si     */
/* está mal estoy entendido en como resolverlo) 				*/
/* 3. En la colomna tipoMovimiento: 1= Entrada y 2= Salida		*/
/*==============================================================*/
		
INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(1, '2020-06-09', '08:07:00', 813.49);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(1, 1, 1, 305.62, 0.10, 275.05),
			(1, 2, 2, 590.00, 0.10, 531.00),
			(1, 4, 1, 313.88, 0.10, 282.49);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 1;
UPDATE productos SET existencia = existencia - 2 WHERE id_producto = 2;
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 4;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (1, 0, '2020-06-09', '08:07:00', 1, 'VENTA');
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (2, 0, '2020-06-09', '08:07:00', 2, 'VENTA');
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (4, 0, '2020-06-09', '08:07:00', 1, 'VENTA');

INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(5, '2020-06-10', '09:43:00', 671.42);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(2, 1, 1, 305.62, 0.00, 305.62),
		(2, 3, 1, 365.80, 0.00, 365.80);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 1;
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 3;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (1, 0, '2020-06-10', '09:43:00', 1, 'VENTA');
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (3, 0, '2020-06-10', '09:43:00', 1, 'VENTA');

INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(1, '2020-06-12', '10:34:00', 235.41);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(3, 4, 1, 313.88, 0.25, 235.41);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 4;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (4, 0, '2020-06-12', '10:34:00', 1, 'VENTA');

INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(2, '2020-06-12', '11:34:00', 235.41);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(4, 4, 1, 313.88, 0.25, 235.41);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 4;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (4, 0, '2020-06-12', '10:34:00', 1, 'VENTA');

INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(3, '2020-06-16', '13:15:00', 1062.00);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(5, 5, 3, 1062.00, 0.00, 1062.00);
UPDATE productos SET existencia = existencia - 3 WHERE id_producto = 5;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (5, 0, '2020-06-16', '13:15:00', 3, 'VENTA');
	
INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(5, '2020-07-02', '18:32:00', 272.58);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(6, 5, 1, 354.00, 0.23, 272.58);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 5;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (5, 0, '2020-07-02', '18:32:00', 1, 'VENTA');

INSERT INTO facturaciones(id_cliente, fecha, hora, valorTotal) 
VALUES	(1, '2020-07-10', '12:00:00', 354.00);
INSERT INTO detallesfacturas(id_detallefactura, id_producto, cantidad, impuesto, descuento, valorPagar) 
VALUES	(7, 5, 1, 354.00, 0.00, 354.00);
UPDATE productos SET existencia = existencia - 1 WHERE id_producto = 5;
INSERT INTO inventario(id_producto, tipoMovimiento, fecha, hora, cantidad, razon)
	VALUES (5, 0, '2020-07-10', '12:00:00', 1, 'VENTA');