
--    1 Devuelve un listado con todos los empleados junto con los datos de los 
-- 		departamentos donde trabajan. Este listado también debe incluir los 
-- 		empleados que no tienen ningún departamento asociado.
SELECT e.nombre, e.apellido1, e.apellido2, d.nombre  
FROM empleado e LEFT JOIN departamento d 
	ON e.codigo_departamento = d.codigo; 

--    2 Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen 
-- 		ningún departamento asociado.
SELECT e.nombre, e.apellido1, e.apellido2  
FROM empleado e LEFT JOIN departamento d 
	ON e.codigo_departamento = d.codigo
WHERE d.nombre IS NULL;

--    3 Devuelve un listado donde sólo aparezcan aquellos departamentos que no 
-- 		tienen ningún empleado asociado.
SELECT d.nombre
FROM empleado e RIGHT JOIN departamento d 
	ON e.codigo_departamento = d.codigo 
WHERE e.nombre IS NULL;

--    4 Devuelve un listado con todos los empleados junto con los datos de los 
-- 		departamentos donde trabajan. El listado debe incluir los empleados que 
-- 		no tienen ningún departamento asociado y los departamentos que no tienen 
-- 		ningún empleado asociado. Ordene el listado alfabéticamente por el nombre 
-- 		del departamento.
SELECT d.nombre, e.nombre, e.apellido1 
FROM departamento d LEFT JOIN empleado e
	ON e.codigo_departamento = d.codigo
ORDER BY d.nombre ASC;

--    5 Devuelve un listado con los empleados que no tienen ningún departamento 
-- 		asociado y los departamentos que no tienen ningún empleado asociado. 
-- 		Ordene el listado alfabéticamente por el nombre del departamento.
SELECT d.nombre, e.nombre 
FROM empleado e RIGHT JOIN departamento d 
	ON e.codigo_departamento = d.codigo 
WHERE e.nombre IS NULL

UNION

SELECT d.nombre, e.nombre 
FROM empleado e LEFT JOIN departamento d 
	ON e.codigo_departamento = d.codigo
WHERE d.nombre IS NULL;
