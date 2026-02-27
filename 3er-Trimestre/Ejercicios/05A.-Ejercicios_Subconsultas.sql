/*EJERCICIOS SUBCONSULTAS*/

/*1.- Listar los nombres de los clientes que tienen asignada a la representante Luisa Sala Alfonte�a 
(suponiendo que no puede haber representantes con el mismo nombre).*/
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM clientes c
WHERE EXISTS(
    SELECT *
    FROM empleados e
    WHERE c.representante=e.idempleado AND LOWER(e.nombre) LIKE('%luisa sala alfonte%'));
    
SELECT c.nombre
FROM clientes c JOIN empleados e ON c.representante=e.idempleado
WHERE LOWER(e.nombre) LIKE('%luisa sala alfonte%');

/*Mostrar todos los empleados que no act�an como representantes de clientes.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM CLIENTES;

SELECT *
FROM empleados e
WHERE idempleado NOT IN(
    SELECT representante
    FROM clientes);

SELECT e.*
FROM empleados e
LEFT JOIN clientes c ON e.idempleado = c.representante
WHERE c.representante IS NULL;

/*2.- Listar los vendedores (numemp, nombre, y n� de oficina) que trabajan en oficinas "buenas" 
(las que tienen ventas superiores a su objetivo).*/
SELECT * FROM empleados;
SELECT * FROM oficinas;

SELECT idempleado, nombre, idoficina
FROM empleados
WHERE LOWER(puesto) LIKE 'comercial%' AND idoficina IN(
     SELECT idoficina
     FROM oficinas
     WHERE ventas>objetivo);
     
SELECT e.idempleado, e.nombre, e.idoficina 
FROM empleados e JOIN oficinas o ON e.idoficina = o.idoficina
WHERE LOWER(e.puesto) LIKE 'comercial%' AND o.ventas>o.objetivo;

/*3.- Listar los vendedores que no trabajan en oficinas dirigidas por el empleado Jose Miguel Estrella Lopez.*/
SELECT * FROM empleados;
SELECT * FROM oficinas;

SELECT *
FROM empleados
WHERE LOWER(puesto) LIKE ('comercial%') AND idoficina NOT IN(
    SELECT idoficina
    FROM oficinas
    WHERE director IN(
        SELECT idempleado
        FROM empleados
        WHERE LOWER(nombre) LIKE ('miguel estrella%')));
---------------------------------------------------------------------- PREGUNTAR -----------------------------------
--JOIN ¿?

/*4.- Listar los productos (idfab, idproducto y descripci�n) que aparecen en pedidos de m�s de 25000� o m�s.*/
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT p.idfabricante, p.idproducto, p.descripcion
FROM productos p
WHERE EXISTS(
    SELECT *
    FROM lineas_pedidos lp
    WHERE lp.fabricante=p.idfabricante AND lp.producto=p.idproducto AND codigo IN(
        SELECT codigo
        FROM lineas_pedidos 
        GROUP BY codigo
        HAVING SUM(punitario*cantidad) >= 25000));
     

SELECT p.idfabricante, p.idproducto, p.descripcion
FROM productos p JOIN lineas_pedidos lp ON lp.fabricante=p.idfabricante AND lp.producto=p.idproducto
GROUP BY p.idfabricante, p.idproducto, p.descripcion
HAVING SUM(lp.punitario*lp.cantidad) >= 25000;

-- 5.- Listar los clientes asignados a Maria Bego�a Se�or Se�or que han remitido un pedido superior a 3000 �. 
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT *
FROM clientes
WHERE representante IN(
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) = ('bego a se or se or')) AND idcliente IN(
        SELECT idcliente
        FROM pedidos
        WHERE codigo IN (
            SELECT codigo
            FROM lineas_pedidos
            GROUP BY codigo
            HAVING SUM(punitario*cantidad) > 3000));
---------------------------------------------------------------------- EXPLICACIÓN -----------------------------------
-- �Y los que no han remitido un pedido superior a 3000�?
SELECT *
FROM clientes
WHERE representante IN(
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE ('bego%a%se%')) AND idcliente NOT IN(
        SELECT idvendedor
        FROM pedidos
        WHERE codigo IN (
            SELECT codigo
            FROM lineas_pedidos
            GROUP BY codigo
            HAVING SUM(punitario*cantidad) > 3000));

/*6.- Listar las oficinas en donde haya un vendedor cuyas ventas representen m�s del 55% del objetivo de su oficina.*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT *
FROM oficinas o
WHERE objetivo* 0.55 < ANY (
    SELECT ventas
    FROM empleados e
    WHERE o.idoficina=e.idoficina);

---------------------------------------------------------------------- PREGUNTAR -----------------------------------
-- PORQUE NO ME DA LOS MISMOS RESULTADOS?¿   

SELECT o.*
FROM oficinas o JOIN empleados e ON o.idoficina=e.idoficina
WHERE LOWER(e.puesto) LIKE ('comercial%') AND e.ventas > (o.objetivo*0.55);

/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT *
FROM oficinas o
WHERE objetivo* 0.55 < (
    SELECT MIN(ventas)
    FROM empleados e
    WHERE o.idoficina=e.idoficina);

---------------------------------------------------------------------- PREGUNTAR -----------------------------------
--JOIN ¿?      

/*8.- Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus vendedores.*/
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT *
FROM oficinas o
WHERE EXISTS (
    SELECT *
    FROM empleados e
    WHERE o.idoficina=e.idoficina AND LOWER(e.puesto) LIKE ('comercial%')
    GROUP BY e.idoficina
    HAVING SUM(e.cuota) < o.objetivo);

---------------------------------------------------------------------- PREGUNTAR -----------------------------------
--JOIN ¿?
