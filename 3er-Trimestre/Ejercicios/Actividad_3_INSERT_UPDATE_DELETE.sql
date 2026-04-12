-- ACTIVIDAD 3 INSERT, UPDATE y DELETE


--1.- Inserta los siguientes registros en la tabla OFICINAS:

SELECT * FROM OFICINAS;

-- Registro 1:
INSERT INTO oficinas 
VALUES (
    90,
    'Alameda Recalde 31, 2 Planta',
    48009,
    'BILBAO',
    'NORTE',
    944111155,
    110,
    500000,
    175000);

SELECT * FROM OFICINAS WHERE idoficina = 90;

-- Registro 2:
INSERT INTO oficinas
VALUES (
    91,
    'Sabino Arana 33, Bajo',
    48013,
    'BILBAO',
    'NORTE',
    944241424,
    104,
    585000,
    null);

SELECT * FROM OFICINAS WHERE idoficina = 91;

--2.- Añadir una nueva oficina para la ciudad de Madrid, con el número de oficina 30, con un 
--objetivo de 600000 y región Centro, dirección Gran Vía 34, CP 28013. Los demás campos 
--irán a nulos.  
SELECT * FROM OFICINAS;

INSERT INTO 
    oficinas (
        idoficina,
        direccion,
        cpostal,
        ciudad,
        region,
        objetivo)
VALUES (
    30,
    'Gran Vía 34',
    28013,
    'MADRID',
    'CENTRO',
    600000);

SELECT * FROM OFICINAS WHERE idoficina = 30;

--3.- Poner a 0 las ventas de los empleados de las oficinas 12 y 21.  
SELECT * FROM EMPLEADOS;

UPDATE empleados
SET ventas = 0
WHERE idoficina IN (12,21);

SELECT * FROM EMPLEADOS;

--4.- Poner a 0 las ventas de los empleados de las oficinas de Madrid y Valencia.  
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

UPDATE empleados
SET ventas = 0
WHERE idoficina IN (
    SELECT idoficina
    FROM oficinas
    WHERE LOWER(ciudad) = 'madrid' OR LOWER(ciudad) = 'valencia');

SELECT * FROM EMPLEADOS;

--5.- Actualizar la cuota de los empleados. Esta cuota debe ser el objetivo de su oficina 
--incrementado en un 1%.  
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

UPDATE empleados e
SET cuota = (
    SELECT objetivo * 1.01
    FROM oficinas o
    WHERE e.idoficina = o.idoficina);

SELECT * FROM EMPLEADOS;

--6.- Borrar los pedidos del cliente Estefania Garcia Anton. (Debes borrar primero las líneas de pedido 
--de los pedidos de Estefanía García Anton y después borrar los pedidos).  
SELECT * FROM PEDIDOS;
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM CLIENTES;

/*Eliminamos datos en lineas pedidos*/
DELETE FROM lineas_pedidos lp
WHERE EXISTS (
    SELECT *
    FROM pedidos p
    WHERE lp.codigo = p.codigo
          AND
          idcliente = (
            SELECT idcliente
            FROM clientes
            WHERE LOWER(nombre) = 'estefania garcia anton'));

/*Eliminamos datos en pedidos*/
DELETE FROM pedidos
WHERE idcliente = (
            SELECT idcliente
            FROM clientes
            WHERE LOWER(nombre) = 'estefania garcia anton');

--7.- Subir un 5% el precio de todos los productos del fabricante bra.  
SELECT * FROM PRODUCTOS;

UPDATE productos
SET punitario = punitario * 1.05
WHERE LOWER(idfabricante) = 'bra';

SELECT * FROM PRODUCTOS;

--8.- Cambiar los empleados de la oficina 21 a la oficina 30.  
SELECT * FROM EMPLEADOS;

UPDATE empleados
SET idoficina = 30
WHERE idoficina = 21;

SELECT * FROM EMPLEADOS;

--9.- Eliminar los pedidos del empleado Fernando Lopez. 
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM PEDIDOS;
SELECT * FROM EMPLEADOS;

/*Primero eliminamos las lineas de pedidos*/
DELETE FROM lineas_pedidos lp
WHERE EXISTS (
    SELECT *
    FROM pedidos p
    WHERE lp.codigo=p.codigo
          AND
          idvendedor =(
                SELECT idempleado
                FROM empleados
                WHERE LOWER(nombre) = 'fernando lopez gutierrez'));    

SELECT * FROM LINEAS_PEDIDOS;

/*Después eliminamos los pedidos*/
DELETE FROM pedidos
WHERE idvendedor =(
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) = 'fernando lopez gutierrez');
    
SELECT * FROM PEDIDOS;

--10.- Eliminar las oficinas que no tengan empleados. 
SELECT * FROM OFICINAS;
SELECT * FROM EMPLEADOS;

DELETE FROM oficinas o
WHERE NOT EXISTS (
    SELECT idoficina
    FROM empleados e
    WHERE o.idoficina = e.idoficina);
    
SELECT * FROM OFICINAS;    

--11.- Se quiere rebajar la cuota a los empleados que llevan más de 25 años en la empresa. Se 
--decrementará en un 5%. 
SELECT * FROM EMPLEADOS;

UPDATE empleados
SET cuota = cuota *0.95
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12) > 25;

SELECT * FROM EMPLEADOS;

--12.- Borrar todos los pedidos de los clientes que tengan como representante a Miguel Estrella. 
--(Primero debéis borrar las líneas de pedido y posteriormente los pedidos).  
SELECT * FROM LINEAS_PEDIDOS;
SELECT * FROM PEDIDOS;
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

/*Borramos lineas_pedidos*/
DELETE FROM lineas_pedidos lp
WHERE EXISTS (
    SELECT *
    FROM pedidos p
    WHERE lp.codigo = p.codigo
          AND
          idcliente IN (
            SELECT idcliente
            FROM clientes
            WHERE representante = (
                SELECT idempleado
                FROM empleados
                WHERE LOWER(nombre) = 'miguel estrella lopez')));
                
SELECT * FROM LINEAS_PEDIDOS; 

/*Borramos pedidos*/
DELETE FROM pedidos
WHERE idcliente IN (
            SELECT idcliente
            FROM clientes
            WHERE representante = (
                SELECT idempleado
                FROM empleados
                WHERE LOWER(nombre) = 'miguel estrella lopez'));

SELECT * FROM PEDIDOS;

--13.- Todos los envíos de mayo del 2007 se entregaron 5 días más tarde de la fecha de pedido. 
--Actualizar dicha fecha.  
SELECT * FROM PEDIDOS;

UPDATE pedidos
SET fenvio = fpedido + 5
WHERE EXTRACT(YEAR FROM fpedido) = 2007 AND EXTRACT(MONTH FROM fpedido) = 5;

SELECT * FROM PEDIDOS;

--14.- Maria Larraga va a coger una baja de 6 meses, por lo que todos los empleados que están bajo sus 
--órdenes tienen que pasar a estar bajo las órdenes de su jefe. Y las oficinas que dirige también.
SELECT * FROM EMPLEADOS;
SELECT * FROM OFICINAS;

/*Primero actualizamos a  los empleados*/
UPDATE empleados
SET jefe = (
    SELECT jefe
    FROM empleados
    WHERE LOWER(nombre) = 'maria larraga alcantara')
WHERE jefe = (
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) = 'maria larraga alcantara');
    
SELECT * FROM EMPLEADOS;

/*Después actualizamos las oficinas*/   
UPDATE oficinas
SET director = (
    SELECT jefe
    FROM empleados
    WHERE LOWER(nombre) = 'maria larraga alcantara')
WHERE director = (
    SELECT idempleado
    FROM empleados
    WHERE LOWER(nombre) = 'maria larraga alcantara');

SELECT * FROM OFICINAS;

-- Realizamos ROLLBACK
ROLLBACK;