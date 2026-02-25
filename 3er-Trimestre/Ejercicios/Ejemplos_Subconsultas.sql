SELECT * FROM PRODUCTOS;
SELECT * FROM CLIENTES;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM PEDIDOS;
SELECT * FROM EMPLEADOS;

SELECT nombre 
FROM empleados
WHERE idempleado IN (
    SELECT idvendedor
    FROM pedidos
    WHERE idcliente IN (
        SELECT idcliente
        FROM clientes
        WHERE LOWER(nombre) LIKE ('estefania garcia anton')));
        
SELECT * FROM LINEAS_PEDIDOS;        
SELECT * FROM PEDIDOS;

// 1. Mostrar los fabricanes y productos que hayan vendido sus productos entre 1997,1999
SELECT DISTINCT fabricante, producto
FROM lineas_pedidos
WHERE codigo IN (
    SELECT codigo
    FROM pedidos
    WHERE EXTRACT(YEAR FROM fpedido) BETWEEN 1997 AND 1999);

//2. Mostrar nombre y edad de los empleados que han realizado pedidos en 1997
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;

SELECT nombre, TRUNC(MONTHS_BETWEEN(sysdate,fnacimiento)/12) AS "EDAD" 
FROM empleados
WHERE idempleado IN (
    SELECT idvendedor 
    FROM pedidos
    WHERE EXTRACT(YEAR FROM fpedido) = 1997);
    
// 3. Mostrar nombre de los clientes que su representante es Raul Aldamiz
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM clientes
WHERE representante IN 
    (SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE ('%raul aldamiz%'));
    

SELECT nombre
FROM clientes
WHERE idCliente IN (
    SELECT idcliente
    FROM pedidos
    WHERE idvendedor IN (
        SELECT idempleado
        FROM empleados
        WHERE LOWER(nombre) LIKE ('%raul aldamiz%')));
        

// 4. Mostrar el nombre de los empleados que estan bajo las ordenes de Luis Amezti
SELECT * FROM EMPLEADOS;

SELECT nombre
FROM empleados
WHERE jefe = (
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE ('luis amezti %'));

// 5. Mostrar la ciudad, region y ventas de las oficinas que dirige Miguel Estrella
SELECT * FROM OFICINAS;

SELECT ciudad, region, ventas
FROM oficinas
WHERE director IN (
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE ('miguel estrella %'));

// 6 Mostrar la descripcion del producto más barato de toda la tienda
SELECT * FROM PRODUCTOS;
SELECT descripcion
FROM productos
WHERE punitario IN (
    SELECT MIN(punitario)
    FROM productos);

// 7 Mostrar la descripcion del producto más barato del fabricante asa
SELECT * FROM PRODUCTOS;

SELECT descripcion
FROM productos
WHERE LOWER(idfabricante) LIKE ('asa') AND punitario IN (
    SELECT MAX(punitario)
    FROM productos
    WHERE LOWER(idfabricante) LIKE ('asa'));

-- 8 Mostrar la ciudad y el director de la oficina con más ventas.
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;
SELECT ciudad,director
FROM oficinas
WHERE ventas IN (
    SELECT MAX(ventas)
    FROM oficinas);

-- 9 Mostrar el código y la feha de envío del pedido más reciente.
SELECT * FROM pedidos;
SELECT codigo, fenvio
FROM pedidos
WHERE fpedido IN (
    SELECT MAX(fpedido)
    FROM pedidos);

-- 10 Quiero el nombre del cliente que se ha gastado más en pedidos;
SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM lineas_pedidos;

SELECT nombre
FROM clientes
WHERE idcliente IN (
    SELECT idcliente
    FROM pedidos
    WHERE codigo IN (
        SELECT codigo
        FROM lineas_pedidos));

SELECT nombre
FROM clientes
WHERE idcliente IN (
    SELECT p.idcliente
    FROM lineas_pedidos lp, pedidos p
    WHERE lp.codigo = p.codigo
    GROUP BY p.idcliente
    HAVING SUM(lp.punitario*lp.cantidad) IN(
        SELECT MAX(SUM(lp.punitario*lp.cantidad))
        FROM lineas_pedidos lp, pedidos p
        WHERE lp.codigo = p.codigo
        GROUP BY p.idcliente));

-- EXISTS(OBLIGATORIO SOLAMENTE cuando la clave extranjera y la principal sobre la que se unen las tablas es de más de 1 campo) --

-- Mostrar los nombres de los empleados de oficinas de madrid y valencia

-- SIN EXISTS
SELECT nombre
FROM empleados
WHERE idoficina IN (
    SELECT idoficina
    FROM oficinas
    WHERE LOWER(ciudad) IN ('madrid','valencia'));

-- CON EXISTS
SELECT nombre
FROM empleados e
WHERE EXISTS (
    SELECT *
    FROM oficinas o
    WHERE e.idoficina=o.idoficina AND LOWER(ciudad) IN ('madrid','valencia'));
    
-- La descripción de los productos que haya comprado el cliente 9101.
--Con exists
SELECT DISTINCT descripcion
FROM productos pro
WHERE EXISTS(
    SELECT *
    FROM lineas_pedidos lp
    WHERE pro.idfabricante=lp.fabricante AND pro.idProducto=lp.producto AND EXISTS(
        SELECT *
        FROM pedidos p
        WHERE p.codigo=lp.codigo AND p.idcliente=9101));
        
--Solo Con EXISTS OBLIGATORIO    
SELECT DISTINCT descripcion
FROM productos pro
WHERE EXISTS(
    SELECT *
    FROM lineas_pedidos lp
    WHERE pro.idfabricante=lp.fabricante AND pro.idProducto=lp.producto AND lp.codigo IN (
        SELECT p.codigo
        FROM pedidos p
        WHERE p.idcliente=9101));
        
-- 11 Mostrar los nombres de los clientes que tiene como representante a Pedro Vazquez
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT c.nombre 
FROM clientes c
WHERE EXISTS(
    SELECT *
    FROM empleados e
    WHERE c.representante=e.idempleado AND LOWER(e.nombre) LIKE ('%pedro vazquez%'));

-- 12 Mostrar la oficina, ciudad y director de Andres Diaz.
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

SELECT o.idoficina, o.ciudad, o.director
FROM oficinas o
WHERE EXISTS(
    SELECT *
    FROM empleados e
    WHERE e.idoficina=o.idoficina AND LOWER(e.nombre) LIKE ('%andres diaz%'));









