-- 		PROCEDIMIENTOS SIN SENTENCIAS SQL;

-- 		Escribe un procedimiento que no tenga ningún parámetro de entrada 
-- 		ni de salida y que muestre el texto ¡Hola mundo!.
DROP PROCEDURE IF EXISTS holaMundo;

CREATE PROCEDURE holaMundo()
BEGIN
	SELECT "¡Hola Mundo!";
END;

CALL holaMundo;

--    	Escribe un procedimiento que reciba un número real de entrada y muestre
-- 		un mensaje indicando si el número es positivo, negativo o cero.
DROP PROCEDURE IF EXISTS signo;

CREATE PROCEDURE signo(num REAL)
BEGIN
	IF num > 0 THEN
		SELECT "positivo";
	ELSEIF num < 0 THEN
		SELECT "negativo";
	ELSE 
		SELECT "cero";
	END IF;
END;

CALL signo(3);
CALL signo(-4);
CALL signo(0);

--   	Modifique el procedimiento diseñado en el ejercicio anterior para que 
-- 		tenga un parámetro de entrada, con el valor un número real, y un 
-- 		parámetro de salida, con una cadena de caracteres indicando si el 
-- 		número es positivo, negativo o cero.
DROP PROCEDURE IF EXISTS signo;

CREATE PROCEDURE signo(in num REAL, out cadena VARCHAR(10))
BEGIN
	IF num > 0 THEN
		SET cadena = "positivo";
	ELSEIF num < 0 THEN
		SET cadena = "negativo";
	ELSE 
		SET cadena = "cero";
	END IF;
END;

CALL signo(3,@temp);
SELECT @temp;

--    	Escribe un procedimiento que reciba un número real de entrada, que 
-- 		representa el valor de la nota de un alumno, y muestre un mensaje
-- 		indicando qué nota ha obtenido teniendo en cuenta las siguientes 
-- 		condiciones:
-- 
--    	[0,5) = Insuficiente
--    	[5,6) = Aprobado
--    	[6, 7) = Bien
--    	[7, 9) = Notable
--    	[9, 10] = Sobresaliente
--    	En cualquier otro caso la nota no será válida.
DROP PROCEDURE IF EXISTS calificar;

CREATE PROCEDURE calificar(in nota REAL)
BEGIN
	IF (nota>=0 AND nota<5) THEN
		SELECT "Insuficiente";
	ELSEIF (nota>=5 AND nota<6) THEN
		SELECT "Aprobado";
	ELSEIF (nota>=6 AND nota<7) THEN 
		SELECT "Bien";
	ELSEIF (nota>=7 AND nota<9) THEN
		SELECT "Notable";
	ELSEIF (nota>=9 AND nota<10) THEN
		SELECT "Sobresaliente";
	ELSE
		SELECT "La nota introducida no es válida";
	END IF;
END;

CALL calificar(9);

--    	Modifique el procedimiento diseñado en el ejercicio anterior para que
-- 		tenga un parámetro de entrada, con el valor de la nota en formato 
-- 		numérico y un parámetro de salida, con una cadena de texto indicando
-- 		la nota correspondiente.
DROP PROCEDURE IF EXISTS calificar;

CREATE PROCEDURE calificar(in nota REAL, out mensaje VARCHAR(50))
BEGIN
	IF (nota>=0 AND nota<5) THEN
		SET mensaje = "Insuficiente";
	ELSEIF (nota>=5 AND nota<6) THEN
		SET mensaje = "Aprobado";
	ELSEIF (nota>=6 AND nota<7) THEN
		SET mensaje = "Bien";
	ELSEIF (nota>=7 AND nota<9) THEN
		SET mensaje = "Notable";
	ELSEIF (nota>=9 AND nota<10) THEN
		SET mensaje = "Sobresaliente";
	ELSE
		SET mensaje = "La nota introducida no es válida";
	END IF;
END;

CALL calificar(7.4,@temp);
SELECT @temp;

--    	Resuelva el procedimiento diseñado en el ejercicio anterior haciendo 
-- 		uso de la estructura de control CASE.
DROP PROCEDURE IF EXISTS calificar;

CREATE PROCEDURE calificar(in nota REAL, out mensaje VARCHAR(50))
BEGIN
	CASE
		WHEN (nota>=0 AND nota<5) THEN 
			SET mensaje = "Insuficiente";
		WHEN (nota>=5 AND nota<6) THEN 
			SET mensaje = "Aprobado";
		WHEN (nota>=6 AND nota<7) THEN 
			SET mensaje = "Bien";
		WHEN (nota>=7 AND nota<9) THEN
			SET mensaje = "Notable";
		WHEN (nota>=9 AND nota<=10) THEN
			SET mensaje = "Sobresaliente";
		ELSE
			SET mensaje = "La  nota introducida no es válida";
	END CASE;
END;

CALL calificar(9.3,@temp);
SELECT @temp;

--    	Escribe un procedimiento que reciba como parámetro de entrada un 
-- 		valor numérico que represente un día de la semana y que devuelva
-- 		una cadena de caracteres con el nombre del día de la semana 
-- 		correspondiente. Por ejemplo, para el valor de entrada 1 debería
-- 		devolver la cadena lunes.
DROP PROCEDURE IF EXISTS diaSemana;

CREATE PROCEDURE diaSemana(dia INT)
BEGIN
	CASE dia
		WHEN 1 THEN SELECT "Lunes";
		WHEN 2 THEN SELECT "Martes";
		WHEN 3 THEN	SELECT "Miercoles";
		WHEN 4 THEN SELECT "Jueves";
		WHEN 5 THEN SELECT "Viernes";
		WHEN 6 THEN	SELECT "Sabado";
		WHEN 7 THEN SELECT "Domingo";
		ELSE
			SELECT "error";
	END CASE;
END;

CALL diaSemana(3);

-- 		PROCEDIMIENTOS CON SENTENCIAS SQL: 
use jardineria;

-- 		Escribe un procedimiento que reciba el nombre de un país como parámetro 
-- 		de entrada y realice una consulta sobre la tabla cliente para obtener 
-- 		todos los clientes que existen en la tabla de ese país.
DROP PROCEDURE IF EXISTS clientesPais;

CREATE PROCEDURE clientesPais(pais VARCHAR(20))
BEGIN
	SELECT c.nombre_cliente
	FROM jardineria.cliente as c
	WHERE c.pais = pais;
END;

CALL clientesPais("USA");

--    	Escribe un procedimiento que reciba como parámetro de entrada una forma 
-- 		de pago, que será una cadena de caracteres (Ejemplo: PayPal, 
-- 		Transferencia, etc). Y devuelva como salida el pago de máximo valor
-- 		realizado para esa forma de pago. Deberá hacer uso de la tabla pago
-- 		de la base de datos jardineria.
DROP PROCEDURE IF EXISTS formaPago;

CREATE PROCEDURE formaPago(forma VARCHAR(20))
BEGIN
	SELECT MAX(p.total) as pagoMaximo
	FROM jardineria.pago as p
	WHERE p.forma_pago = forma;
END;

CALL formaPago("PayPal");

--    	Escribe un procedimiento que reciba como parámetro de entrada una forma
-- 		de pago, que será una cadena de caracteres (Ejemplo: PayPal,
-- 		Transferencia, etc). Y devuelva como salida los siguientes valores
-- 		teniendo en cuenta la forma de pago seleccionada como parámetro
-- 		de entrada:
-- 		    el pago de máximo valor,
-- 		    el pago de mínimo valor,
-- 		    el valor medio de los pagos realizados,
-- 		    la suma de todos los pagos,
-- 		    el número de pagos realizados para esa forma de pago.
-- 		Deberá hacer uso de la tabla pago de la base de datos jardineria.
DROP PROCEDURE IF EXISTS formaPago2;

CREATE PROCEDURE formaPago2(forma VARCHAR(20))
BEGIN
	SELECT MAX(p.total) as maximo, MIN(p.total) as minimo, AVG(p.total) as mediaPagos, SUM(p.total) as todosLosPagos, COUNT(p.id_transaccion) as numPagos 
	FROM jardineria.pago as p
	WHERE p.forma_pago = forma;
END;

CALL formaPago2("PayPal");

-- 	   	Crea una base de datos llamada procedimientos que contenga una tabla
-- 		llamada cuadrados. La tabla cuadrados debe tener dos columnas de tipo
-- 		INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;

DROP TABLE IF EXISTS cuadrados;
CREATE TABLE cuadrados(
	numero INT UNSIGNED,
	cuadrado INT UNSIGNED
);

-- 		Una vez creada la base de datos y la tabla deberá crear un procedimiento 
-- 		llamado calcular_cuadrados con las siguientes características. El 
-- 		procedimiento recibe un parámetro de entrada llamado tope de tipo INT
-- 		UNSIGNED y calculará el valor de los cuadrados de los primeros números 
-- 		naturales hasta el valor introducido como parámetro. El valor del números 
-- 		y de sus cuadrados deberán ser almacenados en la tabla cuadrados que 
-- 		hemos creado previamente.

-- 		Tenga en cuenta que el procedimiento deberá eliminar el contenido 
-- 		actual de la tabla antes de insertar los nuevos valores de los 
-- 		cuadrados que va a calcular.

-- 		Utilice un bucle WHILE para resolver el procedimiento.
DROP PROCEDURE IF EXISTS calcular_cuadrados;

CREATE PROCEDURE calcular_cuadrados(tope INT UNSIGNED) 
BEGIN
	DECLARE cont INT DEFAULT 1;

	DELETE c.* FROM cuadrados as c;
	
	WHILE (cont <= tope) DO
		INSERT INTO cuadrados VALUES (cont, cont*cont);
		SET cont = cont + 1;
	END WHILE;
END;

CALL calcular_cuadrados(4);

--  	Utilice un bucle REPEAT para resolver el procedimiento del ejercicio 
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_cuadrados;

CREATE PROCEDURE calcular_cuadrados(tope INT UNSIGNED)
BEGIN
	DECLARE i INT DEFAULT 1;

	DELETE c.* FROM cuadrados as c;

	REPEAT 
		INSERT INTO cuadrados VALUES (i,i*i);
		SET i = i + 1;
	UNTIL i > tope END REPEAT;
END;

CALL calcular_cuadrados(5); 

-- 		Utilice un bucle LOOP para resolver el procedimiento del ejercicio 
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_cuadrados;

CREATE PROCEDURE calcular_cuadrados(tope INT UNSIGNED)
BEGIN
	DECLARE i INT DEFAULT 1;
	
	DELETE c.* FROM cuadrados as c;

	l1: LOOP
		INSERT INTO cuadrados VALUES (i,i*i);
		SET i = i + 1;
		IF (i > tope) THEN
			LEAVE l1;
		END IF;
	END LOOP;	
END;

CALL calcular_cuadrados(7); 

-- 	    Crea una base de datos llamada procedimientos que contenga una tabla
-- 		llamada ejercicio. La tabla debe tener una única columna llamada 
-- 		número y el tipo de dato de esta columna debe ser INT UNSIGNED.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE IF NOT EXISTS procedimientos;
USE procedimientos;

CREATE TABLE ejercicio(
	dato INT UNSIGNED
);

-- 		Una vez creada la base de datos y la tabla deberá crear un 
-- 		procedimiento llamado calcular_números con las siguientes 
-- 		características. El procedimiento recibe un parámetro de entrada 
-- 		llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en 
-- 		la tabla ejercicio toda la secuencia de números desde el valor 
-- 		inicial pasado como entrada hasta el 1.

-- 		Tenga en cuenta que el procedimiento deberá eliminar el contenido 
-- 		actual de las tablas antes de insertar los nuevos valores.

-- 		Utilice un bucle WHILE para resolver el procedimiento.
DROP PROCEDURE IF EXISTS calcular_numeros;

CREATE PROCEDURE calcular_numeros(valor_inicial INT UNSIGNED) 
BEGIN 	
	DELETE e.* FROM ejercicio as e;
	
	WHILE (valor_inicial >= 1) DO
		INSERT INTO ejercicio VALUES (valor_inicial);
		SET valor_inicial = valor_inicial - 1;
	END WHILE;
END;

CALL calcular_numeros(3); 

-- 	    Utilice un bucle REPEAT para resolver el procedimiento del ejercicio
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_numeros;

CREATE PROCEDURE calcular_numeros(valor_inicial INT UNSIGNED)
BEGIN	
	DELETE e.* FROM ejercicio as e;

	REPEAT 
		INSERT INTO ejercicio VALUES (valor_inicial);
		SET valor_inicial = valor_inicial - 1;
	UNTIL valor_inicial < 1 END REPEAT;
END;

CALL calcular_numeros(4); 

--     	Utilice un bucle LOOP para resolver el procedimiento del ejercicio 
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_numeros;

CREATE PROCEDURE calcular_numeros(valor_inicial INT UNSIGNED)
BEGIN
	DELETE e.* FROM ejercicio as e;

	l1: LOOP
		INSERT INTO ejercicio VALUES (valor_inicial);
		SET valor_inicial = valor_inicial - 1;
		IF (valor_inicial < 1) THEN
			LEAVE l1;
		END IF;
	END LOOP;	
END;

CALL calcular_numeros(5); 

-- 	    Crea una base de datos llamada procedimientos que contenga una tabla 
-- 		llamada pares y otra tabla llamada impares. Las dos tablas deben 
-- 		tener única columna llamada número y el tipo de dato de esta columna 
-- 		debe ser INT UNSIGNED.
DROP DATABASE IF EXISTS procedimientos;

CREATE DATABASE procedimientos;
USE procedimientos;

DROP TABLE IF EXISTS pares;
DROP TABLE IF EXISTS impares;

CREATE TABLE pares(
	numero INT UNSIGNED
);

CREATE TABLE impares(
	numero INT UNSIGNED
);

-- 		Una vez creada la base de datos y las tablas deberá crear un 
-- 		procedimiento llamado calcular_pares_impares con las siguientes 
-- 		características. El procedimiento recibe un parámetro de entrada 
-- 		llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla 
-- 		pares aquellos números pares que existan entre el número 1 el valor 
-- 		introducido como parámetro. Habrá que realizar la misma operación
-- 		para almacenar los números impares en la tabla impares.

-- 		Tenga en cuenta que el procedimiento deberá eliminar el contenido 
-- 		actual de las tablas antes de insertar los nuevos valores.

-- 		Utilice un bucle WHILE para resolver el procedimiento.
DROP PROCEDURE IF EXISTS calcular_pares_impares;

CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
BEGIN
	DECLARE c INT DEFAULT 1;
	
	DELETE p.* FROM pares as p;
	DELETE i.* FROM impares as i;
	
	WHILE c <= tope DO
		IF (c % 2 = 1) THEN
			INSERT INTO impares VALUES (c);
		ELSE 
			INSERT INTO pares VALUES (c);
		END IF;
		SET c = c + 1;
	END WHILE;
END;

CALL calcular_pares_impares(13); 

-- 	    Utilice un bucle REPEAT para resolver el procedimiento del ejercicio 
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_pares_impares;

CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
BEGIN
	DECLARE c INT DEFAULT 1;
	
	DELETE p.* FROM pares as p;
	DELETE i.* FROM impares as i;
	
	REPEAT 
		IF (c % 2 = 1) THEN
			INSERT INTO impares VALUES (c);
		ELSE 
			INSERT INTO pares VALUES (c);
		END IF;
		SET c = c + 1;
	UNTIL c > tope END REPEAT;
END;

CALL calcular_pares_impares(7);

-- 	    Utilice un bucle LOOP para resolver el procedimiento del ejercicio 
-- 		anterior.
DROP PROCEDURE IF EXISTS calcular_pares_impares;

CREATE PROCEDURE calcular_pares_impares(tope INT UNSIGNED)
BEGIN
	DECLARE c INT DEFAULT 1;

	DELETE p.* FROM pares as p;
	DELETE i.* FROM impares as i;
	
	l1: LOOP 
		IF (c % 2 = 1) THEN
			INSERT INTO impares VALUES (c);
		ELSE 
			INSERT INTO pares VALUES (c);
		END IF;
		SET c = c + 1;
		IF (c > tope) THEN
			LEAVE l1;
		END IF;
	END LOOP;
END;

CALL calcular_pares_impares(12); 


-- 		FUNCIONES SIN SENTENCIAS SQL;

-- 	    Escribe una función que reciba un número entero de entrada y 
-- 		devuelva TRUE si el número es par o FALSE en caso contrario.
DROP FUNCTION IF EXISTS esPar;

CREATE FUNCTION esPar(numero INT)
RETURNS BOOLEAN
BEGIN
	IF (numero % 2 = 0) THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;

SELECT esPar(2);
SELECT esPar(7);

-- 	    Escribe una función que devuelva el valor de la hipotenusa de 
-- 		un triángulo a partir de los valores de sus lados.
DROP FUNCTION IF EXISTS hipotenusa;

CREATE FUNCTION hipotenusa(lado1 INT, lado2 INT)
RETURNS INT UNSIGNED
BEGIN
	RETURN SQRT(lado1*lado1 + lado2*lado2); 
END;

SELECT hipotenusa(3,4);

--     	Escribe una función que reciba como parámetro de entrada un 
-- 		valor numérico que represente un día de la semana y que devuelva 
-- 		una cadena de caracteres con el nombre del día de la semana 
-- 		correspondiente. Por ejemplo, para el valor de entrada 1 debería 
-- 		devolver la cadena lunes.
DROP FUNCTION IF EXISTS diaSemana;

CREATE FUNCTION diaSemana(dia INT)
RETURNS VARCHAR(20)
BEGIN
	IF (dia=1) THEN
		RETURN "Lunes";
	ELSEIF (dia=2) THEN
		RETURN "Martes";
	ELSEIF (dia=3) THEN
		RETURN "Miercoles";
	ELSEIF (dia=4) THEN
		RETURN "Jueves";
	ELSEIF (dia=5) THEN
		RETURN "Viernes";
	ELSEIF (dia=6) THEN
		RETURN "Sabado";
	ELSEIF (dia=7) THEN
		RETURN "Domingo";
	END IF;
END;

SELECT diaSemana(3);

--     	Escribe una función que reciba tres números reales como parámetros 
-- 		de entrada y devuelva el mayor de los tres.
DROP FUNCTION IF EXISTS tresReales;

CREATE FUNCTION tresReales(a REAL, b REAL, c REAL)
RETURNS REAL
BEGIN
	IF (a>b AND a>c) THEN 
		RETURN a;
	ELSEIF (b>a AND b>c) THEN 
		RETURN b;
	ELSE 
		RETURN c;
	END IF;
END;

SELECT tresReales(5,4,3);

-- 	    Escribe una función que devuelva el valor del área de un círculo 
-- 		a partir del valor del radio que se recibirá como parámetro de entrada.
DROP FUNCTION IF EXISTS areaCirculo;

CREATE FUNCTION areaCirculo(radio INT)
RETURNS REAL
BEGIN
	RETURN PI()*radio*radio;
END;

SELECT areaCirculo(2);

-- 	    Escribe una función que devuelva como salida el número de años que 
-- 		han transcurrido entre dos fechas que se reciben como parámetros 
-- 		de entrada. Por ejemplo, si pasamos como parámetros de entrada las 
-- 		fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que 
-- 		han pasado 10 años.

-- 		Para realizar esta función puede hacer uso de las siguientes funciones 
-- 		que nos proporciona MySQL:

-- 	    DATEDIFF
-- 	    TRUNCATE

DROP FUNCTION IF EXISTS anosPasados;

CREATE FUNCTION anosPasados(fecha1 DATE, fecha2 DATE)
RETURNS INT
BEGIN
	RETURN TRUNCATE(DATEDIFF(fecha1,fecha2)/365,1);
END;

SELECT anosPasados("2018-01-01","2008-01-01");

-- 	    Escribe una función que reciba una cadena de entrada y devuelva 
-- 		la misma cadena pero sin acentos. La función tendrá que reemplazar
-- 		todas las vocales que tengan acento por la misma vocal pero sin 
-- 		acento. Por ejemplo, si la función recibe como parámetro de entrada 
-- 		la cadena María la función debe devolver la cadena Maria.
DROP FUNCTION IF EXISTS sinAcentos;

CREATE FUNCTION sinAcentos(cad VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN
	DECLARE cad_aux VARCHAR(20) DEFAULT "";

	SET cad_aux = cad;

	SET cad_aux = REPLACE(cad_aux,'á','a'); 
	SET cad_aux = REPLACE(cad_aux,'é','e'); 
	SET cad_aux = REPLACE(cad_aux,'í','i');
	SET cad_aux = REPLACE(cad_aux,'ó','o'); 
	SET cad_aux = REPLACE(cad_aux,'ú','u'); 
	RETURN cad_aux;
END;

SELECT sinAcentos("úúúííóóé");

-- 		FUNCIONES CON SENTENCIAS SQL:

-- 	    Escribe una función para la base de datos tienda que devuelva el 
-- 		número total de productos que hay en la tabla productos.
USE tienda;

DROP FUNCTION IF EXISTS numProductos;

CREATE FUNCTION numProductos()
RETURNS INT
BEGIN
	DECLARE a INT DEFAULT (SELECT COUNT(p.codigo) 
							FROM producto as p);
	RETURN a;
END;

SELECT numProductos();

-- 	    Escribe una función para la base de datos tienda que devuelva el 
-- 		valor medio del precio de los productos de un determinado fabricante 
-- 		que se recibirá como parámetro de entrada. El parámetro de entrada 
-- 		será el nombre del fabricante.
DROP FUNCTION IF EXISTS valorMedioProdsFabricante;

CREATE FUNCTION valorMedioProdsFabricante(fabricante VARCHAR(20))
RETURNS REAL
BEGIN
	DECLARE a REAL DEFAULT (SELECT AVG(p.precio)
							FROM fabricante f, producto p
							WHERE f.codigo = p.codigo_fabricante
								AND f.nombre = fabricante);
	RETURN a;
END;

SELECT valorMedioProdsFabricante("Asus");

-- 	    Escribe una función para la base de datos tienda que devuelva el 
-- 		valor máximo del precio de los productos de un determinado fabricante 
-- 		que se recibirá como parámetro de entrada. El parámetro de entrada 
-- 		será el nombre del fabricante.
DROP FUNCTION IF EXISTS valorMaxFabricante;

CREATE FUNCTION valorMaxFabricante(fabricante VARCHAR(20))
RETURNS REAL
BEGIN
	DECLARE a REAL DEFAULT (SELECT MAX(p.precio)
							FROM fabricante f, producto p
							WHERE f.codigo = p.codigo_fabricante
								AND f.nombre = fabricante);
	RETURN a;
END;

SELECT valorMaxFabricante("Asus");

-- 	    Escribe una función para la base de datos tienda que devuelva el 
-- 		valor mínimo del precio de los productos de un determinado fabricante 
-- 		que se recibirá como parámetro de entrada. El parámetro de entrada 
-- 		será el nombre del fabricante.
DROP FUNCTION IF EXISTS valorMinFabricante;

CREATE FUNCTION valorMinFabricante(fabricante VARCHAR(20))
RETURNS REAL
BEGIN
	DECLARE a REAL DEFAULT (SELECT MIN(p.precio)
							FROM fabricante f, producto p
							WHERE f.codigo = p.codigo_fabricante
								AND f.nombre = fabricante);
	RETURN a;
END;

SELECT valorMinFabricante("Asus");

-- 		MANEJO DE ERRORES EN SQL : 

-- 	    Crea una base de datos llamada test que contenga una tabla llamada 
-- 		alumno. La tabla debe tener cuatro columnas:
-- 	    	id: entero sin signo (clave primaria).
-- 	    	nombre: cadena de 50 caracteres.
-- 	    	apellido1: cadena de 50 caracteres.
-- 	    	apellido2: cadena de 50 caracteres.
DROP DATABASE IF EXISTS test;

CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS test;

CREATE TABLE test(
	id INT UNSIGNED PRIMARY KEY,
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50)
);

-- 		Una vez creada la base de datos y la tabla deberá crear un 
-- 		procedimiento llamado insertar_alumno con las siguientes 
-- 		características. El procedimiento recibe cuatro parámetros de 
-- 		entrada (id, nombre, apellido1, apellido2) y los insertará en 
-- 		la tabla alumno. El procedimiento devolverá como salida un parámetro 
-- 		llamado error que tendrá un valor igual a 0 si la operación se ha 
-- 		podido realizar con éxito y un valor igual a 1 en caso contrario.

-- 		Deberá manejar los errores que puedan ocurrir cuando se intenta 
-- 		insertar una fila que contiene una clave primaria repetida.

DELETE t.* FROM test as t;

DROP PROCEDURE IF EXISTS insertar_alumno;

CREATE PROCEDURE insertar_alumno(in id INT UNSIGNED, in nombre VARCHAR(20),
									in apellido1 VARCHAR(20), 
									in apellido2 VARCHAR(20), out error INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	BEGIN
		SET error = 1;
		SELECT error;
	END;
	INSERT INTO test VALUES (id,nombre,apellido1,apellido2);
	SET error = 0;
	SELECT error;
END;

CALL insertar_alumno(1,"ana","sanz","garcia",@error); 

-- 		TRANSACCIONES CON PROCEDIMIENTOS ALMACENADOS : 

-- 	    Crea una base de datos llamada cine que contenga dos tablas con 
-- 		las siguientes columnas.
DROP DATABASE IF EXISTS cine;

CREATE DATABASE cine;
USE cine;

-- 		Tabla cuentas:
-- 	    	id_cuenta: entero sin signo (clave primaria).
-- 		    saldo: real sin signo.
DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas(
	id_cuenta INT UNSIGNED PRIMARY KEY,
	saldo REAL UNSIGNED
);

-- 		Tabla entradas:
-- 		    id_butaca: entero sin signo (clave primaria).
-- 		    nif: cadena de 9 caracteres.
DROP TABLE IF EXISTS entradas;

CREATE TABLE entradas(
	id_butaca INT UNSIGNED PRIMARY KEY,
	nif VARCHAR(9)
);

-- 		Una vez creada la base de datos y las tablas deberá crear un 
-- 		procedimiento llamado comprar_entrada con las siguientes 
-- 		características. El procedimiento recibe 3 parámetros de entrada 
-- 		(nif, id_cuenta, id_butaca) y devolverá como salida un parámetro 
-- 		llamado error que tendrá un valor igual a 0 si la compra de la 
-- 		entrada se ha podido realizar con éxito y un valor igual a 1 en 
-- 		caso contrario.

-- 		El procedimiento de compra realiza los siguientes pasos:

-- 	    Inicia una transacción.
-- 	    Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a 
-- 			la cuenta con el id_cuenta adecuado.
-- 	    Inserta una una fila en la tabla entradas indicando la butaca 
-- 			(id_butaca) que acaba de comprar el usuario (nif).
-- 	    Comprueba si ha ocurrido algún error en las operaciones anteriores. 
-- 			Si no ocurre ningún error entonces aplica un COMMIT a la 
-- 			transacción y si ha ocurrido algún error aplica un ROLLBACK.

-- 		Deberá manejar los siguientes errores que puedan ocurrir durante 
-- 			el proceso.

-- 	    ERROR 1264 (Out of range value)
-- 	    ERROR 1062 (Duplicate entry for PRIMARY KEY)
DROP PROCEDURE IF EXISTS comprar_entrada;

CREATE PROCEDURE comprar_entrada(in nif VARCHAR(9), in id_cuenta INT UNSIGNED,
									in id_butaca INT UNSIGNED, out error INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLSTATE '1264'
	BEGIN
		SET error = 1;
		SELECT error;
		ROLLBACK;
	END;
	
	DECLARE EXIT HANDLER FOR SQLSTATE '1062'
	BEGIN
		SET error = 1;
		SELECT error;
		ROLLBACK;
	END;
	
	START TRANSACTION;
		SET error = 0;
		UPDATE cuentas as c SET saldo = saldo - 5
		WHERE c.id_cuenta = id_cuenta;
		INSERT INTO entradas VALUES (id_butaca, nif);
		SELECT error;	
	COMMIT;
END;

-- pruebas del ejercicio : 
INSERT INTO cuentas VALUES (1,20);
INSERT INTO cuentas VALUES (2,5);
INSERT INTO cuentas VALUES (3,10);

CALL comprar_entrada("aaa1",1,1,@error); 
CALL comprar_entrada("aaa1",1,2,@error); 
CALL comprar_entrada("aaa1",2,3,@error); 
CALL comprar_entrada("aaa1",2,4,@error); 

-- 	    ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos 
-- 			como parámetro un número de cuenta que no existe en la tabla 
-- 			cuentas? ¿Ocurre algún error o podemos comprar la entrada?

-- 		En caso de que exista algún error, ¿cómo podríamos resolverlo?.



-- 		CURSORES :

-- 	    Escribe las sentencias SQL necesarias para crear una base de datos 
-- 		llamada test, una tabla llamada alumnos y 4 sentencias de inserción 
-- 		para inicializar la tabla. La tabla alumnos está formada por las 
-- 		siguientes columnas:
-- 		    id (entero sin signo y clave primaria)
-- 		    nombre (cadena de caracteres)
-- 		    apellido1 (cadena de caracteres)
-- 		    apellido2 (cadena de caracteres
-- 		    fecha_nacimiento (fecha)
DROP DATABASE IF EXISTS test;

CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS alumnos;

CREATE TABLE alumnos(
	id INT UNSIGNED PRIMARY KEY,
	nombre VARCHAR(20),
	apellido1 VARCHAR(20),
	apellido2 VARCHAR(20),
	fecha_nacimiento DATE
);

-- 		Una vez creada la tabla se decide añadir una nueva columna a la tabla 
-- 		llamada edad que será un valor calculado a partir de la columna 
-- 		fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar 
-- 		la tabla y añadir la nueva columna.
ALTER TABLE alumnos ADD edad INT UNSIGNED;

-- 		Escriba una función llamada calcular_edad que reciba una fecha y 
-- 		devuelva el número de años que han pasado desde la fecha actual 
-- 		hasta la fecha pasada como parámetro:
-- 		    Función: calcular_edad
-- 		    Entrada: Fecha
-- 		    Salida: Número de años (entero)
DROP FUNCTION IF EXISTS calcular_edad;

CREATE FUNCTION calcular_edad(fecha DATE)
RETURNS INT
BEGIN
	RETURN TRUNCATE(DATEDIFF(CURRENT_DATE(),fecha)/365,1); 
END;

SELECT calcular_edad("2021-01-01");

-- 		Ahora escriba un procedimiento que permita calcular la edad de 
-- 		todos los alumnmos que ya existen en la tabla. Para esto será 
-- 		necesario crear un procedimiento llamado actualizar_columna_edad 
-- 		que calcule la edad de cada alumno y actualice la tabla. Este 
-- 		procedimiento hará uso de la función calcular_edad que hemos creado 
-- 		en el paso anterior.
DROP PROCEDURE IF EXISTS actualizar_columna_edad;

CREATE PROCEDURE actualizar_columna_edad()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE fecha_aux DATE;
	DECLARE id_a INT;
	DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM test.alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	read_loop: LOOP
		FETCH cur1 INTO id_a,fecha_aux;
	
		UPDATE test.alumnos as a 
		SET a.edad = calcular_edad(fecha_aux)
		WHERE id=id_a;
		
		IF done THEN
			LEAVE read_loop;
		END IF;
	END LOOP;

	CLOSE cur1;
END;

INSERT INTO alumnos VALUES(2,"samara","halid","garcia","2010-02-04",null);
INSERT INTO alumnos VALUES(1,"jay","coman","slang","2004-03-09",null);

CALL actualizar_columna_edad();

-- 	    Modifica la tabla alumnos del ejercicio anterior para añadir una nueva 
-- 		columna email. Una vez que hemos modificado la tabla necesitamos 
-- 		asignarle una dirección de correo electrónico de forma automática.
ALTER TABLE test.alumnos ADD email VARCHAR(20);

-- 		Escriba un procedimiento llamado crear_email que dados los parámetros 
-- 		de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección 
-- 		de email y la devuelva como salida.
-- 	    Procedimiento: crear_email
-- 	    Entrada:
-- 	        nombre (cadena de caracteres)
-- 	        apellido1 (cadena de caracteres)
-- 	        apellido2 (cadena de caracteres)
-- 	        dominio (cadena de caracteres)
-- 	    Salida:
-- 	        email (cadena de caracteres)
-- 		devuelva una dirección de correo electrónico con el siguiente formato:
-- 		    El primer carácter del parámetro nombre.
-- 		    Los tres primeros caracteres del parámetro apellido1.
-- 		    Los tres primeros caracteres del parámetro apellido2.
-- 		    El carácter @.
-- 		    El dominio pasado como parámetro.
DROP PROCEDURE IF EXISTS crear_email;

CREATE PROCEDURE crear_email(in nombre VARCHAR(20), in apellido1 VARCHAR(20),
								in apellido2 VARCHAR(20), in dominio VARCHAR(20),
								out email VARCHAR(50))
BEGIN
	SET email = CONCAT(LEFT(nombre,1),CONCAT(LEFT(apellido1,3),
					CONCAT(LEFT(apellido2,3),CONCAT("@",dominio))));
END;

CALL crear_email("Emilio","Garcia","Santos","gmail.com",@direccion);
SELECT @direccion;

-- 		Ahora escriba un procedimiento que permita crear un email para todos 
-- 		los alumnmos que ya existen en la tabla. Para esto será necesario 
-- 		crear un procedimiento llamado actualizar_columna_email que actualice 
-- 		la columna email de la tabla alumnos. Este procedimiento hará uso del 
-- 		procedimiento crear_email que hemos creado en el paso anterior.
DROP PROCEDURE IF EXISTS actualizar_columna_email;

CREATE PROCEDURE actualizar_columna_email()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE id_a INT;
	DECLARE nombre_a, apel1_a, apel2_a VARCHAR(20);
	DECLARE dominio VARCHAR(20) DEFAULT "gmail.com";
	DECLARE direccion VARCHAR(50);
	DECLARE cur1 CURSOR FOR SELECT id, nombre, apellido1, apellido2 FROM test.alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
	OPEN cur1;

	l1: LOOP
		FETCH cur1 INTO id_a, nombre_a, apel1_a, apel2_a;
		
		IF done THEN
			LEAVE l1;
		ELSE
			CALL crear_email(nombre_a,apel1_a,apel2_a,dominio,direccion);
			UPDATE test.alumnos a 
			SET email = direccion
			WHERE id = id_a;
		END IF;
	END LOOP;
	
	CLOSE cur1;
END;

CALL actualizar_columna_email();

-- 	    Escribe un procedimiento llamado crear_lista_emails_alumnos que 
-- 		devuelva la lista de emails de la tabla alumnos separados por un 
-- 		punto y coma. Ejemplo: juan@iescelia.org;maria@iescelia.org;
-- 									pepe@iescelia.org;lucia@iescelia.org.
DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos;

CREATE PROCEDURE crear_lista_emails_alumnos()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE cadena VARCHAR(1000) DEFAULT "";
	DECLARE email_a VARCHAR(20);
	DECLARE cur1 CURSOR FOR SELECT email FROM test.alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	l1: LOOP
		FETCH cur1 INTO email_a;
		IF done THEN
			LEAVE l1;
		ELSE
			SET cadena = CONCAT(cadena,CONCAT(email_a,";"));
		END IF;
	END LOOP;
	SET cadena = SUBSTRING(cadena,1,LENGTH(cadena)-1);

	CLOSE cur1;

	SELECT cadena;
END;

CALL crear_lista_emails_alumnos();

-- 		TRIGGERS : 



















