/*EJERCICIO CONSULTAS SIMPLES 1*/

/*1.- Obtener una lista de todos los productos indicando para cada uno 
su identificativo de fabricante, identificativo de producto, descripci�n,
precio y precio con IVA incluido (es el precio anterior aumentado en un 21%). */
SELECT * FROM productos;
SELECT idfabricante, idproducto, descripcion, punitario, TO_CHAR(punitario*1.21,'9990D00') AS "PUNITARIO CON IVA" FROM productos; 
INSERT INTO PRODUCTOS(idfabricante,idproducto,descripcion,punitario) VALUES ('asa','12001','tornillo',0.21);

/*2.- De cada l�nea de pedido queremos saber su n�mero de pedido, fabricante, producto,
cantidad, precio unitario y calcularemos su importe. */
SELECT * FROM lineas_pedidos;
SELECT codigo, fabricante, producto, cantidad, punitario, TO_CHAR(punitario*cantidad,'9990D00') AS "IMPORTE" FROM lineas_pedidos;

/*3.- Obtener la lista de los clientes agrupados por c�digo de representante asignado,
visualizar todas las columnas de la tabla. */
SELECT * FROM clientes;
SELECT * FROM clientes ORDER BY representante;

/*4.- Obtener las oficinas ordenadas por orden alfab�tico de regi�n y 
dentro de cada regi�n por ciudad, si hay m�s de una oficina en la misma ciudad,
aparecer� primero la que tenga el n�mero de oficina mayor. */
SELECT * FROM oficinas;
SELECT * FROM oficinas ORDER BY region, ciudad, idoficina desc;

/*5.- Obtener los pedidos ordenados por fecha de pedido y
los que tengan la misma fecha por identificativo de empleado en orden ascendente.*/
SELECT * FROM pedidos;
SELECT * FROM pedidos ORDER BY fpedido, idvendedor; 

/*6.- Mostrar un listado de toda la informaci�n de los pedidos realizados en mayo de cualquier a�o.*/ 
SELECT * FROM pedidos;
SELECT * FROM pedidos WHERE EXTRACT(MONTH FROM fpedido)=5;

/*7.- Mostrar un listado de los n�meros de los empleados que tienen una oficina asignada.*/ 
SELECT * FROM empleados;
SELECT idempleado FROM empleados WHERE idoficina IS NOT NULL; 

/*8.- Mostrar un listado de los n�meros de las oficinas que no tienen director. */
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE director IS NULL;

/*9.- Mostrar un listado de los datos de las oficinas de las regiones del norte y del este
(tienen que aparecer primero las del norte y despu�s las del este).*/
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE LOWER(region) IN ('norte', 'este') ORDER BY region desc;

/*10.- Mostrar un listado de los empleados de nombre �Maria�. */
SELECT * FROM empleados;
SELECT * FROM empleados WHERE LOWER(nombre) LIKE '%maria%';

/*11.- Mostrar un listado de los productos cuya descripci�n sea manteles de color verde
(mirad como aparecen los valores). */
SELECT * FROM productos;
SELECT * FROM productos WHERE LOWER(descripcion) LIKE 'mantel %verde%';

/*12.- Mostrar un listado de los datos de todos los empleados que sean comerciales
y les corresponda la oficina 12.*/
SELECT * FROM empleados;
SELECT * FROM empleados WHERE LOWER(puesto) LIKE '%comercial' AND idoficina=12;

/*13.- Mostrar un listado de nombres de los empleados con una cuota mayor de 300.000
y ventas mayores que 300.000.*/
SELECT * FROM empleados;
SELECT nombre FROM empleados WHERE cuota > 300000 AND ventas > 300000; 

/*14.- Obtener los nombres de los empleados que no tengan asignada ninguna oficina.*/
SELECT * FROM empleados;
SELECT nombre FROM empleados WHERE idoficina IS NULL;

/*15.- Obtener los datos de las oficinas que tengan asignado un director.*/
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE director IS NOT NULL;

/*16.- Mostrar toda la informaci�n de las oficinas de Madrid.*/
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE UPPER(ciudad)= 'MADRID';

/*17.- Mostrar los datos de las oficinas que no tengan asignado un objetivo o ventas
o que lo tengan asignado a 0.*/
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE (objetivo IS NULL OR ventas IS NULL) OR (objetivo = 0 OR ventas = 0);

/*18.- Mostrar los datos de los clientes ordenados por fecha de alta 
de m�s nueva a m�s antigua a menor. Si hubiese clientes con la misma fecha de alta
aparecer�n ordenados por nombre en orde ascendente.*/
SELECT * FROM clientes;
SELECT * FROM clientes ORDER BY falta desc, nombre; 

/*19.- Mostrar los productos con existencias 0.*/
SELECT * FROM productos;
SELECT * FROM productos WHERE stock = 0;

/*20.- Mostrar los campos idproducto, descripci�n y fabricante de los productos
cuyo fabricante sea �asa�, �bra� o �duni�, ordenados por fabricante.*/
SELECT * FROM productos;
SELECT idproducto, descripcion, idfabricante FROM productos WHERE LOWER(idfabricante) IN ('asa', 'bra', 'duni') ORDER BY idfabricante; 

/*21.- Mostrar todos los pedidos de mayo del a�o 1999.*/
SELECT * FROM pedidos;
SELECT * FROM pedidos WHERE EXTRACT(MONTH FROM fpedido)=5 AND EXTRACT(YEAR FROM fpedido)=1999;

/*22.- Mostrar las oficinas cuyas ventas superen en un 10% los objetivos.*/
SELECT * FROM oficinas;
SELECT * FROM oficinas WHERE ventas > objetivo*1.10;

/*23.- Mostrar los datos de los productos cuyo idproducto acabe en �mg�.*/
SELECT * FROM productos;
SELECT * FROM productos WHERE idproducto LIKE '%mg';

/*24.- Mostrar los pedidos del segundo semestre.*/
SELECT * FROM pedidos;
SELECT * FROM pedidos WHERE EXTRACT(MONTH FROM fpedido)>6;

/*25.- Mostrar los datos de los empleados que sean directores.*/
SELECT * FROM empleados;
SELECT * FROM empleados WHERE LOWER(puesto) LIKE 'director%';

/*26.- Debemos mostrar de la tabla de empleados a todos los empleados con sus ventas
con el siguiente formato:
            El �titulo�.. ��nombre�.. ha sido contratado el 99/99/9999 .*/
SELECT * FROM empleados;    
SELECT 'El/La ' || puesto || ' con nombre ' || nombre || ' ha sido contratado/a el ' || fcontrato  FROM empleados; 
