/* Mostrar cual es el precio medio de los productos del fabricante asa */
SELECT * FROM productos;

SELECT TRUNC (AVG(punitario), 2) AS "MEDIA PRECIO PRODUCTOS" FROM productos WHERE LOWER(idfabricante)='asa';

/*Mostrar cual es la fecha en la que entró el primer empleado en la empresa*/
SELECT MIN(fcontrato) FROM empleados;

/*Mostrar cuantas oficinas hay en el este*/
SELECT COUNT(idoficina) FROM oficinas WHERE LOWER(region) = 'este';
/*Mostrar cuantas oficinas hay en el este que hayan ventas mayores a 300000*/
SELECT COUNT(idoficina) FROM oficinas WHERE LOWER(region) = 'este' AND ventas > 300000;

/*Mostrar la línea de pedido más cara y más barata*/
SELECT * FROM LINEAS_PEDIDOS;

SELECT MAX(punitario*cantidad),MIN(punitario*cantidad) FROM lineas_pedidos;

/*Mostrar el importe total que han realiado los clientes en mi empresa*/
SELECT * FROM lineas_pedidos;

SELECT SUM(punitario*cantidad) FROM lineas_pedidos;

/*MOSTRAR LA MEDIA DE PRECIO DE TODOS LOS PRODCUTOS*/
SELECT * FROM productos;

SELECT TRUNC (AVG(punitario),2) FROM productos;

/*Cada EMPLEADO de cuantos clientes es representante*/
SELECT * FROM empleados;
SELECT * FROM clientes;
SELECT representante, COUNT(idcliente) FROM clientes GROUP BY representante ORDER BY 2 DESC;

/*Cuantas ventas se han hecho en oficinas de cada ciudad*/
SELECT * FROM oficinas;
SELECT ciudad, COUNT(ventas) AS "Suma de las Ventas" FROM oficinas GROUP BY ciudad ORDER BY 2 DESC;

/*Por cada fabricante cual es el precio del producto más caro y cual es el más barato*/
SELECT * FROM productos;
SELECT idfabricante, MAX(punitario) AS "Precio Producto Más Caro", MIN(punitario) AS "Precio Producto Más Barato" FROM productos GROUP BY idfabricante;

/*Para cada fabricamte cual es la media del precio de sus productos*/
SELECT * FROM productos;
SELECT idfabricante, TRUNC(AVG(punitario),2) AS "Media Precio Productos" FROM productos GROUP BY idfabricante;

/*Para cada fabricante cuál es la media de los productos que no son manteles*/
SELECT * FROM productos;
SELECT idfabricante, TRUNC(AVG(punitario),2) AS "Media Precio Productos Que NO son manteles" FROM productos WHERE LOWER(descripcion) NOT LIKE '%mantel%' GROUP BY idfabricante;

/*Cuantos pedidos ha hecho cada cliente*/
SELECT * FROM pedidos;
SELECT idcliente, COUNT(idcliente) AS "PEDIDOS" FROM pedidos GROUP BY idcliente; 

/*Por cada cliente y año cuantos pedidos ha hecho*/
SELECT * FROM pedidos;
SELECT idcliente,EXTRACT(YEAR FROM fpedido) AS "AÑO", COUNT(numpedido) AS "PEDIDOS" FROM pedidos GROUP BY idcliente,EXTRACT(YEAR FROM fpedido) ORDER BY idcliente; 
/*Por cada cliente, año y mes cuantos pedidos ha hecho.*/
SELECT * FROM pedidos;
SELECT idcliente,EXTRACT(YEAR FROM fpedido) AS "AÑO",EXTRACT(MONTH FROM fpedido) AS "MES", COUNT(numpedido) AS "PEDIDOS" FROM pedidos GROUP BY idcliente,EXTRACT(YEAR FROM fpedido),EXTRACT(MONTH FROM fpedido) ORDER BY idcliente;

/*En cada oficina cuantos empleados hay*/
SELECT * FROM oficinas;
SELECT * FROM empleados;
SELECT idoficina, COUNT(idempleado) FROM empleados GROUP BY idoficina ORDER BY idoficina;

/*Mostrar solamente aquellas oficinas en las que trabajen más de 3 empleados*/
SELECT * FROM oficinas;
SELECT * FROM empleados;
SELECT idoficina, COUNT(idempleado) FROM empleados GROUP BY idoficina HAVING COUNT(idempleado) > 3 ORDER BY idoficina;