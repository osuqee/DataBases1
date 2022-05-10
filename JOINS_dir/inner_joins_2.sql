
--    1 Devuelve un listado de todos los fabricantes que existen en la base 
-- 		de datos, junto con los productos que tiene cada uno de ellos. El 
-- 		listado deberá mostrar también aquellos fabricantes que no tienen 
-- 		productos asociados.
SELECT f.nombre, p.nombre 
FROM fabricante f LEFT JOIN producto p 
	ON f.codigo = p.codigo_fabricante;

--    2 Devuelve un listado donde sólo aparezcan aquellos fabricantes que 
-- 		no tienen ningún producto asociado.
SELECT f.nombre 
FROM fabricante f LEFT JOIN producto p 
	ON f.codigo = p.codigo_fabricante 
WHERE p.codigo IS NULL;

--    3 ¿Pueden existir productos que no estén relacionados con un fabricante? 
-- 		Justifique su respuesta.
-- 		No, porque todos los productos tienen que ser fabricados por alguien. 
SELECT p.nombre 
FROM producto p LEFT JOIN fabricante f
	ON p.codigo_fabricante  = f.codigo
WHERE p.codigo_fabricante IS NULL;
