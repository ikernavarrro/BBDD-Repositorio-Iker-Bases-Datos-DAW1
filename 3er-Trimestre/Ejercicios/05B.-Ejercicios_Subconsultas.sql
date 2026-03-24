/*EJERCICIOS SUCONSULTAS II */
/*Los ejercicios se pueden resolver de varias maneras, intenta resolverlos utilizando subconsultas ya que de eso trata el tema.*/

/*1.- Mostrar el nombre de los empleados cuyo jefe sea Luis Amezti.*/
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM empleados
WHERE jefe = (
    SELECT idempleado    
    FROM empleados
    WHERE LOWER(nombre) = 'luis amezti ruiz');

/*2.- Mostrar el nombre del jefe del empleado apellidado Marquez. (Andres Diaz Zabalburu)*/
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM empleados
WHERE idempleado IN (
    SELECT jefe
    FROM empleados
    WHERE LOWER(nombre) LIKE '%marquez%');

/*3.- Mostrar los datos de las oficinas que dirige Jose Miguel Estrella que no est�n en Valencia y que hayan hecho m�s de 500000� de ventas. (Oficina n� 7)*/
 SELECT * FROM OFICINAS;
 SELECT * FROM EMPLEADOS;
 
 SELECT *
 FROM oficinas
 WHERE director IN (
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) = 'miguel estrella lopez') AND ciudad NOT IN (
        SELECT ciudad
        FROM oficinas
        WHERE LOWER(ciudad) = 'valencia') AND ventas IN (
            SELECT ventas
            FROM oficinas
            WHERE ventas > 500000);

/*4.- Mostrar el nombre de los empleados que en el a�o 2012 hayan hecho un total de m�s de 10000� en pedidos a sus clientes. (M� Bego�a Se�or Se�or)*/
SELECT * FROM EMPLEADOS;
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT nombre
FROM empleados
WHERE idempleado IN(
    SELECT idvendedor
    FROM pedidos
    WHERE EXTRACT(YEAR FROM fpedido) = 2012 AND codigo IN (
        SELECT codigo
        FROM lineas_pedidos
        GROUP BY codigo
        HAVING SUM(punitario*cantidad) > 10000));

/*5.- Mostrar todos los datos de las oficinas del este y que su objetivo sea menor que las ventas de todos sus empleados.*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT *
FROM oficinas o
WHERE LOWER(region) = 'este' AND objetivo < (
    SELECT SUM(ventas)
    FROM empleados e
    WHERE o.idoficina = e.idoficina);

/*6.- Mostrar los nombres de los clientes que en el a�o 2007 han comprado alg�n mantel de cualquier fabricante.*/
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT nombre
FROM clientes c
WHERE idcliente IN (
    SELECT idcliente
    FROM pedidos p
    WHERE EXTRACT(YEAR FROM fpedido) = 2007 AND codigo IN(
        SELECT codigo 
        FROM lineas_pedidos lp
        WHERE EXISTS(
            SELECT *    
            FROM productos pro
            WHERE lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto AND LOWER(descripcion) LIKE ('%mantel%'))));
            
SELECT nombre
FROM clientes c
WHERE idcliente IN (
    SELECT DISTINCT p.idcliente
    FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo JOIN productos pro ON lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto
    WHERE EXTRACT(YEAR FROM p.fpedido) = 2007 AND LOWER(pro.descripcion) LIKE ('%mantel%'));      
    
/*7.- Mostrar los nombres de los clientes (sin valores repetidos) que en el a�o 2007 han comprado un mantel del fabricante bra.*/
SELECT * FROM CLIENTES;
SELECT * FROM PRODUCTOS;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT DISTINCT nombre
FROM clientes
WHERE idcliente IN(
    SELECT idcliente
    FROM pedidos p
    WHERE EXTRACT(YEAR FROM fpedido) = 2007 AND codigo IN(
        SELECT codigo
        FROM lineas_pedidos lp
        WHERE EXISTS(
            SELECT *
            FROM productos pro
            WHERE lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto AND LOWER(descripcion) LIKE '%mantel%' AND LOWER(idfabricante) = 'bra')));
            
SELECT DISTINCT nombre
FROM clientes
WHERE idcliente IN (
    SELECT p.idcliente
    FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo JOIN productos pro ON lp.fabricante=pro.idfabricante AND lp.producto=pro.idproducto
    WHERE EXTRACT(YEAR FROM p.fpedido) = 2007 AND LOWER(pro.descripcion) LIKE '%mantel%' AND LOWER(pro.idfabricante) = 'bra');            

/*8.- Mostrar el nombre de los empleados que fueron contratados antes de la fecha en que se realiz� el primer pedido.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;

SELECT nombre
FROM empleados
WHERE fcontrato < (
    SELECT MIN(fpedido)
    FROM pedidos);

/*9.- Mostrar los nombres de los jefes que tengan m�s de 4 empleados a su cargo.*/
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM empleados
WHERE idempleado IN ( 
    SELECT jefe
    FROM empleados
    WHERE jefe IS NOT NULL
    GROUP BY jefe
    HAVING COUNT(*) > 4);

/*10.-Mostrar los nombres de los jefes cuyas ventas sean menores que las de todos sus empleados.*/
SELECT * FROM EMPLEADOS;
    
SELECT nombre
FROM empleados
WHERE idempleado IN (
    SELECT e.jefe
    FROM empleados e JOIN empleados j ON e.jefe = j.idempleado
    GROUP BY e.jefe
    HAVING MIN(e.ventas) > MAX(j.ventas));  
    
SELECT nombre
FROM empleados
WHERE idempleado IN (
    SELECT e.jefe
    FROM empleados e JOIN empleados j ON e.jefe = j.idempleado
    GROUP BY e.jefe
    HAVING SUM(e.ventas) > MAX(j.ventas));    

