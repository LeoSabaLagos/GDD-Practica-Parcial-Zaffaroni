/* 1.
Mostrar 
	el Código del fabricante, 
	nombre del fabricante, 
	tiempo de entrega 
	y monto Total de productos vendidos, 

ordenado por nombre de fabricante. 

En caso que el fabricante no tenga ventas, mostrar el total en NULO.
*/

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

/* 3. 
Listar todos los clientes que hayan tenido más de una orden.

a) En primer lugar, escribir una consulta usando una subconsulta.
b) Reescribir la consulta utilizando GROUP BY y HAVING.

La consulta deberá tener el siguiente formato:
	Número_de_Cliente	Nombre		Apellido
	(customer_num)		(fname)		(lname)
*/

/* 4. 
Seleccionar todas las Órdenes de compra 
	cuyo Monto total (Suma de p x q de sus items) sea menor al precio total promedio (avg p x q) 
	de todas las líneas de las ordenes.

Formato de la salida

Nro. de Orden	Total
(order_num)		(suma)
*/

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

/* 6. 
Usando el operador NOT EXISTS 
listar la información de órdenes de compra que NO incluyan ningún producto 
que contenga en su descripción el string ‘ baseball gloves’. 

Ordenar el resultado por compañía del cliente ascendente y número de orden descendente.

El formato de salida deberá ser:
Número de Cliente	Compañía	Número de Orden	  Fecha de la Orden
(customer_num)		(company)	  (order_num)		(order_date)
*/

 
/* 7. 
Obtener el 
	número, 
	nombre y apellido de los clientes 
	
que NO hayan comprado productos del fabricante ‘HSK’. */

/* 8. 
Obtener el 
	número, 
	nombre y apellido de los clientes 

que hayan comprado TODOS los productos del fabricante ‘HSK’.
*/


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Operador UNION

/* 9. 
Reescribir la siguiente consulta utilizando el operador UNION:
SELECT * FROM products
WHERE manu_code = ‘HRO’ OR stock_num = 1
*/

/* 10. 
Desarrollar una consulta que devuelva 
	las ciudades y compañías 
de todos los Clientes ordenadas alfabéticamente por Ciudad 

pero en la consulta deberán aparecer primero las compañías situadas en Redwood City y luego las demás.

Formato:
	Clave de ordenamiento	Ciudad	 	Compañía
	     (sortkey)			(city)		(company)
*/

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

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- VISTAS

/* 12. 
Crear una Vista llamada ClientesConMultiplesOrdenes basada en la consulta realizada en el punto 3.b
con los nombres de atributos solicitados en dicho punto.
*/

/* 13.
Crear una Vista llamada Productos_HRO en base a la consulta

SELECT * FROM products
WHERE manu_code = “HRO”

La vista deberá restringir la posibilidad de insertar datos que no cumplan con su criterio de selección.
a. Realizar un INSERT de un Producto con manu_code=’ANZ’ y stock_num=303. Qué sucede?
b. Realizar un INSERT con manu_code=’HRO’ y stock_num=303. Qué sucede?
c. Validar los datos insertados a través de la vista.
*/

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