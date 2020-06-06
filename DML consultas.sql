/* CONSULTAS: */

/* CONSULTA 1: Consulta la facturación de un cliente en específico*/
SELECT *
FROM facturaciones AS f
	  JOIN clientes AS c ON c.id_cliente = f.id_cliente
WHERE c.id_cliente = 1 AND c.nombre = 'Álvaro';

/* CONSULTA 2: Consulta la facturación de un producto en específico*/
SELECT *
FROM facturaciones AS f
	  JOIN detallesFacturas AS dF ON dF.id_detalleFactura = f.id_factura
	  JOIN productos AS p ON p.id_producto = dF.id_producto
WHERE p.id_producto = 5 AND p.nombre = 'Zapatillas Ferrato';

/* CONSULTA 3: Consulta la facturación de un rango de fechas*/
SELECT *
FROM facturaciones AS f
WHERE f.fecha BETWEEN '2020-06-06' AND '2020-06-30';

/* CONSULTA 4: De la facturación, consulta los clientes únicos (es decir, se requiere el listado de los clientes que han comprado por lo menos una vez, pero en el listado no se deben repetir los clientes)*/
SELECT DISTINCT(CONCAT(c.nombre, ' ', c.apellidos)) AS 'Clientes Únicos'
FROM clientes AS c
	  JOIN facturaciones AS f ON f.id_cliente = c.id_cliente;