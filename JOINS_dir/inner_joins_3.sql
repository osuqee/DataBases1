
--    1 Devuelve un listado con los empleados y los datos de los departamentos 
-- 		donde trabaja cada uno.
SELECT e.nombre, d.nombre, d.presupuesto, d.gastos 
FROM empleado e INNER JOIN departamento d 
	ON e.codigo_departamento = d.codigo;

--    2 Devuelve un listado con los empleados y los datos de los departamentos 
-- 		donde trabaja cada uno. Ordena el resultado, en primer lugar por el 
-- 		nombre del departamento (en orden alfabético) y en segundo lugar por 
-- 		los apellidos y el nombre de los empleados.
SELECT e.nombre, e.apellido1, e.apellido2, d.nombre, d.presupuesto, d.gastos 
FROM empleado e INNER JOIN departamento d 
	ON e.codigo_departamento = d.codigo 
ORDER BY d.nombre ASC, e.apellido1 ASC, e.apellido2 ASC, e.nombre ASC

--    3 Devuelve un listado con el código y el nombre del departamento, 
-- 		solamente de aquellos departamentos que tienen empleados.
SELECT d.codigo, d.nombre 
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento
GROUP BY d.codigo;

--    4 Devuelve un listado con el código, el nombre del departamento y el 
-- 		valor del presupuesto actual del que dispone, solamente de aquellos 
-- 		departamentos que tienen empleados. El valor del presupuesto actual 
-- 		lo puede calcular restando al valor del presupuesto inicial (columna 
-- 		presupuesto) el valor de los gastos que ha generado (columna gastos).
SELECT d.codigo, d.nombre, (d.presupuesto-d.gastos) as presupuesto_actual 
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento
GROUP BY d.codigo;

--    5 Devuelve el nombre del departamento donde trabaja el empleado que tiene 
-- 		el nif 38382980M.
SELECT d.nombre, e.nif  
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento 
WHERE e.nif = "38382980M";

--    6 Devuelve el nombre del departamento donde trabaja el empleado Pepe 
-- 		Ruiz Santana.
SELECT d.nombre, e.nombre, e.apellido1, e.apellido2 
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento 
WHERE e.nombre = "Pepe"
	AND e.apellido1 = "Ruiz"
	AND e.apellido2 = "Santana";

--    7 Devuelve un listado con los datos de los empleados que trabajan en el 
-- 		departamento de I+D. Ordena el resultado alfabéticamente.
SELECT d.nombre, e.nombre, e.apellido1, e.apellido2 
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento 
WHERE d.nombre = "I+D"
ORDER BY e.nombre ASC, e.apellido1 ASC, e.apellido2 ASC;

--    8 Devuelve un listado con los datos de los empleados que trabajan en el 
-- 		departamento de Sistemas, Contabilidad o I+D. Ordena el resultado 
-- 		alfabéticamente.
SELECT d.nombre, e.nombre, e.apellido1, e.apellido2 
FROM departamento d INNER JOIN empleado e 
	ON d.codigo = e.codigo_departamento 
WHERE d.nombre IN ("I+D", "Contabilidad", "Sistemas")
ORDER BY d.nombre ASC, e.nombre ASC, e.apellido1 ASC, e.apellido2 ASC;

--    9 Devuelve una lista con el nombre de los empleados que tienen los 
-- 		departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
SELECT e.nombre, d.nombre, d.presupuesto 
FROM empleado e INNER JOIN departamento d 
	ON e.codigo_departamento = d.codigo 
WHERE d.presupuesto NOT BETWEEN 100000 AND 200000;

--   10 Devuelve un listado con el nombre de los departamentos donde existe 
-- 		algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no 
-- 		debe mostrar nombres de departamentos que estén repetidos.
SELECT d.nombre  
FROM departamento d INNER JOIN empleado e
	ON d.codigo = e.codigo_departamento 
WHERE e.apellido2 IS NULL;
