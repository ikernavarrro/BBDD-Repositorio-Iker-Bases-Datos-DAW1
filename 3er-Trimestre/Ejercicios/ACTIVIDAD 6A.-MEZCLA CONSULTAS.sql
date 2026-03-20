/*EXAMEN TIPO DML-QL-Consultas*/

/*1.- Mostrar todos los empleados que son comerciales y han nacido entre 1965 y 1975. Mostrar el nombre y sus ventas. */
SELECT * FROM EMPLEADOS;

SELECT nombre, ventas
FROM empleados
WHERE LOWER(puesto) = 'comercial' AND EXTRACT(YEAR FROM fnacimiento) BETWEEN 1965 AND 1975;

/*2.- Mostrar cuantos empleados trabajan en oficinas de Madrid.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

SELECT COUNT(*)
FROM empleados
WHERE idoficina IN (
    SELECT idoficina
    FROM oficinas
    WHERE LOWER(ciudad) = 'madrid');

/*3.- Mostrar los nombres de los empleados que no han realizado ning�n pedido. */
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;

SELECT nombre
FROM empleados
WHERE idempleado NOT IN (
    SELECT idvendedor
    FROM pedidos);

/*4.- Mostrar el n�mero de oficina, nombre del director, regi�n y ventas de las oficinas ordenadas por su regi�n. 
Si tienen igual regi�n aparecer�n primero las que m�s ventas tengan. */
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.idoficina, e.nombre AS "Nombre Director", o.region, o.ventas
FROM oficinas o JOIN empleados e ON e.idempleado = o.director
ORDER BY region, ventas DESC;

/*4B.- Si quiero que aparezcan todas las oficinas independientemente de que tengan director o no �C�mo lo har�amos? */

// Hariamos una LEFT JOIN para mostrar tambien donde el campo que las une sea null en oficinas.
SELECT o.idoficina, e.nombre AS "Nombre Director", o.region, o.ventas
FROM oficinas o LEFT JOIN empleados e ON e.idempleado = o.director
ORDER BY region, ventas DESC;

/*5.- Mostrar todos los pedidos que han sido realizados en Julio del a�o 1997. Mostrad todos los datos de pedidos. */
SELECT * FROM PEDIDOS;

SELECT *
FROM pedidos
WHERE EXTRACT(YEAR FROM fpedido) = 1999 AND EXTRACT(MONTH FROM fpedido) = 5;
//WHERE EXTRACT(YEAR FROM fpedido) = 1997 AND EXTRACT(MONTH FROM fpedido) = 7

/*6.- Mostrar de cada pedido, el nombre del cliente, nombre del empleado, fecha del pedido en formato largo
(p ej: mi�rcoles, 6 de enero de 2018), descripci�n del producto e importe de sus pedidos. */
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;
//FORMATO FECHA LARGO
SELECT p. codigo, c.nombre AS "Nombre Cliente", e.nombre AS "Nombre Empleado", TO_CHAR(p.fpedido, 'fmday, dd "de" fmmonth "de" YYYY', 'NLS_DATE_LANGUAGE = SPANISH') AS "Feha Formato Largo", pr.descripcion , SUM(lp.cantidad*lp.punitario) || '€' AS "Importe Total"
FROM clientes c JOIN pedidos p ON c.idcliente = p.idcliente 
    JOIN empleados e ON e.idempleado = p.idvendedor 
    JOIN lineas_pedidos lp ON lp.codigo = p.codigo 
    JOIN productos pr ON lp.fabricante = pr.idfabricante AND lp.producto = pr.idproducto
GROUP BY p.codigo, c.nombre, e.nombre, p.fpedido, pr.descripcion
ORDER BY p.codigo;

/*7.- Mostrar de cada empleado: el correo electr�nico que ser� un campo que se forme por la inicial del nombre 
seguida del primer apellido y del segundo apellido. Tras esto aparecer� �@zabalburu.org� y su fecha de contrato.
Por ejemplo para Alfonso Garcia Jimenez su correo ser� agarciajimenez@zabalburu.org.*/
SELECT * FROM EMPLEADOS;

SELECT LOWER(SUBSTR(nombre, 1, 1) || SUBSTR(nombre,INSTR(nombre, ' ',1,1)+1,INSTR(nombre, ' ',1,2)-INSTR(nombre, ' ',1,1)-1) || SUBSTR(nombre,INSTR(nombre, ' ',1,2)+1) || '@zabalburu.org') AS "Correo Empleado", fcontrato
FROM empleados;

/*8.- Mostrar el nombre de los empleados, nombre de sus jefes, sus ventas y las de sus jefes.
En el listado deben aparecer todos los empleados, tanto si tienen, jefe, como si no. */
SELECT * FROM EMPLEADOS;

SELECT e.nombre AS "Nombre Empleado", j.nombre AS "Nombre Jefe", e.ventas AS "Ventas Empleado", j.ventas AS "Ventas Jefe" 
FROM empleados e LEFT JOIN empleados j ON e.jefe = j.idempleado;

/*9.- Listar los empleados con una cuota superior a la de su jefe; Solo queremos saber el nombre
y la cuota del empleado. */
SELECT * FROM EMPLEADOS;

SELECT nombre, cuota
FROM empleados e
WHERE EXISTS (
    SELECT *
    FROM empleados j
    WHERE e.jefe = j.idempleado AND e.cuota > j.cuota);

/*10.- Hallar el empleado que hizo el primer pedido en la empresa. Mostrad nombre del empleado,
fecha de pedido, a�os que han pasado. */
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;

SELECT e.nombre, p.fpedido, TRUNC(MONTHS_BETWEEN(SYSDATE, p.fpedido) / 12) AS "Años"
FROM empleados e JOIN pedidos p ON e.idempleado = p.idvendedor
WHERE fpedido=(
    SELECT MIN(fpedido)
    FROM pedidos);


/*11.- Por cada fabricante, mostrar cuantos productos tiene, el precio medio de sus productos (redondeados a 2 decimales),
el precio m�s barato y el precio m�s caro. Los campos de precios deben aparecer con dos decimales y el s�mbolo del euro por detr�s.
*/
SELECT * FROM PRODUCTOS;

SELECT idfabricante AS "Fabricante", COUNT(*) AS "Total Productos", ROUND(AVG(punitario),2) || '€' AS "Precio Medio", MIN(punitario) || '€' AS "Precio Más Barato", MAX(punitario) || '€' AS "Precio Más Caro"
FROM productos
GROUP BY idfabricante;


/*11B.- De la pregunta anterior solo mostrar aquellos fabricantes cuyo precio m�s alto sea m�s del doble de la media del precio
de sus productos.*/
SELECT idfabricante AS "Fabricante", COUNT(*) AS "Total Productos", ROUND(AVG(punitario),2) || '€' AS "Precio Medio", MIN(punitario) || '€' AS "Precio Más Barato", MAX(punitario) || '€' AS "Precio Más Caro"
FROM productos
GROUP BY idfabricante
HAVING MAX(punitario)> (AVG(punitario)*2);

/*12.- Listar la oficina que tenga un objetivo mayor de las que tienen director. 
Se deben mostrar los campos de n�mero de oficina, nombre del director, objetivo y 
un objetivo para el a�o que viene que ser� el objetivo incrementado en un 5%. 
A este nuevo campo lo vamos a denominar Objetivo 2021. */
SELECT * FROM OFICINAS;
 
SELECT o.idoficina AS "Número Oficina", e.nombre AS "Nombre Director", o.objetivo "Objetivo Actual", o.objetivo*1.05 AS "Objetivo 2027"
FROM oficinas o JOIN empleados e ON o.director = e.idempleado
WHERE o.objetivo =(
    SELECT MAX(objetivo)
    FROM oficinas
    WHERE director IS NOT NULL );

/*13.- Mostrar por cada cliente su nombre, fecha de sus pedidos, y calcular la fecha en la que ha sido enviado, 
calcul�ndose esta de la siguiente forma:

Si el pedido es inferior a 5000 se env�a en 15 d�as.
Si el pedido es superior a 5000 e inferior a 15000 se env�a en 10 d�as.
Si el pedido es superior a 15000 e inferior a 30000 se env�a en 5 d�as.
Si el pedido es superior a 30000 se env�a al d�a siguiente.

Tanto la fecha del pedido como la fecha del env�o debe ser mostrada con el siguiente formato:
d�a de mes de a�o (por ejemplo: 7 de marzo de 2012).
*/
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT c.nombre AS "Nombre Cliente", p.fpedido AS "Fecha Pedido", 
FROM clientes;


/*14.- Mostrar por cada producto (identificado por su fabricante y producto) su descripci�n, precio unitario y
mostrar un campo m�s denominado cantidad de ventas que muestre un texto dependiendo de la cantidad total
que de ese producto ha sido vendido a los clientes en el a�o 2001, si es inferior a 10 mostraremos �poco vendido�,
si est� entre 10 y 50 mostraremos �NOTABLE�, si es superior a 50 mostraremos �MUY VENDIDO�.
*/



