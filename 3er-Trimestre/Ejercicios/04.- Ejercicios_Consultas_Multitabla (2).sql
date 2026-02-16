/*Ejercicios Consultas Multitabla*/
/*1.- Listar las oficinas del este indicando para cada una de ellas su n�mero, ciudad, n�meros y nombres de sus empleados.*/
SELECT * FROM oficinas;
SELECT * FROM empleados;

SELECT o.idoficina, o.ciudad, e.idempleado, e.nombre 
FROM oficinas o, empleados e 
WHERE o.idoficina = e.idoficina AND LOWER(o.region) = 'este';
/*2.- Listar los pedidos mostrando su n�mero, importe, c�digo y nombre del cliente, su fecha de alta.*/
SELECT * FROM pedidos;
SELECT * FROM lineas_pedidos;
SELECT * FROM clientes;

SELECT p.codigo, SUM(lp.punitario * lp.cantidad), c.idcliente, c.nombre, c.falta 
FROM pedidos p, lineas_pedidos lp, clientes c 
WHERE c.idcliente = p.idcliente AND p.codigo = lp.codigo 
GROUP BY p.codigo, c.idcliente, c.nombre, c.falta;
/*3.- Listar los datos de cada uno de los empleados, la ciudad y regi�n en donde trabaja.*/
SELECT * FROM empleados;
SELECT * FROM oficinas;

SELECT e.* , o.ciudad, o.region
FROM empleados e, oficinas o
WHERE e.idoficina = o.idoficina;

/*4.- Listar las oficinas con objetivo superior a 590.000 � indicando para cada una de ellas el nombre de su director. */
SELECT * FROM oficinas;
SELECT * FROM empleados;

SELECT o.idoficina, e.nombre
FROM oficinas o, empleados e
WHERE o.idoficina = e.idoficina AND o.objetivo > 590000;
/*5.- Listar los pedidos con importe superior a 10000�. Se mostrar�n los c�digos y n�meros de pedidos, junto con su importe.*/
SELECT * FROM pedidos;
SELECT * FROM lineas_pedidos;

SELECT p.codigo, p.numpedido, SUM(lp.punitario * lp.cantidad)
FROM pedidos p, lineas_pedidos lp
WHERE p.codigo = lp.codigo
GROUP BY p.codigo, p.numpedido
HAVING SUM(lp.punitario * lp.cantidad) > 10000;

/*Posteriormente se incluir� el nombre del empleado que tom� el pedido y el nombre del cliente que lo solicit�.*/
SELECT * FROM empleados;
SELECT * FROM clientes;

SELECT p.codigo, p.numpedido, SUM(lp.punitario * lp.cantidad), e.nombre AS "EMPLEADO RESPONSABLE PEDIDO", c.nombre AS "NOMBRE CLIENTE" 
FROM pedidos p, lineas_pedidos lp, empleados e, clientes c
WHERE p.codigo = lp.codigo AND e.idempleado = p.idvendedor AND c.idcliente = p.idcliente
GROUP BY p.codigo, p.numpedido, e.nombre, c.nombre
HAVING SUM(lp.punitario * lp.cantidad) > 10000;

/*6.- Listar los empleados que realizaron sus primeros pedidos el d�a que fueron contratados. Mostrar el nombre del empleado,
fecha de contrato, c�digo e importe de esos pedidos.*/
SELECT * FROM empleados;
SELECT * FROM pedidos;
SELECT * FROM lineas_pedidos;

SELECT e.nombre, e.fcontrato, p.codigo, SUM(lp.punitario * lp.cantidad)
FROM empleados e, pedidos p, lineas_pedidos lp
WHERE e.idempleado = p.idvendedor AND p.codigo = lp.codigo AND p.fpedido = e.fcontrato
GROUP BY e.nombre, e.fcontrato, p.codigo;

/*7.- Listar los empleados con una cuota superior a la de su jefe; para cada empleado mostrar todos sus datos
y el n�mero, nombre y cuota de su jefe.*/
SELECT * FROM empleados;

SELECT eEmpleado.*, eJefe.idempleado AS "ID JEFE", eJefe.nombre AS "NOMBRE JEFE", eJefe.cuota AS "NOMBRE JEFE"
FROM empleados eEmpleado, empleados eJefe
WHERE eJefe.idempleado = eEmpleado.jefe AND eEmpleado.cuota > eJefe.cuota;

/*8.- Listar todos los pedidos en los que se hayan comprado cucharas o cuchillos. 
Debemos mostrar el n�mero de pedido, la cantidad e importe de las l�neas de pedido que las contengan 
el fabricante y la descripci�n del producto.*/
SELECT * FROM pedidos;
SELECT * FROM lineas_pedidos;
SELECT * FROM productos;

SELECT p.codigo, lp.cantidad, SUM(lp.punitario * lp.cantidad), pr.idfabricante, pr.descripcion
FROM pedidos p, lineas_pedidos lp, productos pr
WHERE p.codigo = lp.codigo AND pr.idproducto = lp.producto AND pr.idfabricante = lp.fabricante AND
(LOWER(pr.descripcion) LIKE '%cucharas%' OR LOWER(pr.descripcion) LIKE '%cuchillos%')
GROUP BY p.codigo, lp.cantidad, pr.idfabricante, pr.descripcion;

/*9.- Listar el n�mero de pedidos e importe de los mismos que cada empleado ha realizado a cada cliente.
Se mostrar� el n�mero y nombre del cliente, el n�mero y nombre del empleado, la cantidad de pedidos y el importe del pedido.*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;
SELECT c.idcliente, c.nombre AS "NOMBRE CLIENTE", e.idempleado, e.nombre AS "NOMBRE EMPLEADO", COUNT(*) AS "PEDIDOS REALIZADOS", SUM(lp.punitario * lp.cantidad)  AS "IMPORTE DE LOS PEDIDOS"
FROM PEDIDOS p, LINEAS_PEDIDOS lp, CLIENTES c, EMPLEADOS e
WHERE p.codigo = lp.codigo AND c.idcliente = p.idcliente AND e.idempleado = p.idvendedor
GROUP BY c.idcliente, c.nombre, e.idempleado, e.nombre;

/*10.- Listar el n�mero de oficinas que dirige cada uno de los empleados. */
/*Listar el n�mero de oficinas que tengan ventas que dirige cada uno de los empleados.*/ 
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;
SELECT e.idempleado, e.nombre, COUNT(o.idoficina) AS "OFICINAS DIRIGIDAS"
FROM empleados e, oficinas o
WHERE e.idempleado = o.director  
GROUP BY e.idempleado, e.nombre;