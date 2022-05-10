
--    1 Devuelve un listado con todos los clientes junto con los datos de los
-- 		pedidos que han realizado. Este listado también debe incluir los clientes
-- 		que no han realizado ningún pedido. El listado debe estar ordenado
-- 		alfabéticamente por el primer apellido, segundo apellido y nombre de los
-- 		clientes.
SELECT c.*, p.*
FROM cliente c LEFT JOIN pedido p
	ON c.id = p.id_cliente 
ORDER BY c.apellido1 ASC, c.apellido2 ASC, c.nombre ASC;

--    2 Devuelve un listado con todos los comerciales junto con los datos de los
-- 		pedidos que han realizado. Este listado también debe incluir los
-- 		comerciales que no han realizado ningún pedido. El listado debe estar
-- 		ordenado alfabéticamente por el primer apellido, segundo apellido y
-- 		nombre de los comerciales.
SELECT c2.*, p.*
FROM comercial c2 LEFT JOIN pedido p
	ON c2.id = p.id_comercial 
ORDER BY c2.apellido1 ASC, c2.apellido2 ASC, c2.nombre ASC;

--    3 Devuelve un listado que solamente muestre los clientes que no han
-- 		realizado ningún pedido.
SELECT c.*
FROM cliente c LEFT JOIN pedido p 
	ON c.id = p.id_cliente 
WHERE p.id IS NULL;

--    4 Devuelve un listado que solamente muestre los comerciales que no han
-- 		realizado ningún pedido.
SELECT c.*, p.*
FROM comercial c LEFT JOIN pedido p 
	ON c.id = p.id_comercial 
WHERE p.id IS NULL;

--    5 Devuelve un listado con los clientes que no han realizado ningún pedido
-- 		y de los comerciales que no han participado en ningún pedido. Ordene el
-- 		listado alfabéticamente por los apellidos y el nombre. En en listado
-- 		deberá diferenciar de algún modo los clientes y los comerciales.

SELECT nombre, ap1, ap2, tipo 
FROM (
	SELECT c.nombre as nombre, c.apellido1 as ap1, c.apellido2 as ap2, "cliente" as tipo
	FROM cliente c LEFT JOIN pedido p 
		ON c.id = p.id_cliente 
	WHERE p.id_cliente IS NULL
	
	UNION
	
	SELECT c.nombre as nombre, c.apellido1 as ap1, c.apellido2 as ap2, "comercial" as tipo
	FROM comercial c LEFT JOIN pedido p 
		ON c.id = p.id_comercial 
	WHERE p.id_comercial  IS NULL
) res
ORDER BY ap1, ap2, nombre;

--    6 ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o
-- 		NATURAL RIGHT JOIN? Justifique su respuesta.
-- 		- No, porque va a mezclar datos que no guardan relación.








