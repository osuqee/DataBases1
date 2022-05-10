--    1 Devuelve una lista con el nombre del producto, precio y nombre de 
-- 		fabricante de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo;
	
--    2 Devuelve una lista con el nombre del producto, precio y nombre de 
-- 		fabricante de todos los productos de la base de datos. Ordene el 
-- 		resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre, p.precio, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
ORDER BY p.nombre ASC;
--    3 Devuelve una lista con el código del producto, nombre del producto, 
-- 		código del fabricante y nombre del fabricante, de todos los productos 
-- 		de la base de datos.
SELECT p.codigo, p.nombre, f.codigo, f.nombre
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo;

--    4 Devuelve el nombre del producto, su precio y el nombre de su fabricante, 
-- 		del producto más barato.
SELECT p.nombre, MIN(p.precio) as precio, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo;

--    5 Devuelve el nombre del producto, su precio y el nombre de su fabricante, 
-- 		del producto más caro.
SELECT p.nombre, MAX(p.precio) as precio, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo;

--    6 Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Lenovo";

--    7 Devuelve una lista de todos los productos del fabricante Crucial que 
-- 		tengan un precio mayor que 200€.
SELECT p.nombre, p.precio, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Crucial"
	AND p.precio > 200;

--    8 Devuelve un listado con todos los productos de los fabricantes Asus, 
-- 		Hewlett-Packardy Seagate. Sin utilizar el operador IN.
SELECT p.nombre, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre = "Asus"
	OR f.nombre = "Hewlett-Packard";

--    9 Devuelve un listado con todos los productos de los fabricantes Asus, 
-- 		Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT p.nombre, f.nombre  
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ("Asus","Hewlett-Packard");

--   10 Devuelve un listado con el nombre y el precio de todos los productos 
-- 		de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, p.precio, f.nombre
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre REGEXP 'e$';

--   11 Devuelve un listado con el nombre y el precio de todos los productos 
-- 		cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, p.precio, f.nombre
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE f.nombre REGEXP 'w';

--   12 Devuelve un listado con el nombre de producto, precio y nombre de 
-- 		fabricante, de todos los productos que tengan un precio mayor o igual 
-- 		a 180€. Ordene el resultado en primer lugar por el precio (en orden 
-- 		descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre
FROM producto p INNER JOIN fabricante f 
	ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

--   13 Devuelve un listado con el código y el nombre de fabricante, solamente 
-- 		de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT f.codigo, f.nombre
FROM fabricante f INNER JOIN producto p  
	ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo;

