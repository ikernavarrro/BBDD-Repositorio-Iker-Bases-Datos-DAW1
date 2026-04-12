-- Actividad 2 Update

-------------------UPDATE

--1.- Actualizar el campo cuota de todos los empleados. A todos les pondremos la cifra de 10000. 
SELECT * FROM EMPLEADOS;

UPDATE empleados 
SET cuota=100000; 

SELECT * FROM EMPLEADOS;
--La sintaxis empleada es: 
--Update tabla set campo=valorNuevo; 
--Si no ponemos cláusula WHERE afecta a todos los registros de la tabla en la que estamos 
--modificando.

--2.- Actualizar el campo cuota de todos los empleados de las oficinas 12 y 21. A todos les 
--pondremos la cifra de 15000. 
SELECT * FROM EMPLEADOS;

UPDATE empleados 
SET cuota=150000 
WHERE idoficina IN (12,21); 

SELECT * FROM EMPLEADOS;
--La sintaxis empleada es: 
--Update tabla set campo=valorNuevo WHERE condición; 

--3.- Actualizar el campo cuota de todos los empleados de las oficinas de valencia y Madrid. A 
--todos les pondremos la cifra de 20000. 
SELECT * FROM EMPLEADOS;

UPDATE empleados 
SET cuota=20000 
WHERE idoficina IN  
    (SELECT idoficina 
    FROM oficinas 
    WHERE LOWER(ciudad) IN ('valencia','madrid')); 
    
SELECT * FROM EMPLEADOS;
--La sintaxis empleada es: 
--Update tabla set campo=valorNuevo WHERE condición que está en otra tabla diferente a la que 
--estamos cambiando el campo;

--4.-  Incrementar el precio de los productos del fabricante asa en un 3%. 
SELECT * FROM PRODUCTOS;

UPDATE productos 
SET punitario = punitario * 1.03 
WHERE LOWER(idfabricante)='asa'; 

SELECT * FROM PRODUCTOS;

--5.-  Incrementar el precio de los productos de los fabricantes que hayan vendido en el año 
--1999 en un 3%. 
SELECT * FROM PRODUCTOS;

UPDATE productos pro 
SET punitario = punitario * 1.03 
WHERE EXISTS 
    (SELECT * 
    FROM lineas_pedidos lp 
    WHERE pro.idfabricante=lp.fabricante 
          AND 
          pro.idproducto=lp.producto 
          AND codigo IN 
            (SELECT codigo 
            FROM pedidos 
            WHERE EXTRACT (YEAR FROM fpedido)=1999)); 

SELECT * FROM PRODUCTOS;         
            
--Como la condición está en pedidos y el campo a actualizar está en productos tengo que ir 
--desde la tabla de productos que es donde estoy actualizando hasta la tabla de pedidos para 
--poner la condición. Debo pasar por tanto por lineas_pedidos.

--6.- Actualizar el campo director a todas las oficinas de valencia. Este nuevo director va a ser 
--el empleado 106. 
SELECT * FROM OFICINAS;

UPDATE oficinas
SET director = 106
WHERE LOWER(ciudad) = 'valencia';

SELECT * FROM OFICINAS;

--7.- Actualizar el campo director a todas las oficinas de Madrid. La nueva directora va a ser 
--Luisa Sabater. 
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

UPDATE oficinas
SET director = 
    (SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE '%luisa sabater%')
WHERE LOWER(ciudad) = 'madrid';

SELECT * FROM OFICINAS;

--8.- A todos los clientes que se han dado de alta posteriormente al año 2012 ponedles como 
--representante al empleado 110. 
SELECT * FROM CLIENTES;

UPDATE clientes
SET representante = 110
WHERE EXTRACT(YEAR FROM falta) > 2012;

SELECT * FROM CLIENTES;

--9.- A todos los clientes que se han dado de alta entre los años 2007 y 2012 ponedles como 
--representante a la empleada Begoña Marquez. 
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

UPDATE clientes
SET representante =
    (SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) LIKE '%bego a marquez%')
WHERE EXTRACT(YEAR FROM falta) BETWEEN 2007 AND 2012;

SELECT * FROM CLIENTES;

--10.- Cambiad el móvil de Estibaliz Ulibarri a este nuevo:987987987. 
SELECT * FROM EMPLEADOS;

UPDATE empleados
SET movil = 987987987
WHERE LOWER(nombre) LIKE '%estibaliz ulibarri%';

SELECT * FROM EMPLEADOS;

--11.-A partir de este momento el puesto de Comercial se va llamar representante comercial, 
--es decir a todos los empleados que sean comerciales hay que ponerles ahora el puesto 
--representante comercial. 
SELECT * FROM EMPLEADOS;

UPDATE empleados
SET puesto = 'REPRESENTANTE COMERCIAL'
WHERE LOWER(puesto) = 'comercial';

SELECT * FROM EMPLEADOS;

--Realizar un ROLLBACK; !¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡
ROLLBACK;  

-------------------DELETE 

--12.- Eliminar todos los productos. 
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

DELETE productos;  /*NO SE ELIMINAN PORQUE LA TABLA LINEAS_PEDIDOS TIENE REFERENCIA COMO CLAVE FORÁNEA Y NO SE PUSO CLÁUSULA ON DELETE*/

/*
Tendríamos que borrar primeros todas las líneas de pedidos y después borrar los productos.
*/
DELETE lineas_pedidos;

DELETE productos;

SELECT * FROM PRODUCTOS;
--Si no ponemos cláusula WHERE en la sentencia afecta a todos los registros de la tabla, es decir, elimina 
--todos los productos. 
--Comprobadlo!!! 
ROLLBACK;  
--Vamos a volver atrás para recuperar los registros eliminados. 

--13.- Eliminar todos los productos del fabricante asa. 
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

DELETE productos 
WHERE LOWER(idfabricante)='asa'; /*AQUÍ PASA LO MISMO QUE EN EL EJERCICIO ANTERIOR*/

/*
Tendríamos que borrar primeros las líneas de pedidos y después borrar los productos.
*/
DELETE lineas_pedidos
WHERE LOWER(fabricante)='asa';

DELETE productos 
WHERE LOWER(idfabricante)='asa';

SELECT * FROM PRODUCTOS;

ROLLBACK;  

--14.- Eliminar todos los clientes del representante 109. 
SELECT * FROM CLIENTES;

DELETE clientes 
WHERE representante=109; 

ROLLBACK; 

SELECT * FROM CLIENTES;

--15.- Eliminar todos los clientes del representante Raul Aldamiz. 
SELECT * FROM CLIENTES;

DELETE clientes 
WHERE representante IN 
    (SELECT idempleado 
    FROM empleados 
    WHERE LOWER(nombre) LIKE 'raul aldamiz %'); 

ROLLBACK; 

SELECT * FROM CLIENTES;

--16.- Elimina todos los pedidos anteriores al año 2000. 
SELECT * FROM PEDIDOS;

DELETE pedidos 
WHERE EXTRACT(YEAR FROM fpedido) < 2000; 

ROLLBACK; 

SELECT * FROM PEDIDOS;

--17.- Elimina todos los pedidos cuyo importe sea inferior a 3000. 
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;

DELETE pedidos 
WHERE codigo IN  
    (SELECT codigo 
    FROM lineas_pedidos 
    GROUP BY codigo 
    HAVING SUM(cantidad*punitario) < 3000);

/*
Al comprobar los datos se habian borrado de pedidos pero no de lineas_pedidos lo cual es raro
y al investigar he dado con la clave, no hay FK entre las dos tablas.

COMPROBAR RESTRICCIONES:
SELECT constraint_name, constraint_type, table_name 
FROM user_constraints 
WHERE table_name IN ('PEDIDOS', 'LINEAS_PEDIDOS');

Para arreglarlo debemos añadir una FK a la tabla LINEAS_PEDIDOS

ARREGLAR LA TABLA:

ALTER TABLE lineas_pedidos 
ADD CONSTRAINT fk_lineas_pedidos_pedidos 
FOREIGN KEY (codigo) REFERENCES pedidos(codigo) 
ON DELETE CASCADE;

AHORA SI NO HABRÍA PROBLEMAS Y NO QUEDARÍAN LINEAS DE PEDIDOS HUERFANAS
*/


ROLLBACK; 

SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM PEDIDOS;

--18.- Eliminar todos los empleados de más de 55 años. 
SELECT * FROM EMPLEADOS;

DELETE empleados 
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,fnacimiento)/12) > 55; 

SELECT * FROM EMPLEADOS;

--19.- Eliminar todas las lineas de pedidos con cantidades inferiores a 100 unidades 
SELECT * FROM LINEAS_PEDIDOS;

DELETE lineas_pedidos
WHERE cantidad < 100;

SELECT * FROM LINEAS_PEDIDOS;

--20.- Eliminar todos los productos que no hayan sido pedidos, es decir, que no se encuentren en 
--lineas_pedidos. 
SELECT * FROM PRODUCTOS;
SELECT * FROM LINEAS_PEDIDOS;

DELETE productos pr
WHERE NOT EXISTS (
        SELECT *
        FROM lineas_pedidos lp
        WHERE pr.idfabricante = lp.fabricante 
              AND
              pr.idproducto = lp.producto);

SELECT * FROM PRODUCTOS;

--21.- Eliminar todos los empleados que sean comerciales. 
SELECT * FROM EMPLEADOS;

DELETE empleados
WHERE LOWER(puesto) LIKE '%comercial%';

SELECT * FROM EMPLEADOS;

--22.- Eliminar todas las oficinas con un objetivo mayor a 600000 y dirigidas por Estibaliz Ulibarri.
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

DELETE oficinas
WHERE objetivo > 600000
      AND
      director = (
        SELECT idempleado
        FROM empleados
        WHERE LOWER(nombre) LIKE '%estibaliz ulibarri%');

SELECT * FROM OFICINAS;

--Realizar un ROLLBACK; !¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡!¡
ROLLBACK; 
