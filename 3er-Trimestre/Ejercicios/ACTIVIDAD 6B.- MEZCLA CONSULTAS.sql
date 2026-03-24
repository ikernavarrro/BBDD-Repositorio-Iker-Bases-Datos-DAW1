/*1A.-  Mostrar todos los pedidos realizados en FEBRERO de 2007 
con un precio superior a 25000�. Mostrar el n�mero de pedido y 
n�mero del empleado que lo ha realizado, 
n�mero del cliente que lo ha pedido ,
fecha del pedido  e importe (correctamente formateado). (1 punto)*/
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT 
    p.numpedido,
    p.idvendedor,
    p.idcliente,
    p.fpedido,
    TO_CHAR(SUM(lp.punitario * lp.cantidad),'99G999D99') || '€' AS "IMPORTE"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo
WHERE EXTRACT(YEAR FROM p.fpedido) = 2007 AND EXTRACT(MONTH FROM p.fpedido) = 2
GROUP BY p.numpedido, p.idvendedor, p.idcliente, p.fpedido
HAVING SUM(lp.punitario*lp.cantidad)>25000;
// FORMATO DE IMPORTE¿?

/*1B.- Mostrar todos los pedidos realizados en FEBRERO de 2007 con un precio superior a 25000�.
Mostrar el n�mero de pedido y nombre del empleado que lo ha realizado,
nombre del cliente que lo ha pedido, fecha del pedido 
(formato largo ejemplo: lunes, 10 de junio de 2007) 
e importe (correctamente formateado). */
SELECT 
    p.numpedido,
    e.nombre AS "Nombre Empleado",
    c.nombre AS "Nombre Cliente",
    TO_CHAR(p.fpedido, 'FMDAY, DD "de" MONTH "de" YYYY') AS "Fecha Pedido",
    TO_CHAR(SUM(lp.punitario * lp.cantidad), '99G999D99') || '€' AS "IMPORTE"
FROM pedidos p JOIN lineas_pedidos lp ON p.codigo=lp.codigo JOIN empleados e ON p.idvendedor= e.idempleado JOIN clientes c ON p.idcliente=c.idcliente
WHERE EXTRACT(YEAR FROM p.fpedido) = 2007 AND EXTRACT(MONTH FROM p.fpedido) = 2
GROUP BY p.numpedido, e.nombre, c.nombre, p.fpedido
HAVING SUM(lp.punitario*lp.cantidad)>25000;
//FORMATO FECHA¿?


/*2.- Mostrar el n�mero de oficina, ciudad y director de aquellas oficinas que
no tienen empleados asignados. */
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

SELECT 
    o.idoficina,
    o.ciudad,
    o.director
FROM oficinas o
WHERE NOT EXISTS (
    SELECT *
    FROM empleados e
    WHERE e.idoficina=o.idoficina);

/*3.- Quiero mostrar cuantos productos se han pedido del fabricante asa y del fabricante bra.
Mostrar fabricante y n�mero de productos pedidos. */
SELECT * FROM LINEAS_PEDIDOS;

// EN CUANTOS PEDIDOS SALEN ESOS PRODUCTOS DE asa O bra
SELECT 
    fabricante,
    COUNT(*) AS "Productos en Pedidos"
FROM lineas_pedidos
WHERE LOWER(fabricante)='asa' OR LOWER(fabricante)='bra'
GROUP BY fabricante;  

// CUANTOS PRODUCTOS PEDIDOS SALEN DE asa O bra
SELECT 
    fabricante,
    SUM(cantidad) AS "Productos Pedidos"
FROM lineas_pedidos
WHERE LOWER(fabricante) IN ('asa','bra')
GROUP BY fabricante;  

/*4.- Mostrar cuantos productos se han pedido de cada fabricante.
Mostrar fabricante y cantidad de productos. */
// EN CUANTOS PEDIDOS SALEN ESOS PRODUCTOS
SELECT 
    fabricante,
    COUNT(*) AS "Productos en Pedidos"
FROM lineas_pedidos
GROUP BY fabricante;  

// CUANTOS PRODUCTOS PEDIDOS SALEN EN LOS PEDIDOS
SELECT 
    fabricante,
    SUM(cantidad) AS "Productos Pedidos"
FROM lineas_pedidos
GROUP BY fabricante;  

/*5.- Mostrar el nombre de los empleados, nombre de sus jefes, sus ventas y cuotas y las de sus jefes.
En el listado deben aparecer todos los empleados, tanto si tienen, jefe, como si no. */
SELECT * FROM EMPLEADOS;

SELECT 
    e.nombre AS "Nombre Empleado",
    j.nombre AS "Nombre Jefe",
    e.ventas AS "Ventas Empleado",
    j.ventas AS "Ventas Jefe",
    e.cuota AS "Cuota Empleado",
    j.cuota AS "Cuota Jefe" 
FROM empleados e LEFT JOIN empleados j ON e.jefe = j.idempleado;

/*6.- Listar la oficina que tenga un objetivo mayor de las que tienen director. 
Se deben mostrar los campos de n�mero de oficina, nombre del director, 
objetivo y un objetivo para el a�o que viene que ser� el objetivo incrementado en un 5%.
A este nuevo campo lo vamos a denominar Objetivo 2027. */
SELECT * FROM OFICINAS;

SELECT
    o.idoficina,
    e.nombre AS "Nombre Director",
    o.objetivo AS "Objetivo Actual",
    o.objetivo*1.05 AS "Objetivo 2027"
FROM oficinas o JOIN empleados e ON o.director = e.idempleado
WHERE o.objetivo = (
        SELECT MAX(objetivo)
        FROM oficinas
        WHERE director IS NOT NULL);
        
/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% 
del objetivo de su oficina. Mostrar de cada oficina el n�mero, regi�n y objetivo. */
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS ORDER BY idoficina;

SELECT *
FROM oficinas o
WHERE EXISTS (
    SELECT *
    FROM empleados e
    WHERE e.idoficina IS NOT NULL AND o.idoficina=e.idoficina
    GROUP BY e.idoficina
    HAVING MIN(e.ventas) > o.objetivo/2);
    // De las oficinas cogemos solo (WHERE EXISTS) aquellas que donde el empleado de esa oficina (o.idoficina=e.idoficina)
    // que menos ventas ha hecho (MIN(e.ventas)) supere en un 50% al objetivo de su oficina (MIN(e.ventas) > o.objetivo/2))
    // Si cogemos el empleado que menos ventas ha hecho y sabemos que supera, los demás también lo superarán.


/*8.- Estamos haciendo un control de existencias y debemos mostrar
por cada uno de nuestros productos si los pedidos son urgentes, 
para dentro de una semana, para dentro de un mes.
Si el campo existencias es menor de 50 unidades el pedido ser� urgente (URGENTE).
Si est� entre 51 y 150 ser� para dentro de una semana (SEMANA) 
y si es superior a 150 ser� para dentro de un mes (MES). 
Esta consulta debe mostrar el fabricante, descripci�n, 
existencias y la petici�n del pedido mostrando URGENTE, SEMANA o MES. */
SELECT * FROM PRODUCTOS;

SELECT
    idfabricante,
    descripcion,
    stock,
    CASE
        WHEN stock <= 50 THEN 'URGENTE'
        WHEN stock BETWEEN 51 AND 150 THEN 'SEMANA'
        WHEN stock > 150 THEN 'MES'
    END AS "Próximo Pedido"    
FROM productos;    


/*9.- Mostrar el precio medio de los productos de cada fabricante que superen los 20 �.
El precio debe aparecer con dos decimales y el s�mbolo del euro por detr�s.
Mostrar Fabricante y un campo denominado Precio Medio Productos. */
SELECT * FROM PRODUCTOS;

SELECT 
    idfabricante AS "Fabricante", 
    TO_CHAR(AVG(punitario), 'FM99G999D00') || '€' AS "Precio Medio Productos"
FROM productos
GROUP BY idfabricante
HAVING AVG(punitario) > 20;

/*10.- Mostrar para cada empleado su nombre, su campo ventas, y 
calcular el premio que van a conseguir seg�n las ventas conseguidas,

Si las ventas son inferiores a 100000 no se dar� premio.
Si las ventas son inferiores a 200000 el premio ser� de 100�.
Si las ventas son inferiores a 300000 el premio ser� de 200�.
Si las ventas son inferiores a 400000 el premio ser� de 300�.
Si las ventas son superiores a 400000 el premio ser� de 500�.
*/
SELECT * FROM EMPLEADOS;

SELECT
    nombre,
    ventas,
    CASE
        WHEN ventas < 100000 THEN 'Sin Bonificación'
        WHEN ventas < 200000 THEN '100€ de Bonificación'
        WHEN ventas < 300000 THEN '200€ de Bonificación'
        WHEN ventas < 400000 THEN '300€ de Bonificación'
        WHEN ventas >= 400000 THEN '500€ de Bonificación'
        ELSE 'Sin Bonificación'
    END AS "Bonificación"
FROM empleados;    

/*11.- Mostrar de cada empleado su nombre, el nombre de su jefe solo de aquellos empleados
que su jefe haya sido contratado posteriormente a ellos. 
Aparecer�n en el listado tambi�n aquellos empleados que no tienen jefe. */  
SELECT * FROM EMPLEADOS;

SELECT
    e.nombre AS "Nombre Empleado",
    j.nombre AS "Nombre Jefe",
    e.fcontrato AS "Fecha Contrato Empleado",
    j.fcontrato AS "Fecha Contrato Jefe"
FROM empleados e LEFT JOIN empleados j ON e.jefe = j.idempleado
WHERE j.fcontrato > e.fcontrato OR e.jefe IS NULL;
// IMPORTANCIA AL WHERE! Si no añadieramos la condición OR con e.jefe IS NULL, no aparecerían los que tienen
// jefe null aunque hicieramos un LEFT JOIN, ya que al comparar j.fcontrato > e.fcontrato si en la parte de jefe es NULL 
// lo daría como falso y lo eliminaría
    

/*12.- Mostrar por cada empleado el importe m�nimo que ha realizado en un pedido
y el importe m�ximo en el a�o 2007. Mostrar nombre del empleado, importe m�nimo e importe m�ximo. */
SELECT * FROM EMPLEADOS;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT 
    e.nombre AS "Nombre Empleado",
    MIN(lp.punitario*lp.cantidad) AS "Importe Mínimo",
    MAX(lp.punitario*lp.cantidad) AS "Importe Máximo"
FROM empleados e JOIN pedidos p ON e.idempleado=p.idvendedor JOIN lineas_pedidos lp ON p.codigo = lp.codigo
WHERE EXTRACT(YEAR FROM p.fpedido) = 2007
GROUP BY e.nombre;

SELECT MIN(punitario*cantidad)
FROM lineas_pedidos
GROUP BY codigo;

SELECT MAX(punitario*cantidad)
FROM lineas_pedidos
GROUP BY codigo;

/*13.- Mostrar los pedidos que ha realizado Estaban Garnier en Mayo del 97.
Mostrar el n�mero de pedido, fecha del pedido en formato largo 
(p ej: mi�rcoles, 3 de mayo de 2012), y el importe.
El importe debe aparecer con dos decimales y el s�mbolo del � detr�s. */
SELECT * FROM PEDIDOS;
SELECT * FROM EMPLEADOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT
    p.numpedido,
    TO_CHAR(p.fpedido, 'FMDAY, DD "de" MONTH "de" YYYY') AS "Fecha Pedido",
    TO_CHAR(SUM(lp.punitario*lp.cantidad), '99G999D00') || '€' AS "Importe Pedido"
FROM empleados e JOIN pedidos p ON e.idempleado=p.idvendedor JOIN lineas_pedidos lp ON p.codigo=lp.codigo
WHERE LOWER(e.nombre) LIKE '%esteban garnier%' AND EXTRACT(YEAR FROM p.fpedido)=1997 AND EXTRACT(MONTH FROM p.fpedido)=5 
GROUP BY p.numpedido, p.fpedido;     


/*14.- Se quiere incrementar el objetivo de las oficinas por regiones,
a aquellas del norte se les incrementar� su objetivo en un 5%,
a las del este en un 3% a las del oeste en un 2% y al resto en un 7%.
Mostrar en el listado el n�mero de oficina, regi�n, porcentaje a incrementar,
el objetivo actual y el objetivo actualizado con el incremento. */
SELECT * FROM OFICINAS;

SELECT 
    idoficina,
    region,
    CASE LOWER(region)
        WHEN 'norte' THEN '5%'
        WHEN 'este' THEN '3%'
        WHEN 'oeste' THEN '2%'
        ELSE '7%'
    END AS "Porcentaje de Incremento",
    objetivo AS "Objetivo Actual",
    CASE LOWER(region)
        WHEN 'norte' THEN objetivo*1.05
        WHEN 'este' THEN objetivo*1.03
        WHEN 'oeste' THEN objetivo*1.02
        ELSE objetivo*1.07
    END AS "Objetivo Incrementado"
FROM oficinas;
