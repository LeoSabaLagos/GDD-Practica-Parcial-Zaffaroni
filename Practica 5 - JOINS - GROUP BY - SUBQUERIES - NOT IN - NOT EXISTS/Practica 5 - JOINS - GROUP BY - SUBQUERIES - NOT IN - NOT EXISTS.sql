/* 1.
Mostrar 
	el Código del fabricante, 
	nombre del fabricante, 
	tiempo de entrega 
	y monto Total de productos vendidos, 

ordenado por nombre de fabricante. 

En caso que el fabricante no tenga ventas, mostrar el total en NULO.
*/

SELECT 
	m.manu_code AS Cod_Fabricante,
	manu_name AS Nombre_Fabricante,
	lead_time AS Tiempo_Entrega,
	SUM(i.quantity * i.quantity) AS Monto_Total
FROM manufact m
LEFT JOIN items i ON i.manu_code = m.manu_code
GROUP BY m.manu_code, manu_name, lead_time
ORDER BY Nombre_Fabricante

/* 2. 
Mostrar en una lista de a pares, 
	el código y descripción del producto, 
	y los pares de fabricantes que fabriquen el mismo producto. 
	
En el caso que haya un único fabricante deberá mostrar el Código de fabricante 2 en nulo. 

Ordenar el resultado por código de producto.

El listado debe tener el siguiente formato:

Nro. de Producto	 Descripcion	Cód. de fabric. 1	Cód. de fabric. 2
(stock_num)			(Description)	  (manu_code)		  (manu_code)
*/

SELECT 
	p1.stock_num AS Nro_Producto,
	pt.description AS Descripcion,
	p1.manu_code AS Cod_Fab_1,
	p2.manu_code AS Cod_Fab_2
FROM products p1
JOIN product_types pt ON pt.stock_num = p1.stock_num
LEFT JOIN products p2 ON (p1.stock_num = p2.stock_num AND (p1.manu_code != p2.manu_code OR p2.manu_code IS NULL))
ORDER BY 1

/* 3. 
Listar todos los clientes que hayan tenido más de una orden.

a) En primer lugar, escribir una consulta usando una subconsulta.
b) Reescribir la consulta utilizando GROUP BY y HAVING.
c) Reescribir la consulta usando dos sentencias SELECT y una tabla temporal.

La consulta deberá tener el siguiente formato:
	Número_de_Cliente	Nombre		Apellido
	(customer_num)		(fname)		(lname)
*/

-- 3a
SELECT 
	customer_num AS Número_Cliente,
	fname AS Nombre,
	lname AS Apellido
FROM customer c
WHERE customer_num IN (
	SELECT customer_num FROM orders 
	GROUP BY customer_num HAVING COUNT(*) > 1
) 

-- 3b
SELECT 
	c.customer_num AS Número_Cliente,
	fname AS Nombre,
	lname AS Apellido
FROM customer c
JOIN orders o ON o.customer_num = c.customer_num
GROUP BY c.customer_num, fname, lname
HAVING COUNT(o.order_num) > 1

-- 3c



/* 4. 
Seleccionar todas las Órdenes de compra 
	cuyo Monto total (Suma de p x q de sus items) sea menor al precio total promedio (avg p x q) 
	de todas las líneas de las ordenes.

Formato de la salida

Nro. de Orden	Total
(order_num)		(suma)
*/

SELECT 
	 o.order_num AS Nro_Orden,
	 SUM(i.quantity * i.unit_price) AS Total
FROM orders o
JOIN items i ON i.order_num = o.order_num
GROUP BY o.order_num
HAVING SUM(i.quantity * i.unit_price) > 
	( SELECT AVG(quantity * unit_price) FROM items ) 
	-- Esta subquery es precio total promedio (avg p x q) de todas las líneas de las ordenes

/* 5. 
Obtener por cada fabricante, 
	el listado de todos los productos de stock con precio unitario (unit_price) 
	mayor que el precio unitario promedio de dicho fabricante.

Los campos de salida serán: 
	manu_code, 
	manu_name, 
	stock_num, 
	description, 
	unit_price.
*/

SELECT
	 m.manu_code,
	 manu_name,
	 p.stock_num,
	 pt.description,
	 p.unit_price
FROM manufact m

JOIN products p ON p.manu_code = m.manu_code
JOIN product_types pt ON pt.stock_num = p.stock_num

WHERE p.unit_price > 
	( SELECT AVG(unit_price) FROM products WHERE manu_code = m.manu_code)
	-- precio unitario promedio de dicho fabricante 

/* 6. 
Usando el operador NOT EXISTS 
Listar la información de órdenes de compra que 
NO incluyan ningún producto que contenga en su descripción el string ‘baseball gloves’. 

Ordenar el resultado por compañía del cliente ascendente y número de orden descendente.

El formato de salida deberá ser:
Número de Cliente	Compañía	Número de Orden	  Fecha de la Orden
(customer_num)		(company)	  (order_num)		(order_date)
*/

SELECT 
	o.customer_num AS Nro_Cliente,
	c.company AS Compañia,
	o.order_num AS Nro_Order,
	o.order_date AS Fecha_Orden 
FROM orders o 
JOIN customer c ON c.customer_num = o.customer_num
WHERE NOT EXISTS (
	SELECT i2.item_num
	FROM items i2 
	JOIN product_types pt ON pt.stock_num = i2.stock_num
	WHERE i2.order_num = o.order_num AND pt.description LIKE '%baseball gloves%'
	)
ORDER BY c.company ASC, o.order_num DESC

/* 7. 
Obtener el 
	número, 
	nombre y apellido de los clientes 
	
que NO hayan comprado productos del fabricante ‘HSK’. */

SELECT 
	c.customer_num AS Nro_Cliente,
	fname + ',' + lname AS Cliente
FROM customer c
WHERE c.customer_num NOT IN ( 
	SELECT c1.customer_num FROM customer c1 
	JOIN orders o ON o.customer_num = c1.customer_num
	JOIN items i ON i.order_num = o.order_num
	JOIN products p ON p.stock_num = i.stock_num
	WHERE p.manu_code = 'HSK'
	)

/* 8. 
Obtener el 
	número, 
	nombre y apellido de los clientes 

que hayan comprado TODOS los productos del fabricante ‘HSK’.
*/

SELECT 
    c.customer_num,
    c.fname,
    c.lname 
FROM customer C
   WHERE NOT EXISTS (
        SELECT p.stock_num
        FROM products p
        WHERE p.manu_code = 'HSK' AND NOT EXISTS (
                                -- todos los productos que el customer le compro a HSK
                                SELECT 1 
                                FROM orders o 
                                    JOIN items i ON o.order_num = i.order_num
                                WHERE   p.stock_num = i.stock_num 
                                        AND p.manu_code = i.manu_code 
                                        AND o.customer_num = c.customer_num))


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Operador UNION

/* 9. 
Reescribir la siguiente consulta utilizando el operador UNION:
SELECT * FROM products
WHERE manu_code = ‘HRO’ OR stock_num = 1
*/

SELECT * 
FROM products
WHERE manu_code = 'HRO'
UNION
SELECT * 
FROM products
WHERE stock_num = 1

/* 10. 
Desarrollar una consulta que devuelva  las ciudades y compañías 
de todos los Clientes ordenadas alfabéticamente por Ciudad 

pero en la consulta deberán aparecer primero las compañías situadas en Redwood City y luego las demás.

Formato:
	Clave de ordenamiento	Ciudad	 	Compañía
	     (sortkey)			(city)		(company)
*/

SELECT 1 AS sortkey, city AS Ciudad, company AS Compañia
FROM customer
WHERE city = 'Redwood City'
UNION
SELECT 2 AS sortkey, city AS Ciudad, company AS Compañia
FROM customer
WHERE city != 'Redwood City'
ORDER BY 1, 2

/* 11.
Desarrollar una consulta que devuelva los dos tipos de productos más vendidos 
y los dos menos vendidos en función de las unidades totales vendidas.

Formato
		Tipo Producto	Cantidad
		    101	           999		  
			189            888	  
			24		        …
		    4               1 
*/

SELECT 
	i.stock_num Tipo_Producto,
	SUM(i.quantity) Cantidad
FROM items i

WHERE i.stock_num IN (
	SELECT TOP(2) im.stock_num
	FROM items im 
	GROUP BY im.stock_num
	ORDER BY SUM(im.quantity) DESC
)
GROUP BY stock_num

UNION

SELECT 
	i.stock_num Tipo_Producto,
	SUM(i.quantity) Cantidad
FROM items i

WHERE i.stock_num IN (
	SELECT TOP(2) im.stock_num
	FROM items im 
	GROUP BY im.stock_num
	ORDER BY SUM(im.quantity)
)
GROUP BY stock_num
ORDER BY 2 DESC 

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- VISTAS

/* 12. 
Crear una Vista llamada ClientesConMultiplesOrdenes basada en la consulta realizada en el punto 3.b
con los nombres de atributos solicitados en dicho punto.
*/

GO
CREATE VIEW ClientesConMultiplesOrdenes
(Número_de_Cliente,Nombre,Apellido)
AS
	SELECT 
		customer_num AS Número_Cliente,
		fname AS Nombre,
		lname AS Apellido
	FROM customer c
	
	WHERE customer_num IN (
		SELECT customer_num 
		FROM orders 
		GROUP BY customer_num 
		HAVING COUNT(*) > 1
	) 


/* 13.
Crear una Vista llamada Productos_HRO en base a la consulta

SELECT * FROM products
WHERE manu_code = “HRO”

La vista deberá restringir la posibilidad de insertar datos que no cumplan con su criterio de selección.
a. Realizar un INSERT de un Producto con manu_code=’ANZ’ y stock_num=303. Qué sucede?
b. Realizar un INSERT con manu_code=’HRO’ y stock_num=303. Qué sucede?
c. Validar los datos insertados a través de la vista.
*/

GO
CREATE VIEW Productos_HRO
(stock_num,manu_code,unit_price,unit_code)
AS
	SELECT * FROM products
	WHERE manu_code = 'HRO'
	WITH CHECK OPTION

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- TRANSACCIONES

/* 14. 
Escriba una transacción que incluya las siguientes acciones:

• BEGIN TRANSACTION
o	Insertar un nuevo cliente llamado “Fred Flintstone” en la tabla de clientes (customer).
o	Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
• ROLLBACK TRANSACTION

Luego volver a ejecutar la consulta
• Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
• Completado el ejercicio descripto arriba. 
	Observar que los resultados del segundo SELECT difieren con respecto al primero.
*/

BEGIN TRANSACTION 
	INSERT INTO customer(customer_num,fname, lname)
	VALUES(1000,'Fred','Flintstone')

	SELECT * FROM customer
	WHERE fname = 'Fred' 
ROLLBACK TRANSACTION
END

-- El Rollback elimino el registro insertado dentro de la
-- transaccion porque era lo deseado al hacer el rollback

SELECT * FROM customer
WHERE fname = 'Fred'

/* 15. 
Se ha decidido crear un nuevo fabricante AZZ, quién proveerá parte de los mismos productos
que provee el fabricante ANZ, los productos serán los que contengan el string ‘tennis’ en su descripción.
	
	• Agregar las nuevas filas en la tabla manufact y la tabla products.

	• El código del nuevo fabricante será “AZZ”, 
	  el nombre de la compañía “AZZIO SA” 
	  y el tiempo de envío será de 5 días (lead_time).

	• La información del nuevo fabricante “AZZ” de la tabla Products 
	  será la misma que la del fabricante “ANZ” pero 
	  sólo para los productos que contengan 'tennis' en su descripción.

	• Tener en cuenta las restricciones de integridad referencial existentes, 
	  manejar todo dentro de una misma transacción.
*/

BEGIN TRANSACTION
	
	INSERT INTO manufact(manu_code,manu_name,lead_time)
	VALUES('AZZ','AZZIO SA',5)	

	INSERT INTO products (manu_code, stock_num, unit_price, unit_code) 
	SELECT
		'AZZ',
		p.stock_num,
		p.unit_price,
		p.unit_code 
	FROM products p 
		JOIN product_types t ON p.stock_num = t.stock_num 
	WHERE manu_code = 'ANZ' 
		  AND t.description LIKE '%tennis%'

COMMIT TRANSACTION  
	
SELECT * FROM products 
WHERE manu_code = 'AZZ'