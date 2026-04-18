-- 1.- Mostrar los productos que sean manteles de los fabricantes asa, bra y duni de 140x140. 
-- Mostrar fabricante, producto, descripción (la descripción se mostrará con el inicio de cada letra en mayúsculas),
-- precio y precio total (que será el precio incrementado en un 4% de IVA),   
-- Esta orden la debemos mostrar ordenada por fabricante y si tienen el mismo fabricante por precio total de mayor a menor. (1.25 puntos) 
SELECT * FROM PRODUCTOS;

SELECT 
    idfabricante,
    idproducto,
    INITCAP(descripcion),
    punitario AS "Precio",
    punitario*1.04 AS "Precio Total"
FROM 
    productos
WHERE 
    LOWER(idfabricante) IN ('asa', 'bra', 'duni')
    AND
    LOWER(descripcion) LIKE ('mantel%140x140%')
ORDER BY 
    idfabricante,
    "Precio Total" DESC;

-- 2A.- Mostrar el nombre de los clientes y nombre de los empleados que son sus representantes. En el listado deben 
-- aparecer todos los empleados, tanto los que son representantes de clientes, como los que no lo son. (1 punto) 
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT 
    c.nombre AS "Nombre Cliente",
    e.nombre AS "Nombre Representante"
FROM
    empleados e LEFT JOIN clientes c ON c.representante = e.idempleado;

-- 2B.- Y si queremos mostrar de cada empleado cuantos clientes representa. Mostraremos el nombre del empleado y 
-- un campo denominado Nº Clientes con el número de clientes que representan. (1 punto) 
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT
    e.idempleado,
    e.nombre,
    COUNT(c.idcliente) AS "Nº Clientes"
FROM 
    empleados e LEFT JOIN clientes c ON c.representante = e.idempleado
GROUP BY 
    e.idempleado,e.nombre;

-- 2C.- Solo queremos mostrar aquellos empleados que representan a más de 3 clientes. Mostraremos como 
-- en la pregunta 2B el nombre del empleado y el campo Nº Clientes. (0.5 puntos) 
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

SELECT
    e.idempleado,
    e.nombre,
    COUNT(c.idcliente) AS "Nº Clientes"
FROM 
    empleados e LEFT JOIN clientes c ON c.representante = e.idempleado
GROUP BY 
    e.idempleado,e.nombre
HAVING    
    COUNT(c.idcliente) > 3;

-- 3A.- Mostrar la descripción y el nombre del fabricante del producto más barato de toda nuestra base de datos. (1,25 puntos) 
SELECT * FROM PRODUCTOS;

SELECT
    descripcion,
    idfabricante AS "Nombre del Fabricante"
FROM 
    productos
WHERE
    punitario = (
        SELECT MIN(punitario)
        FROM productos);

-- 3B.- Por cada fabricante queremos mostrar el precio de su producto más caro, más barato y la media de precios 
-- de sus productos. Todos deben estar redondeados a 1 decimal y se mostrarán con la moneda de € por detrás los precios. 
-- Se mostrará el fabricante, el precio más barato, el precio más caro y la media de precios. Se colocarán los 
-- siguientes alias a los campos: Precio más bajo, Precio más alto y Media de Precios. (1 punto) 
SELECT * FROM PRODUCTOS;

SELECT
    idfabricante AS "Nombre del Fabricante",
    TO_CHAR(ROUND(MIN(punitario),1), '99G999D0L') AS "Precio Más Bajo",
    TO_CHAR(ROUND(MAX(punitario),1), '99G999D0L') AS "Precio Más Alto",
    TO_CHAR(ROUND(AVG(punitario),1), '99G999D0L') AS "Media de Precios"
FROM 
    productos
GROUP BY
    idfabricante;

-- 4.- Mostrar cuantos empleados trabajan bajo las órdenes de Luis Amezti 
-- (es decir, Luis Amezti es su jefe). (1,25 puntos) 
SELECT * FROM EMPLEADOS;

SELECT
    COUNT(idempleado) AS "Empleados bajo las órdenes de Luis Amezti"
FROM 
    empleados
WHERE
    jefe = (
        SELECT 
            idempleado
        FROM 
            empleados
        WHERE LOWER(nombre) LIKE 'luis amezti%');
        
-- 5.- Mostrar cuantas oficinas no tienen director. (1 punto) 
SELECT * FROM OFICINAS;

SELECT
    COUNT(*) AS "Oficinas sin Director"
FROM 
    oficinas
WHERE 
    director IS NULL;

-- 6.- Mostrar en un campo el Nombre del cliente y en otro los apellidos de 
-- los clientes en formato “Apellido2, Apellido1” que han realizado pedidos. (1,5 puntos) 
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;

SELECT
    SUBSTR(nombre,1,INSTR(nombre, ' ',1,1)-1) AS "Nombre",
    SUBSTR(nombre,INSTR(nombre, ' ',1,2)+1) 
    || ', ' || 
    SUBSTR(nombre,INSTR(nombre, ' ',1,1)+1,INSTR(nombre, ' ',1,2)-INSTR(nombre, ' ',1,1)-1)
    AS "Apellidos"
FROM 
    clientes
WHERE
    idcliente IN (
        SELECT DISTINCT idcliente
        FROM pedidos);
        
-- 7.-Queremos obtener un listado de las descripciones de los productos
-- que no hayan sido vendidos. (1,5 puntos) 
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT 
    descripcion
FROM
    productos pr
WHERE NOT EXISTS (
    SELECT
        *
    FROM 
        lineas_pedidos lp
    WHERE lp.fabricante = pr.idfabricante AND lp.producto = pr.idproducto);
    
-- 8.- Mostrar todos los pedidos realizados en abril y mayo de 2001 con un importe superior a 15.000€. 
-- Mostrar el número de pedido, número del empleado que lo ha realizado, número del cliente que lo ha pedido,
-- fecha del pedido (formato fecha: 12 de enero de 2021) e importe del pedido (el importe vendrá con 
-- puntos de miles, dos decimales y con la moneda tras la cantidad). (1,25 puntos) 
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT
    p.numpedido,
    p.idvendedor,
    p.idcliente,
    TO_CHAR(p.fpedido,'dd "de" fmmonth "de" YYYY') AS "Fecha Pedido",
    TO_CHAR(SUM(lp.punitario*lp.cantidad),'99G999D99L') AS "Importe Pedido"
FROM
    pedidos p JOIN lineas_pedidos lp ON p.codigo = lp.codigo
WHERE 
      EXTRACT(YEAR FROM p.fpedido) = 2001
      AND
      (EXTRACT(MONTH FROM p.fpedido) = 4 OR EXTRACT(MONTH FROM p.fpedido) = 5)
GROUP BY
    p.numpedido,
    p.idvendedor,
    p.idcliente,
    p.fpedido
HAVING 
    SUM(lp.punitario*lp.cantidad) > 15000;

-- 9A.- Por cada año queremos mostrar cuantos clientes nos han hecho pedidos. (1,25 puntos) 
SELECT * FROM PEDIDOS;

SELECT
    EXTRACT(YEAR FROM fpedido) AS "Año",
    COUNT(DISTINCT idcliente)
FROM
    pedidos
GROUP BY 
    EXTRACT(YEAR FROM fpedido);

-- 9B.- Por cada año y cliente queremos mostrar cuantos pedidos ha hecho y cual el importe total de los pedidos. (1,5 puntos) 
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT
    p.idcliente,
    EXTRACT(YEAR FROM p.fpedido) AS "Año",
    COUNT(DISTINCT p.codigo) AS "Número Pedidos",
    TO_CHAR(SUM(lp.punitario*lp.cantidad), '99G999G999D99L') AS "Total Pedidos"
FROM
    pedidos p JOIN lineas_pedidos lp ON p.codigo = lp.codigo
GROUP BY 
    p.idcliente,
    EXTRACT(YEAR FROM p.fpedido);

-- 10.- Queremos premiar a los empleados mayores de 60 años. Si son comerciales incrementaremos su cuota en un 6%, 
-- si son directores/as comerciales incrementaremos su cuota en un 5%, si son directores/as de ventas incrementaremos
-- su cuota en un 4% y si tienen otro puesto se incrementará su cuota en un 2%. Mostraremos el nombre del empleado, su edad, su puesto,
-- la cuota actual y la cuota incrementada. (1,5 puntos) 
SELECT * FROM EMPLEADOS;

SELECT
    nombre,
    TRUNC(MONTHS_BETWEEN(SYSDATE,fnacimiento)/12) AS "Edad",
    puesto,
    NVL2(cuota,cuota,0) AS "Cuota Actual",
    CASE
        WHEN LOWER(puesto) = 'comercial' THEN NVL2(cuota,cuota*1.06,0)
        WHEN LOWER(puesto) LIKE 'director%comercial' THEN NVL2(cuota,cuota*1.05,0)
        WHEN LOWER(puesto) LIKE 'director%ventas' THEN NVL2(cuota,cuota*1.04,0)
        ELSE NVL2(cuota,cuota*1.02,0)
    END AS "Nueva Cuota"
FROM 
    empleados
WHERE
    TRUNC(MONTHS_BETWEEN(SYSDATE,fnacimiento)/12) > 60;
   
 