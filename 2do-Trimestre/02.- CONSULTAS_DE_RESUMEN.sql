/************************/
/* CONSULTAS DE RESUMEN */
/************************/
/* 1.- Mostrar la cuota media y las ventas medias de todos los empleados.
Emplea la funci�n ROUND si te aparecen muchos decimales.*/
/*ROUND(funci�n(campo) ,n�decimales)*/
SELECT * FROM empleados;
SELECT AVG(cuota) AS "MEDIA CUOTAS", AVG(ventas) AS "MEDIA VENTAS" FROM empleados;

/* 2.- Mostrar la cuota media y las ventas medias de todos los empleados de la oficina 11,12 y 21. 
Emplea la funci�n ROUND si te aparecen muchos decimales.*/
/*ROUND(funci�n(campo) ,n�decimales)*/
SELECT * FROM empleados;
SELECT ROUND(AVG(cuota),2) AS "MEDIA CUOTAS", ROUND(AVG(ventas),2) AS "MEDIA VENTAS" FROM empleados WHERE idoficina IN (11,12,21);

/* 3.- Mostrar la cuota media y las ventas medias de todos los empleados de cada una de las oficinas.
El listado queremos que aparezca ordenado por oficina.
Emplea la funci�n ROUND si te aparecen muchos decimales.*/
/*ROUND(funci�n(campo) ,n�decimales)*/
SELECT * FROM empleados;
SELECT idoficina,ROUND(AVG(cuota),2) AS "MEDIA CUOTAS", ROUND(AVG(ventas),2) AS "MEDIA VENTAS" FROM empleados GROUP BY idoficina ORDER BY idoficina;

/* 4.- Mostrar la cuota media y las ventas medias de todos los empleados de cada una de las oficinas. 
En el listado solamente aparecer�n aquellas oficinas en las que el total de ventas supere los 300.000�.
El listado debe aparecer ordenado por oficina. Emplea la funci�n ROUND si te aparecen muchos decimales.*/
/* ROUND(funci�n(campo) ,n�decimales)*/
SELECT * FROM empleados;
SELECT idoficina,ROUND(AVG(cuota),2) AS "MEDIA CUOTAS", ROUND(AVG(ventas),2) AS "MEDIA VENTAS" FROM empleados GROUP BY idoficina HAVING AVG(ventas) > 300000 ORDER BY idoficina;

/* 5.- Mostrar en qu� fecha se realiz� el primer pedido.*/
SELECT * FROM pedidos;
SELECT MIN(fpedido) FROM pedidos;

/* 6.- Mostrar cu�ntos empleados est�n a cargo del empleado 118.*/
SELECT * FROM empleados;
SELECT COUNT(*) FROM empleados WHERE jefe = 118;

/* 7.- Mostrar cuantos pedidos ha realizado cada empleado a cada cliente.
Mostrar el n�mero de empleado, n�mero de cliente y el n�mero de pedidos realizados.
El listado aparecer� ordenado por empleado y dentro de cada empleado por n�mero de pedidos de mayor a menor.*/
SELECT * FROM pedidos;
SELECT idvendedor, idcliente ,COUNT(*) AS "Pedidos Realizados" FROM pedidos GROUP BY idvendedor, idcliente ORDER BY idvendedor, idcliente DESC;  

/* 8.- Mostrar cu�ntas oficinas han superado en ventas su objetivo.*/
SELECT * FROM oficinas;
SELECT COUNT(idoficina) FROM oficinas WHERE objetivo < ventas;

/* 9.- Mostrar el precio medio de los productos cada fabricante.
Mostrar el listado ordenado por precio medio de menor a mayor.*/
SELECT * FROM productos;
SELECT idfabricante, ROUND(AVG(punitario),2) AS "Precio Medio" FROM productos GROUP BY idfabricante ORDER BY 2;

/* 10.- Mostrar las oficinas en donde haya m�s de 1 tipo diferente de puesto de trabajo.*/
SELECT * FROM oficinas;
SELECT * FROM empleados;
SELECT idoficina FROM empleados GROUP BY idoficina HAVING COUNT(puesto) > 1; 

/* 11.- Mostrar el importe de cada pedido. Mostrar el c�digo de pedido y el importe.
El listado aparecer� ordenado por importe de mayor a menor.*/
SELECT * FROM lineas_pedidos;
SELECT codigo, SUM(punitario * cantidad) AS "Importe Total" FROM lineas_pedidos GROUP BY codigo ORDER BY 2 DESC;

/* 12.- Muestra solamente aquellos pedidos cuyo importe est� entre 10.000 y 30.000 euros.
Mostrar el c�digo de pedido y el importe. El listado aparecer� ordenado por c�digo de pedido de menor a mayor.*/
SELECT * FROM lineas_pedidos;
SELECT codigo, SUM(punitario * cantidad) AS "Importe Total" FROM lineas_pedidos GROUP BY codigo HAVING SUM(punitario * cantidad) BETWEEN 10000 AND 30000 ORDER BY codigo;

/* 13.- Mostrar en cada a�o cuantos clientes se han dado de alta en nuestra empresa.
Ordenaremos el listado por a�o de menor a mayor. */
SELECT * FROM clientes;
SELECT EXTRACT(YEAR FROM falta), COUNT(idcliente) FROM clientes GROUP BY EXTRACT(YEAR FROM falta) ORDER BY EXTRACT(YEAR FROM falta);

/* 14.- �Y si queremos mostrar solamente el n�mero de clientes que han sido dados de alta en los a�os 2002, 2005 y 2010?*/
SELECT * FROM clientes;
SELECT EXTRACT(YEAR FROM falta), COUNT(idcliente) FROM clientes WHERE EXTRACT(YEAR FROM falta) IN(2002,2005,2010)GROUP BY EXTRACT(YEAR FROM falta) ORDER BY EXTRACT(YEAR FROM falta);

/* 15.- Mostrar cuantos pedidos han sido enviados en el mismo a�o en el que han sido realizados, pero en diferente mes.*/
SELECT * FROM pedidos;
SELECT COUNT(*) FROM pedidos WHERE EXTRACT(YEAR FROM fenvio) = EXTRACT(YEAR FROM fpedido) AND EXTRACT(MONTH FROM fenvio) != EXTRACT(MONTH FROM fpedido);

/* 16.- Mostrar por cada director de oficina, cuantas oficinas dirige, 
qu� objetivo medio ten�a para sus oficinas y cuales han sido las ventas medias de sus oficinas.
El listado aparecer� ordenado por las ventas medias de las oficinas de mayor a menor.*/
SELECT * FROM empleados;
SELECT * FROM oficinas;
SELECT director, COUNT(idoficina) AS "Oficinas Dirigidas", ROUND(AVG(objetivo),2) AS "Media Objetivo", ROUND(AVG(ventas),2) AS "Media Ventas" FROM oficinas GROUP BY director ORDER BY AVG(ventas) DESC;

/* 17.- Mostrar de cada fabricante cu�l es el precio m�s caro y m�s barato de sus productos.
Mostrar el listado ordenado por fabricante.*/
SELECT * FROM pedidos;
SELECT * FROM productos;
SELECT idfabricante,MAX(punitario) AS "PRECIO MÁS CARO", MIN(punitario) AS "PRECIO MÁS BAJO" FROM productos GROUP BY idfabricante ORDER BY idfabricante;

/* 18.- Mostrar de cada ciudad cu�l es el objetivo m�nimo de sus oficinas.*/
SELECT * FROM oficinas;
SELECT ciudad,MIN(objetivo) AS "Objetivo Mínimo" FROM oficinas GROUP BY ciudad;

