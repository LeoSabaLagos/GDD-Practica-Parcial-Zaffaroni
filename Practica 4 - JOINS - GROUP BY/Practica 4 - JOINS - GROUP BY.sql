/* 1.
Obtener el número de cliente, la compañía, y número de orden de todos los clientes que tengan órdenes. 
Ordenar el resultado por número de cliente.*/
SELECT 
	clientes.customer_num AS Numero_Cliente,
	clientes.company AS Compañia,
	ordenes.order_num AS Numero_Orden
FROM customer clientes
JOIN orders ordenes ON ordenes.customer_num = clientes.customer_num
ORDER BY 1

/* 2.
Listar los ítems de la orden número 1004, incluyendo una descripción de cada uno.

El listado debe contener: 
	Número de orden (order_num), 
	Número de Item (item_num), 
	Descripción del producto (product_types.description), 
	Código del fabricante (manu_code), 
	Cantidad (quantity), 
	Precio total (unit_price*quantity). */

SELECT order_num AS Numero_Orden, 
	   item_num AS Numero_Item,
	   tipos_productos.description AS Descripcion_Producto,
	   i.manu_code AS Cod_Fabricante,
	   quantity AS Cantidad,
	   (i.unit_price * quantity) AS Precio_Total
FROM items i
	JOIN product_types tipos_productos ON tipos_productos.stock_num = i.stock_num  
WHERE order_num = 1004	    


/* 3.
Listar los items de la orden número 1004, incluyendo una descripción de cada uno.

El listado debe contener:
	Número de orden (order_num), 
	Número de Item (item_num), 
	Descripción del Producto (product_types.description), 
	Código del fabricante (manu_code), 
	Cantidad (quantity), 
	precio total (unit_price*quantity) 
	y Nombre del fabricante (manu_name). */

SELECT order_num AS Numero_Orden, 
	   item_num AS Numero_Item,
	   tipos_productos.description AS Descripcion_Producto,
	   i.manu_code AS Cod_Fabricante,
	   quantity AS Cantidad,
	   (i.unit_price * quantity) AS Precio_Total
FROM items i
	JOIN product_types tipos_productos ON tipos_productos.stock_num = i.stock_num  
WHERE order_num = 1004	


/* 4. 
Se desea listar todos los clientes que posean órdenes de compra.

Los datos a listar son los siguientes: 
	número de orden, 
	número de cliente, 
	nombre, 
	apellido 
	y compañía.*/

SELECT 
	ordenes.order_num AS Numero_Orden,
	clientes.customer_num AS Numero_Cliente,
	fname AS Nombre,
	lname AS Apellido,
	company AS Compañia
FROM customer clientes
JOIN orders ordenes ON ordenes.customer_num = clientes.customer_num

/* 5. 
Se desea listar todos los clientes que posean órdenes de compra. 

Los datos a listar son los siguientes: 
	número de cliente, 
	nombre, 
	apellido 
	y compañía. 
	
Se requiere sólo una fila por cliente.*/

SELECT 
	DISTINCT clientes.customer_num AS Numero_Cliente,
	fname AS Nombre,
	lname AS Apellido,
	company AS Compañia
FROM customer clientes
JOIN orders ordenes ON ordenes.customer_num = clientes.customer_num

/* 6. 
Se requiere listar para armar una nueva lista de precios los siguientes datos: 
	nombre del fabricante (manu_name), 
	número de stock (stock_num), 
	descripción (product_types.description), 
	unidad (units.unit), 
	precio unitario (unit_price) 
	y Precio Junio (precio unitario + 20%).*/

SELECT 
	manu_code AS Fabricante,
	p.stock_num AS Nro_Stock,
	pt.description AS Descripcion,
	u.unit AS Unidad,
	unit_price AS Precio_Unitario,
	(unit_price * 1.2) AS Precio_Junio
FROM products p
JOIN product_types pt ON pt.stock_num = p.stock_num
JOIN units u ON u.unit_code = p.unit_code

/* 7. 
Se requiere un listado de los items de la orden de pedido Nro. 1004 
con los siguientes datos: 
	Número de item (item_num), 
	descripción de cada producto (product_types.description), 
	cantidad (quantity) 
	y precio total (unit_price*quantity).*/

SELECT 
	   item_num AS Numero_Item,
	   tipos_productos.description AS Descripcion_Producto,
	   quantity AS Cantidad,
	   (unit_price * quantity) AS Precio_Total
FROM items i
	JOIN product_types tipos_productos ON tipos_productos.stock_num = i.stock_num  
WHERE order_num = 1004	

/* 8. 
Informar 
	el nombre del fabricante (manu_name) y 
	el tiempo de envío (lead_time) 
de los ítems de las Órdenes del cliente 104.*/

SELECT 
	DISTINCT manu_name AS Fabricante,
	m.lead_time AS Tiempo_Envio
FROM orders o
	JOIN items i ON i.order_num = o.order_num
	JOIN manufact m ON i.manu_code = m.manu_code
WHERE o.customer_num = 104

/* 9. 
Se requiere un listado de las todas las órdenes de pedido con los siguientes datos: 
	Número de orden (order_num), 
	fecha de la orden (order_date), 
	número de ítem (item_num), 
	descripción de cada producto (description), 
	cantidad (quantity) 
	y precio total (unit_price*quantity).*/

SELECT 
	o.order_num AS Numero_Orden,
	order_date AS Fecha_Orden,
	item_num AS Nro_Item,
	pt.description AS Descripcion_Producto,
	quantity AS Cant_Item,
	(unit_price * quantity) AS Precio_Total
FROM orders o
JOIN items i ON i.order_num = o.order_num
JOIN product_types pt ON pt.stock_num = i.stock_num 

/* 10. 
Obtener un listado con la siguiente información: 
	Apellido (lname) y Nombre (fname) del Cliente separado por coma, 
	Número de teléfono (phone) en formato (999) 999-9999. 

Ordenado por apellido y nombre*/

SELECT 
	lname + ' , ' + fname AS Cliente, 
	'(' + SUBSTRING(phone,1,3) + ') ' + SUBSTRING(phone,5,8) Telefono 
	-- SUBSTRING(string, start, length) , para seleccionar parte de un string
FROM customer 

/* 11. 
Obtener 
	la fecha de embarque (ship_date), 
	Apellido (lname) y Nombre (fname) del Cliente separado por coma 
	y la cantidad de órdenes del cliente. 
	
Para aquellos clientes que viven en el estado con descripción (sname) “California” 
y el código postal está entre 94000 y 94100 inclusive. 

Ordenado por fecha de embarque y, Apellido y nombre.*/

SELECT 
	ship_date AS Fecha_Embarque,
	lname + ',' + fname AS Cliente,
	COUNT(order_num) AS Cant_Ordenes_Cliente

FROM customer c
	JOIN orders o ON o.customer_num = c.customer_num
	JOIN state s ON s.state = c.state

WHERE s.sname = 'California' 
	  AND c.zipcode BETWEEN 94000 AND 94100
	  -- No se si tendrá que admitir ship_date NULLs, pero en la solución 

GROUP BY ship_date, lname + ',' + fname
ORDER BY ship_date, Cliente 

/* 12.
Obtener por cada fabricante (manu_name) y producto (description), 
	la cantidad vendida 
	y el Monto Total vendido (unit_price * quantity). 

Sólo se deberán mostrar los ítems de los fabricantes ANZ, HRO, HSK y SMT, 
para las órdenes correspondientes a los meses de mayo y junio del 2015.

Ordenar el resultado por el monto total vendido de mayor a menor.
*/

SELECT 
	m.manu_name AS Fabricante,
	pt.description AS Producto,
	SUM(i.quantity) Cant_Vendidos,
	SUM(i.unit_price * i.quantity) Monto_Total_Vendido
FROM orders o

JOIN items i ON i.order_num = o.order_num
JOIN product_types pt ON pt.stock_num = i.stock_num
JOIN manufact m ON m.manu_code = i.manu_code

WHERE i.manu_code IN ('ANZ','HRO','HSK','SMT')
	  AND MONTH(order_date) BETWEEN 5 AND 6		-- Incluye a los valores limites
 	  AND YEAR(order_date) = 2015

GROUP BY m.manu_name, pt.description
ORDER BY 4 DESC

/* 13. 
Emitir un reporte con 
	la cantidad de unidades vendidas 
	y el importe total por mes de productos, 
	
ordenado por importe total en forma descendente.

Formato: 
	Año/Mes		Cantidad	Monto_Total

*/

-- Solucion con año/mes concatenado
SELECT 
	CAST(YEAR(order_date) AS VARCHAR)+'/' +CAST(MONTH(order_date) AS VARCHAR) AnioMes, 
	SUM(quantity) Cantidad, 
	SUM(unit_price*quantity) Total 

FROM orders O 
	JOIN items i ON (o.order_num=i.order_num) 

GROUP BY CAST(YEAR(order_date) AS VARCHAR)+'/' +CAST(MONTH(order_date) AS VARCHAR) 
ORDER BY 3 DESC

-- Alternativa de solucion
SELECT	
	YEAR(o.order_date) AS Año, 
	MONTH(o.order_date) AS Mes,
	SUM(i.quantity) AS Cantidad,
	SUM(i.quantity * i.unit_price) Importe_Total_Mes
FROM orders o
JOIN items i ON i.order_num = o.order_num
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY 4 DESC