/* 1.
Mostrar 
	el C�digo del fabricante, 
	nombre del fabricante, 
	tiempo de entrega 
	y monto Total de productos vendidos, 

ordenado por nombre de fabricante. 

En caso que el fabricante no tenga ventas, mostrar el total en NULO.
*/

/* 2. 
Mostrar en una lista de a pares, 
	el c�digo y descripci�n del producto, 
	y los pares de fabricantes que fabriquen el mismo producto. 
	
En el caso que haya un �nico fabricante deber� mostrar el C�digo de fabricante 2 en nulo. 

Ordenar el resultado por c�digo de producto.

El listado debe tener el siguiente formato:

Nro. de Producto	 Descripcion	C�d. de fabric. 1	C�d. de fabric. 2
(stock_num)			(Description)	  (manu_code)		  (manu_code)
*/

/* 3. 
Listar todos los clientes que hayan tenido m�s de una orden.

a) En primer lugar, escribir una consulta usando una subconsulta.
b) Reescribir la consulta utilizando GROUP BY y HAVING.

La consulta deber� tener el siguiente formato:
	N�mero_de_Cliente	Nombre		Apellido
	(customer_num)		(fname)		(lname)
*/

/* 4. 
Seleccionar todas las �rdenes de compra 
	cuyo Monto total (Suma de p x q de sus items) sea menor al precio total promedio (avg p x q) 
	de todas las l�neas de las ordenes.

Formato de la salida

Nro. de Orden	Total
(order_num)		(suma)
*/

/* 5. 
Obtener por cada fabricante, 
	el listado de todos los productos de stock con precio unitario (unit_price) 
	mayor que el precio unitario promedio de dicho fabricante.

Los campos de salida ser�n: 
	manu_code, 
	manu_name, 
	stock_num, 
	description, 
	unit_price.
*/

/* 6. 
Usando el operador NOT EXISTS 
listar la informaci�n de �rdenes de compra que NO incluyan ning�n producto 
que contenga en su descripci�n el string � baseball gloves�. 

Ordenar el resultado por compa��a del cliente ascendente y n�mero de orden descendente.

El formato de salida deber� ser:
N�mero de Cliente	Compa��a	N�mero de Orden	  Fecha de la Orden
(customer_num)		(company)	  (order_num)		(order_date)
*/

 
/* 7. 
Obtener el 
	n�mero, 
	nombre y apellido de los clientes 
	
que NO hayan comprado productos del fabricante �HSK�. */

/* 8. 
Obtener el 
	n�mero, 
	nombre y apellido de los clientes 

que hayan comprado TODOS los productos del fabricante �HSK�.
*/


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Operador UNION

/* 9. 
Reescribir la siguiente consulta utilizando el operador UNION:
SELECT * FROM products
WHERE manu_code = �HRO� OR stock_num = 1
*/

/* 10. 
Desarrollar una consulta que devuelva 
	las ciudades y compa��as 
de todos los Clientes ordenadas alfab�ticamente por Ciudad 

pero en la consulta deber�n aparecer primero las compa��as situadas en Redwood City y luego las dem�s.

Formato:
	Clave de ordenamiento	Ciudad	 	Compa��a
	     (sortkey)			(city)		(company)
*/

/* 11.
Desarrollar una consulta que devuelva los dos tipos de productos m�s vendidos 
y los dos menos vendidos en funci�n de las unidades totales vendidas.

Formato
		Tipo Producto	Cantidad
		    101	           999		  
			189            888	  
			24		        �
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
WHERE manu_code = �HRO�

La vista deber� restringir la posibilidad de insertar datos que no cumplan con su criterio de selecci�n.
a. Realizar un INSERT de un Producto con manu_code=�ANZ� y stock_num=303. Qu� sucede?
b. Realizar un INSERT con manu_code=�HRO� y stock_num=303. Qu� sucede?
c. Validar los datos insertados a trav�s de la vista.
*/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- TRANSACCIONES

/* 14. 
Escriba una transacci�n que incluya las siguientes acciones:

� BEGIN TRANSACTION
o	Insertar un nuevo cliente llamado �Fred Flintstone� en la tabla de clientes (customer).
o	Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
� ROLLBACK TRANSACTION

Luego volver a ejecutar la consulta
� Seleccionar todos los clientes llamados Fred de la tabla de clientes (customer).
� Completado el ejercicio descripto arriba. 
	Observar que los resultados del segundo SELECT difieren con respecto al primero.
*/