
--    1 Devuelve un listado que muestre solamente los clientes que no han
-- 		realizado ningún pago.
SELECT c.nombre_cliente 
FROM cliente c LEFT JOIN pago p
	ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

--    2 Devuelve un listado que muestre solamente los clientes que no han
-- 		realizado ningún pedido.
SELECT c.nombre_cliente 
FROM cliente c LEFT JOIN pedido p
	ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

--    3 Devuelve un listado que muestre los clientes que no han realizado
-- 		ningún pago y los que no han realizado ningún pedido.
SELECT c.nombre_cliente
FROM cliente c LEFT JOIN pago p
	ON c.codigo_cliente = p.codigo_cliente
	LEFT JOIN pedido p2
	ON c.codigo_cliente = p2.codigo_cliente
WHERE p.codigo_cliente IS NULL
	OR p2.codigo_cliente IS NULL
GROUP BY c.nombre_cliente;

--    4 Devuelve un listado que muestre solamente los empleados que no tienen
-- 		una oficina asociada.
SELECT e.nombre, e.apellido1
FROM empleado e LEFT JOIN oficina o
	ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

--    5 Devuelve un listado que muestre solamente los empleados que no tienen
-- 		un cliente asociado.
SELECT e.nombre, e.apellido1
FROM empleado e LEFT JOIN cliente c
	ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

--    6 Devuelve un listado que muestre solamente los empleados que no tienen
-- 		un cliente asociado junto con los datos de la oficina donde trabajan.
SELECT e.nombre, e.apellido1, o.ciudad
FROM empleado e LEFT JOIN cliente c
	ON e.codigo_empleado = c.codigo_empleado_rep_ventas
	INNER JOIN oficina o
	ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL;

--    7 Devuelve un listado que muestre los empleados que no tienen una oficina
-- 		asociada y los que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1
FROM empleado e LEFT JOIN oficina o
	ON e.codigo_oficina = o.codigo_oficina
	LEFT JOIN cliente c
	ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL 
	OR c.codigo_empleado_rep_ventas IS NULL;

--    8 Devuelve un listado de los productos que nunca han aparecido en un
-- 		pedido.
SELECT p.*
FROM producto p LEFT JOIN detalle_pedido dp
	ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

--    9 Devuelve un listado de los productos que nunca han aparecido en un
-- 		pedido. El resultado debe mostrar el nombre, la descripción y la imagen
-- 		del producto.
SELECT p.nombre, p.descripcion, gp.imagen
FROM producto p LEFT JOIN detalle_pedido dp
	ON p.codigo_producto = dp.codigo_producto
	INNER JOIN gama_producto gp
	ON p.gama = gp.gama
WHERE dp.codigo_producto IS NULL;

--    10 Devuelve las oficinas donde no trabajan ninguno de los empleados que
-- 		hayan sido los representantes de ventas de algún cliente que haya
-- 		realizado la compra de algún producto de la gama Frutales.
SELECT o.codigo_oficina, o.ciudad
FROM oficina o LEFT JOIN empleado e
	ON o.codigo_oficina = e.codigo_oficina
	INNER JOIN cliente c
	ON e.codigo_empleado = c.codigo_empleado_rep_ventas
	INNER JOIN pedido p
	ON c.codigo_cliente = p.codigo_cliente
	INNER JOIN detalle_pedido dp
	ON p.codigo_pedido = dp.codigo_pedido
	INNER JOIN producto p2
	ON dp.codigo_producto = p2.codigo_producto
WHERE p2.gama = "Frutales"
	AND e.codigo_empleado IS NULL;

--    11 Devuelve un listado con los clientes que han realizado algún pedido
-- 		pero no han realizado ningún pago.
SELECT c.nombre_cliente, p.codigo_pedido
FROM cliente c INNER JOIN pedido p
	ON c.codigo_cliente = p.codigo_cliente
	LEFT JOIN pago p2
	ON c.codigo_cliente = p2.codigo_cliente
WHERE p2.codigo_cliente IS NULL;

--    12 Devuelve un listado con los datos de los empleados que no tienen
-- 		clientes asociados y el nombre de su jefe asociado.
SELECT e.nombre, e.apellido1, e.apellido2, e2.nombre as nombreJefe
FROM empleado e INNER JOIN empleado e2
	ON e.codigo_jefe = e2.codigo_empleado
	LEFT JOIN cliente c
	ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;
