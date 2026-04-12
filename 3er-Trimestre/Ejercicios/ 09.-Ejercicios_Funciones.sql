-- EJERCICIOS DE FUNCIONES EN ORACLE
SELECT ABS(146) FROM DUAL; -- 146
SELECT CEIL(2) FROM DUAL; -- 2
SELECT CEIL(-2.3) FROM DUAL; -- -2
SELECT FLOOR(-2.3) FROM DUAL; -- -3
SELECT FLOOR(2) FROM DUAL; -- 2
SELECT MOD(22,23) FROM DUAL; -- 22
SELECT POWER(10,0) FROM DUAL; -- 1
SELECT ABS(-30) FROM DUAL; -- 30
SELECT CEIL(1.3) FROM DUAL; -- 2
SELECT CEIL(-2) FROM DUAL; -- -2
SELECT FLOOR(-2.3) FROM DUAL; -- -3
SELECT FLOOR(1.3) FROM DUAL; -- 1
SELECT MOD(10,3) FROM DUAL; -- 1
SELECT POWER(3,2) FROM DUAL; -- 9
SELECT POWER(3,-1) FROM DUAL; -- 0.33 
SELECT ROUND(-33.67,2) FROM DUAL; -- -33.67
SELECT ROUND(-33.27,1) FROM DUAL; -- -33.3
SELECT TRUNC(67.232) FROM DUAL; -- 67
SELECT TRUNC(67.232,2) FROM DUAL; -- 67.23
SELECT TRUNC(67.58,1) FROM DUAL; -- 67.5
SELECT ROUND(33.67) FROM DUAL; -- 34 
SELECT ROUND(-33.67,-2) FROM DUAL; -- 0
SELECT ROUND(67.232,-2) FROM DUAL; -- 100
SELECT TRUNC(67.232,-2) FROM DUAL; -- 0
SELECT TRUNC(67.58,-1) FROM DUAL; -- 60

--2.- Dada la tabla EMPLEADOS muestra el número medio de ventas,
--el máximo número de ventas y el mínimo número de ventas de los
--empleados de la oficina 12.  Los números deben aparecer redondeados a dos decimales.
SELECT * FROM EMPLEADOS;
SELECT
    ROUND(AVG(ventas),2) AS "Media Ventas",
    ROUND(MAX(ventas),2) AS "Máximo Ventas",
    ROUND(MIN(ventas),2) AS "Mínimo Ventas"
FROM empleados;    

--3.- Dada la tabla CLIENTES se debe mostrar en una columna los 
--apellidos una coma y el nombre del empleado en ese orden y en otra columna las iniciales.
SELECT * FROM CLIENTES;
SELECT
    nombre,
    SUBSTR(nombre,INSTR(nombre,' ',1)+1) || ', ' || SUBSTR(nombre,0, INSTR(nombre,' ',1)) AS "Apellidos y Nombre",
    SUBSTR(nombre,1,1) || SUBSTR(nombre,INSTR(nombre,' ',1,1)+1,1) || SUBSTR(nombre,INSTR(nombre,' ',1,2)+1,1) AS "Iniciales"
FROM clientes;

--4.- Dada la tabla EMPLEADOS se debe mostrar el nombre del empleado y en otra columna , la fecha de contrato, fecha de contrato formateada. 
-- Esta fecha seguirá el siguiente formato:
--“Comenzó el 10 de octubre de 1980”
SELECT * FROM EMPLEADOS;

SELECT
    nombre,
    fcontrato,
    TO_CHAR(fcontrato,'"Comenzó el" dd "de" month "de" YYYY')
FROM 
    EMPLEADOS;    

--5.- Dada la tabla de empleados mostrar el nombre del empleado y el número de caracteres que tiene 
--su nombre completo, su nombre, el número de caracteres que ocupa el nombre y sus apellidos y el número de caracteres que ocupan sus apellidos.
SELECT * FROM EMPLEADOS;

SELECT
    nombre AS "Nombre Completo",
    LENGTH(nombre) AS "Carácteres Nombre Completo",
    SUBSTR(nombre,1,INSTR(nombre,' ',1)-1) AS "Nombre",
    LENGTH(SUBSTR(nombre,1,INSTR(nombre,' ',1)-1)) AS "Carácteres Nombre",
    SUBSTR(nombre,INSTR(nombre,' ',1)+1) AS "Apellidos",
    LENGTH(SUBSTR(nombre,INSTR(nombre,' ',1)+1)) AS "Carácteres Apellidos"
FROM 
    empleados;    

--6.- Convierte la cadena ‘010726’ a fecha y muestra el nombre del mes en letras mayúsculas. (Lanzar la orden contra DUAL)
SELECT * FROM DUAL;

SELECT 
    TO_CHAR(TO_DATE('010726', 'ddmmyy'), 'MONTH')
FROM 
    dual;

--7.- A partir de la tabla EMPLEADOS mostrar aquellos que llevan más de 25 años trabajando.
SELECT * FROM EMPLEADOS;

SELECT 
    *
FROM 
    empleados
WHERE 
    TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12) > 25;

--8.- Mostrar el apellido de aquellos empleados que llevan trabajando más de 25 años en las oficinas de Valencia.
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

SELECT 
    SUBSTR(nombre,INSTR(nombre,' ')+1)
FROM 
    empleados
WHERE 
    TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12) > 25
    AND
    idoficina IN(
        SELECT
            idoficina
        FROM 
            oficinas
        WHERE 
            LOWER(ciudad) = 'valencia');

--9.- Dadas las oficinas mostrar si su objetivo es menor de 300.000 “BAJO”, si está entre 300.000 y 500.000 “MEDIO” 
--y superior a 500.000 “ALTO” y mostrar sus ventas y si han sido BAJAS, MEDIAS o ALTAS (mismos valores que para el objetivo).
SELECT * FROM OFICINAS;

SELECT
    o.*,
    CASE
        WHEN objetivo < 300000 THEN 'BAJO'
        WHEN objetivo BETWEEN 300000 AND 500000 THEN 'MEDIO'
        WHEN objetivo > 500000 THEN 'ALTO'
    END AS "Objetivo Proyectado",
    CASE
        WHEN ventas < 300000 THEN 'BAJAS'
        WHEN ventas BETWEEN 300000 AND 500000 THEN 'MEDIAS'
        WHEN ventas > 500000 THEN 'ALTAS'
    END AS "Ventas Proyectadas"
FROM 
    oficinas o;

--10.- Mostrar por cada cliente que ha hecho pedidos si es buen cliente, cliente básico si el valor total de los 
--importes de sus pedidos es superior a 20.000 € (buen cliente), menor que 5000 (cliente básico), o entre estas dos cifras (Cliente potencial).
SELECT * FROM CLIENTES;
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

SELECT 
    c.idcliente,
    c.nombre,
    SUM(lp.punitario * lp.cantidad) || ' €' AS "Total Gastado",
    CASE
        WHEN SUM(lp.punitario*lp.cantidad) < 5000 THEN 'Cliente Básico'
        WHEN SUM(lp.punitario*lp.cantidad) BETWEEN 5000 AND 20000 THEN 'Cliente Potencial'
        WHEN SUM(lp.punitario*lp.cantidad) > 20000 THEN 'Buen Cliente'
    END AS "Valoración Clientes"
FROM 
    clientes c 
    JOIN pedidos p ON c.idcliente = p.idcliente
    JOIN lineas_pedidos lp ON p.codigo = lp.codigo
GROUP BY 
    c.idcliente,
    c.nombre
ORDER BY
    SUM(lp.punitario * lp.cantidad) DESC;

--11.- Mostrar la consulta anterior pero mostrando el nombre de cliente y si es buen cliente básico o potencial.
SELECT 
    c.nombre,
    CASE
        WHEN SUM(lp.punitario*lp.cantidad) < 5000 THEN 'Cliente Básico'
        WHEN SUM(lp.punitario*lp.cantidad) BETWEEN 5000 AND 20000 THEN 'Cliente Potencial'
        WHEN SUM(lp.punitario*lp.cantidad) > 20000 THEN 'Buen Cliente'
    END AS "Valoración Clientes"
FROM 
    clientes c 
    JOIN pedidos p ON c.idcliente = p.idcliente
    JOIN lineas_pedidos lp ON p.codigo = lp.codigo
GROUP BY 
    c.nombre
ORDER BY
    SUM(lp.punitario * lp.cantidad) DESC;


--12.- Mostrar el precio medio de los productos de cada fabricante. (Utilizar formato de cantidades numéricas 
--mostraremos las cantidades con dos decimales y la moneda por detrás de la cantidad).
SELECT * FROM PRODUCTOS;

SELECT 
    idfabricante AS "Fabricante",
    TO_CHAR(AVG(punitario), '99G999G999D00L') AS "Precio Medio"
FROM
    productos
GROUP BY
    idfabricante;

--13.- Mostrar la siguiente descripción de los manteles: 
--mantel color tamaño 99x99 del fabricante nombre cuesta 99 euros.
--El texto en negrita se sustituirá por su valor en la Base de Datos.
SELECT * FROM PRODUCTOS;

SELECT 
    'mantel ' ||
    SUBSTR(descripcion,INSTR(descripcion,' ',1,3)+1) ||
    ' tamaño ' ||
    SUBSTR(descripcion,INSTR(descripcion,' ',1,2)+1,INSTR(descripcion,' ',1,3)-INSTR(descripcion,' ',1,2)-1) ||
    ' del fabricante ' ||
    idFabricante ||
    ' cuesta ' ||
    punitario ||
    ' euros.'
FROM
    productos
WHERE
    LOWER(descripcion) LIKE '%mantel%';

--14.- Mostrar la descripción de los productos y a continuación una columna en donde aparezca 
--el texto CUBERTERÍA si son cucharas, tenedores y cuchillos CRISTALERÍA copas y vasos o TEXTIL si son manteles.
-- 
SELECT * FROM PRODUCTOS;

SELECT
    descripcion,
    CASE 
        WHEN LOWER(descripcion) LIKE '%cuchara%'
             OR
             LOWER(descripcion) LIKE '%tenedor%'
             OR
             LOWER(descripcion) LIKE '%cuchillo%'
             OR
             LOWER(descripcion) LIKE '%cuberteria%'
                 THEN 'Cubertería'
        WHEN LOWER(descripcion) LIKE '%vaso%'
             OR
             LOWER(descripcion) LIKE '%copa%'
                THEN 'Cristalería'
        WHEN LOWER(descripcion) LIKE '%mantel%' 
                THEN 'Textil'
    ELSE 'Otros'            
    END AS "Categoría"                
FROM
    productos;

--15.- Mostrar las descripciones de los productos y una nueva columna en donde verifiquemos si tenemos que comprar
--urgentemente un producto verificando que el stock es menor que el nivel de nuevo pedido si la diferencia 
--está entre 10 unidades y 30 unidades  tendremos que realizar una compra a medio plazo y si es superior a 30 será una compra a largo plazo.
SELECT * FROM PRODUCTOS;

SELECT 
    descripcion,
    CASE
        WHEN stock < nivelnuevopedido THEN 'Corto Plazo'
        WHEN (stock - nivelnuevopedido) BETWEEN 10 AND 30 THEN 'Medio Plazo'
        WHEN (stock - nivelnuevopedido) > 30  THEN 'Largo Plazo'
        ELSE 'Stock Suficiente'
    END AS "Compra Proyectada"
FROM
    productos;
