/*Ejercicios Consultas JOIN*/
/*1.- Listar las oficinas del este indicando para cada una de ellas su n�mero, 
ciudad, n�meros y nombres de sus empleados.Mostrar todas las oficinas aunque no tengan 
empleados asignados*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.idoficina, o.ciudad, e.idempleado, e.nombre
FROM oficinas o LEFT JOIN empleados e ON o.idoficina = e.idoficina
WHERE LOWER(o.region) IN ('este')
ORDER BY 1; 

/*2.- Listar los pedidos mostrando su n�mero, 
importe, c�digo y nombre del cliente,
su fecha de alta.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM CLIENTES;

SELECT p.numpedido, SUM(lp.punitario * lp.cantidad) AS "IMPORTE PEDIDO", c.idcliente, c.nombre, c.falta AS "FECHA ALTA"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo JOIN clientes c ON p.idcliente=c.idcliente
GROUP BY p.numpedido,c.idcliente, c.nombre, c.falta;

/*3.- Listar los datos de cada uno de los empleados, 
la ciudad y regi�n en donde trabaja.
Mostrar todos los empleados aunque no tengan oficina asignada.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

SELECT e.nombre, o.ciudad, o.region
FROM empleados e LEFT JOIN oficinas o ON e.idoficina=o.idoficina;

/*4.- Listar las oficinas con objetivo superior a 590.000 �
indicando para cada una de ellas el nombre de su director. Mostrar todas las oficinas
aunque no tengan director asignado.*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT e.nombre AS "NOMBRE DIRECTOR/A", o.*
FROM empleados e RIGHT JOIN oficinas o ON e.idempleado=o.director
WHERE o.objetivo > 590000;

/*5.- Listar los pedidos con importe superior a 10000�. 
Se mostrar�n los c�digos y n�meros de pedidos, junto con su importe.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad) AS "IMPORTE PEDIDO"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo
GROUP BY p.codigo, p.numpedido
HAVING SUM(lp.punitario*lp.cantidad) > 10000;

/*Posteriormente se incluir� el nombre del empleado que tom� el pedido 
y el nombre del cliente que lo solicit�.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM CLIENTES;
SELECT e.nombre AS "EMPLEADO",c.nombre AS "CLIENTE",p.codigo, p.numpedido, SUM(lp.punitario*lp.cantidad) AS "IMPORTE PEDIDO"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo JOIN empleados e ON e.idempleado=p.idvendedor JOIN clientes c ON c.idcliente=p.idcliente
GROUP BY e.nombre,c.nombre,p.codigo, p.numpedido
HAVING SUM(lp.punitario*lp.cantidad) > 10000;

/*6.- Listar los empleados que realizaron sus primeros pedidos el d�a que fueron contratados. Mostrar el nombre del empleado,
fecha de contrato, c�digo e importe de esos pedidos.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT e.nombre, e.fcontrato, p.codigo,SUM(lp.punitario * lp.cantidad)
FROM empleados e JOIN pedidos p ON e.idempleado= p.idvendedor JOIN lineas_pedidos lp ON lp.codigo=p.codigo
WHERE e.fcontrato = p.fpedido
GROUP BY e.nombre, e.fcontrato, p.codigo;

/*7.- Listar los empleados con una cuota superior a la de su jefe;
para cada empleado mostrar todos sus datos
y el n�mero, nombre y cuota de su jefe. Mostrar todos los empleados independientemente de si
tienen jefe o no.*/
SELECT * FROM EMPLEADOS;
SELECT e.*,j.* 
FROM empleados e LEFT JOIN empleados j ON j.idempleado = e.jefe
WHERE e.cuota > j.cuota OR e.jefe IS NULL;


/*8.- Listar todos los pedidos en los que se hayan comprado cucharas o cuchillos. 
Debemos mostrar el n�mero de pedido, la cantidad e importe de las l�neas de pedido que las contengan 
el fabricante y la descripci�n del producto.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM PRODUCTOS;

SELECT p.numpedido, SUM(lp.cantidad), SUM(lp.cantidad*lp.punitario) AS "IMPORTE", lp.fabricante, pr.descripcion
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo = lp.codigo JOIN productos pr ON pr.idproducto=lp.producto
WHERE LOWER(pr.descripcion) LIKE ('%cuchara%') OR LOWER(pr.descripcion) LIKE ('%cuchillo%')
GROUP BY p.numpedido, lp.fabricante, pr.descripcion;


/*9.- Listar el n�mero de pedidos e importe de los mismos que cada empleado ha realizado a cada cliente.
Se mostrar� el n�mero y nombre del cliente, el n�mero y nombre del empleado, la cantidad de pedidos y el importe del pedido.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT  c.idcliente, c.nombre, e.idempleado, e.nombre, COUNT(DISTINCT p.codigo) AS "CANTIDAD DE PEDIDOS", SUM(lp.cantidad * lp.punitario) AS "IMPORTE TOTAL"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo = lp.codigo JOIN clientes c ON c.idcliente=p.idcliente JOIN empleados e ON e.idempleado=p.idvendedor
GROUP BY c.idcliente, c.nombre, e.idempleado, e.nombre;

/*10.- Listar el n�mero de oficinas con su ciudad y region
que dirige cada uno de los empleados mostrando su n�mero,nombre y fecha de contrato.
Mostrar los datos de los empleados aunque no dirijan oficinas */
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.idoficina, o.ciudad , o.region, e.idempleado, e.nombre, e.fcontrato
FROM oficinas o RIGHT JOIN empleados e ON e.idempleado=o.director;

/*Listar el n�mero de oficinas que tengan ventas que dirige cada uno de los empleados.*/ 
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.idoficina, o.ciudad , o.region, e.idempleado, e.nombre, e.fcontrato
FROM oficinas o JOIN empleados e ON e.idempleado=o.director AND o.ventas > 0;