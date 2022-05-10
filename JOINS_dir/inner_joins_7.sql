
--    1 Obtén un listado con el nombre de cada cliente y el nombre y apellido 
-- 		de su representante de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

--    2 Muestra el nombre de los clientes que hayan realizado pagos junto con 
-- 		el nombre de sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	INNER JOIN pago p
	ON c.codigo_cliente = p.codigo_cliente;

--    3 Muestra el nombre de los clientes que no hayan realizado pagos junto 
-- 		con el nombre de sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente
	FROM pago p
	);

--    4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de 
-- 		sus representantes junto con la ciudad de la oficina a la que pertenece
-- 		el representante.
SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	INNER JOIN oficina o
	ON o.codigo_oficina = e.codigo_oficina
	INNER JOIN pago p
	ON p.codigo_cliente = c.codigo_cliente;

--    5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
-- 		de sus representantes junto con la ciudad de la oficina a la que 
-- 		pertenece el representante.
SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	INNER JOIN oficina o
	ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente
	FROM pago p
	);

--    6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT o.ciudad, o.linea_direccion1, o.linea_direccion2
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	INNER JOIN oficina o
	ON o.codigo_oficina = e.codigo_oficina
WHERE o.ciudad = "Fuenlabrada";

--    7 Devuelve el nombre de los clientes y el nombre de sus representantes 
-- 		junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN empleado e
	ON c.codigo_empleado_rep_ventas = e.codigo_empleado
	INNER JOIN oficina o
	ON o.codigo_oficina = e.codigo_oficina;

--    8 Devuelve un listado con el nombre de los empleados junto con el nombre
-- 		de sus jefes.
SELECT e.nombre as nombreEmpleado, e2.nombre as nombreJefe
FROM empleado e INNER JOIN empleado e2
	ON e.codigo_jefe = e2.codigo_empleado;

--    9 Devuelve un listado que muestre el nombre de cada empleados, el nombre 
-- 		de su jefe y el nombre del jefe de sus jefe.
SELECT e.nombre as Empleado, e2.nombre as EmpleadoJefe, e3.nombre as Jefe
FROM empleado e INNER JOIN empleado e2
	ON e.codigo_jefe = e2.codigo_empleado
	INNER JOIN empleado e3 
	ON e2.codigo_jefe = e3.codigo_empleado;

--    10 Devuelve el nombre de los clientes a los que no se les ha entregado a 
-- 		tiempo un pedido.
SELECT c.nombre_cliente
FROM cliente c INNER JOIN pedido p
	ON c.codigo_cliente = p.codigo_cliente
WHERE DATEDIFF(p.fecha_entrega,p.fecha_esperada) > 0
GROUP by c.codigo_cliente;

--    11 Devuelve un listado de las diferentes gamas de producto que ha comprado
-- 		cada cliente.
-- 		c.nombre_cliente, p.codigo_pedido, dp.codigo_pedido, dp.codigo_producto, p2.codigo_producto, p2.gama, gp.gama
SELECT c.nombre_cliente, gp.gama
FROM cliente c INNER JOIN pedido p
	ON c.codigo_cliente = p.codigo_cliente
	INNER JOIN detalle_pedido dp
	ON p.codigo_pedido = dp.codigo_pedido
	INNER JOIN producto p2
	ON dp.codigo_producto = p2.codigo_producto
	INNER JOIN gama_producto gp
	ON p2.gama = gp.gama
GROUP BY c.nombre_cliente, gp.gama
ORDER BY c.nombre_cliente;
