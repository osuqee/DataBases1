
--    1 Devuelve un listado con el identificador, nombre y los apellidos de todos
-- 		los clientes que han realizado algún pedido. El listado debe estar
-- 		ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c INNER JOIN pedido p 
	ON c.id = p.id_cliente
GROUP BY c.id 
ORDER BY c.nombre ASC, c.apellido1 ASC, c.apellido2 ASC; 

--    2 Devuelve un listado que muestre todos los pedidos que ha realizado cada
-- 		cliente. El resultado debe mostrar todos los datos de los pedidos y del
-- 		cliente. El listado debe mostrar los datos de los clientes ordenados
-- 		alfabéticamente.
SELECT c.*, p.*  
FROM cliente c INNER JOIN pedido p 
	ON c.id = p.id_cliente
ORDER BY c.nombre ASC, c.apellido1 ASC, c.apellido2 ASC;

--    3 Devuelve un listado que muestre todos los pedidos en los que ha
-- 		participado un comercial. El resultado debe mostrar todos los datos de
-- 		los pedidos y de los comerciales. El listado debe mostrar los datos de
-- 		los comerciales ordenados alfabéticamente.
SELECT c.*, p.*
FROM pedido p INNER JOIN comercial c 
	ON p.id_comercial = c.id
ORDER BY c.nombre ASC, c.apellido1 ASC, c.apellido2 ASC;

--    4 Devuelve un listado que muestre todos los clientes, con todos los pedidos
-- 		que han realizado y con los datos de los comerciales asociados a cada
-- 		pedido.
SELECT c.nombre, c.apellido1, p.total, c2.*
FROM cliente c INNER JOIN pedido p
	ON c.id = p.id_cliente 
	INNER JOIN comercial c2 
	ON p.id_comercial = c2.id;

--    5 Devuelve un listado de todos los clientes que realizaron un pedido
-- 		durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
SELECT c.nombre, c.apellido1
FROM pedido p INNER JOIN cliente c
	ON p.id_cliente = c.id
WHERE YEAR(p.fecha) = 2017
	AND p.total BETWEEN 300 AND 1000;

--    6 Devuelve el nombre y los apellidos de todos los comerciales que ha
-- 		participado en algún pedido realizado por María Santana Moreno.
SELECT c.nombre, c.apellido1, c.apellido2
FROM comercial c INNER JOIN pedido p
	ON c.id = p.id_comercial
	INNER JOIN cliente c2
	ON p.id_cliente = c2.id
WHERE c2.nombre = "María"
	AND c2.apellido1 = "Santana"
	AND c2.apellido2 = "Moreno"
GROUP BY c.id;

--    7 Devuelve el nombre de todos los clientes que han realizado algún pedido
-- 		con el comercial Daniel Sáez Vega.
SELECT c2.nombre, c2.apellido1, c2.apellido2 
FROM comercial c INNER JOIN pedido p
	ON c.id = p.id_comercial
	INNER JOIN cliente c2
	ON p.id_cliente = c2.id
WHERE c.nombre = "Daniel"
	AND c.apellido1 = "Sáez"
	AND c.apellido2 = "Vega"
GROUP BY c2.id;
