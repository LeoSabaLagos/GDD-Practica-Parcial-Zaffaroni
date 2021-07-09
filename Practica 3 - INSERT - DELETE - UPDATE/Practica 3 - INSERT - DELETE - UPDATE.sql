-- 14. Crear una consulta que liste todos los clientes que vivan en California ordenados por compañía.
SELECT company, customer_num, lname, fname
FROM customer
WHERE state = 'CA'
ORDER BY 1 -- ORDER BY company

/* 15. Obtener un listado de la cantidad de productos únicos comprados a cada fabricante, 
en donde el total comprado a cada fabricante sea mayor a 1500. 
El listado deberá estar ordenado por cantidad de productos comprados de mayor a menor.*/
SELECT manu_code, COUNT(DISTINCT stock_num) Cant_Productos
FROM items 
GROUP BY manu_code
HAVING SUM(quantity * unit_price) > 1500
ORDER BY Cant_Productos DESC -- ORDER BY 2 DESC

/* 16. Obtener un listado con el código de fabricante, nro de producto, la cantidad vendida (quantity), 
y el total vendido (quantity x unit_price), para los fabricantes cuyo código tiene una “R” como segunda letra. 
Ordenar el listado por código de fabricante y nro de producto. */
SELECT manu_code, 
	   stock_num AS Producto,
	   SUM(quantity) AS Cant_Vendida,
	   -- COUNT(quantity) AS Cant_Vendida seria cuantas veces se hizo una venta de ese producto
	   SUM(quantity * unit_price) AS Total_Vendido
FROM items
WHERE manu_code LIKE '_R%'
GROUP BY manu_code, stock_num
ORDER BY 1,2

/* 17. Crear una tabla temporal OrdenesTemp que contenga las siguientes columnas: 
cantidad de órdenes por cada cliente, 
primera y última fecha de orden de compra (order_date) del cliente. 

Realizar una consulta de la tabla temp OrdenesTemp en donde la primer fecha de compra 
sea anterior a '2015-05-23 00:00:00.000', ordenada por fechaUltimaCompra en forma descendente. */
SELECT customer_num, 
	   COUNT(*) AS cant_Ordenes, 
	   MIN(order_date) AS primera_orden,
	   MAX(order_date) AS ultima_orden
INTO #OrdenesTemp
FROM orders
GROUP BY customer_num

SELECT customer_num , ultima_orden , primera_orden 
FROM #OrdenesTemp
WHERE YEAR(primera_orden) <= 2015 
	  AND MONTH(primera_orden) <= 5 
	  AND DAY(primera_orden) <= 23
ORDER BY ultima_orden DESC

/* 18. Consultar la tabla temporal del punto anterior 
y obtener la cantidad de clientes con igual cantidad de compras. 
Ordenar el listado por cantidad de compras en orden descendente */
SELECT COUNT(customer_num) cantClientes, cant_Ordenes
FROM #OrdenesTemp
GROUP BY cant_Ordenes
ORDER BY 2 DESC  

-- 19. Desconectarse de la sesión. Volver a conectarse y ejecutar SELECT * from #ordenesTemp. Que sucede?
/* Cuando se desconecta el usuario de la sesión al ser temporal la tabla a consultar se elimina, 
por lo tanto no se puede volver a consultar a esa tabla temporal */

/* 20. Se desea obtener la cantidad de clientes por cada state y city, 
donde los clientes contengan el string ‘ts’ en el nombre de compañía, 
el código postal este entre 93000 y 94100 
y la ciudad no sea 'Mountain View'. 
Se desea el listado ordenado por ciudad */
SELECT COUNT(customer_num) cant_Clientes,
	   state,
	   city
FROM customer
WHERE company LIKE '%ts%'
	  AND zipcode BETWEEN 93000 AND 94100
	  AND city != 'Mountain View'
GROUP BY state, city
ORDER BY city

/* 21. Para cada estado, obtener la cantidad de clientes referidos. 
Mostrar sólo los clientes que hayan sido referidos 
cuya compañía empiece con una letra que este en el rango de ‘A’ a ‘L’.*/
SELECT state, COUNT(*) cant_clientes_referidos
FROM customer
WHERE company LIKE '[A-L]%' 
	  AND customer_num_referedBy IS NOT NULL
GROUP BY state


/* 22. Se desea obtener el promedio de lead_time por cada estado, 
donde los Fabricantes tengan una ‘e’ en manu_name y el lead_time sea entre 5 y 20.*/
SELECT state AS Estado , AVG(lead_time) AS Promedio_Lead 
FROM manufact
WHERE manu_name LIKE '%e%' 
	  AND lead_time BETWEEN 5 AND 20
GROUP BY state

/* 23. Se tiene la tabla units, de la cual se quiere saber la cantidad de unidades 
que hay por cada tipo (unit) que no tengan en nulo el descr_unit, 
y además se deben mostrar solamente los que cumplan que la cantidad mostrada se superior a 5. 
Al resultado final se le debe sumar 1 */
SELECT unit , COUNT(*) + 1 AS cant_units 
FROM units
WHERE unit_descr IS NOT NULL
GROUP BY unit 
HAVING (COUNT(*)+1) > 5 
-- HAVING COUNT(*) > 5  , Para mi esto está mal

------------------------------------------------------------------------------------------------------------------------------------------------
-- Práctica de INSERT, UPDATE y DELETE.

/* 1. Crear una tabla temporal #clientes a partir de la siguiente consulta
SELECT * FROM customer */
SELECT *
INTO #clientes
FROM customer

/* 2. Insertar el siguiente cliente en la tabla #clientes
Customer_num 144
Fname Agustín
Lname Creevy
Company Jaguares SA
State CA
City Los Angeles
*/

INSERT INTO #clientes (customer_num, fname, lname, company, state, city)
VALUES(144,'Agustin','Creevy','Jaguares SA','CA','Los Angeles')

/* 3. Crear una tabla temporal #clientesCalifornia con la misma estructura de la tabla customer.
Realizar un insert masivo en la tabla #clientesCalifornia con 
todos los clientes de la tabla customer cuyo state sea CA.*/
SELECT *
INTO #clientesCalifornia
FROM customer
WHERE state = 'CA'

/* 4. Insertar el siguiente cliente en la tabla #clientes:
Un cliente que tenga los mismos datos del cliente 103, 
pero cambiando en customer_num por 155.
Valide lo insertado*/

INSERT INTO #clientes(customer_num, fname, lname, company, address1, address2, city, state, zipcode, phone)
SELECT 155, fname, lname, company, address1, address2, city, state, zipcode, phone
FROM customer
WHERE customer_num = 103

/* 5. Borrar de la tabla #clientes los clientes 
cuyo campo zipcode esté entre 94000 y 94050 
y la ciudad comience con ‘M’. 
Validar los registros a borrar antes de ejecutar la acción.*/

DELETE FROM #clientes
WHERE zipcode BETWEEN 94000 AND 94050
	  AND city LIKE 'M%'

/* 6. Borrar de la tabla #clientes todos los clientes que no posean órdenes de compra en la tabla orders. 
(Utilizar un subquery).*/

DELETE FROM #clientes 
WHERE customer_num NOT IN (	SELECT DISTINCT customer_num FROM orders )

/* 7. Modificar los registros de la tabla #clientes cambiando el campo state por ‘AK’ 
y el campo address2 por ‘Barrio Las Heras’ para los clientes que vivan en el state 'CO'. 
Validar previamente la cantidad de registros a modificar.*/
UPDATE #clientes SET 
	state = 'AK',
	address2 = 'Barrio Las Heras'
WHERE state = 'CO'

/* 8. Modificar todos los clientes de la tabla #clientes, 
agregando un dígito 1 delante de cada número telefónico, 
debido a un cambio de la compañía de teléfonos.*/
UPDATE #clientes SET 
	phone = '1' + phone

/* 9.  Comenzar una transacción, dentro de ella realizar:
a. Insertar un registro en la tabla #clientes con los siguientes 4 datos
i. Customer_num 166
ii. Lname apellido
iii. State CA
iv. Company nombre empresa
*/

-- a
BEGIN TRANSACTION 
INSERT INTO #clientes (customer_num,lname,state,company) 
VALUES (166,'apellido', 'CA', 'nombre empresa') 

DELETE FROM #clientesCalifornia 
SELECT * FROM #clientes 
WHERE customer_num=166 

SELECT COUNT(*) 
FROM #clientesCalifornia 

ROLLBACK TRANSACTION 

SELECT * FROM #clientes 
WHERE customer_num=166 

SELECT COUNT(*) 
FROM #clientesCalifornia

/*b. Borrar los registros de la tabla #clientesCalifornia
Consultar los datos de las tablas #clientes y #clientesCalifornia, y asegurarse de que se haya realizado las operaciones.
Realizar un ROLLBACK y volver a chequear la información, que pasó??*/

/* Se canceló la transacción, entonces se realizó un rollback de todo lo sucedido dentro de la transacción 
(Se devolvieron a la tabla #clientesCalifornia todos los registros que tenian customer_num, previamente eliminados)
Para haber confirmado está accion tendria que haber usado COMMIT TRANSACTION, esto confirma la transaccion a realizar
y deja los objetos afectados en el estado que estaban dentro de la transaccion sin posibilidad de realizar ROLLBACK TRANSACTION */