/* DML : Inserci�n (INSERT), modificaci�n (UPDATE), borrado (DELETE) */

INSERT INTO tabla VALUES (valor1,'valor2','valor3', valor4, valor5);

INSERT INTO tabla VALUES (valor1,'valor2','valor3', NULL, NULL);

INSERT INTO tabla (campo1,campo2,campo3)  VALUES (valor1,'valor2','valor3');

desc empleados;

/*Introduce todos los datos de un empleado en orden de campos del dise�o de la tabla*/

INSERT INTO empleados VALUES (789,'Marta Torre','10/10/1987',12,'representante',sysdate,108,'999888777',100000,150000);

INSERT INTO empleados VALUES(798,'Miren Ibargoitia',NULL,12,'comercial',sysdate,108,NULL,NULL,NULL);


/* Introduciendo  valores nulos dos formas */
INSERT INTO empleados VALUES(800,'Pablo Ibargoitia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO empleados(idempleado,nombre) VALUES (801,'Miren L�pez');

INSERT INTO CLIENTES (idcliente,nombre) SELECT idempleado,nombre FROM empleados WHERE lower(puesto)='director general';

COMMIT; // Lleva a cabo la transacci�n, es decir, guarda los datos

ROLLBACK; //desecha  los cambios desde el �ltimo commit realizado


/*Insertar un producto : 
Fabricante:rei
Producto: 123xz
descripcion: cuberteria completa
punitario:300
stock:50
nivelnuevopedido:10
*/
desc productos;
INSERT INTO productos VALUES ('rei','123xz','cuberteria completa',300,50,10);
SELECT * FROM productos;
/*Insertar la oficina:
oficina:30
direccion: Gran Via 12
CP:48012
ciudad:Bilbao
region:Norte
director:106
objetivo:150000*/

desc oficinas;
INSERT INTO oficinas VALUES (30,'Gran Via 12', '48012','Bilbao','Norte',NULL,106,150000,NULL);
/*Insertar la oficina:
oficina:31
ciudad:Bilbao
region:Norte
objetivo:150000*/
INSERT INTO oficinas(idoficina,ciudad,region,objetivo) VALUES (31,'Bilbao','Norte',150000);
SELECT * FROm oficinas;

/*Insertar empleado
numemp:500
nombre:scott tiger
*/
desc empleados;
INSERT INTO empleados(idempleado,nombre) VALUES (501,'scott tiger');
INSERT INTO empleados VALUES (500,'scott tiger',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
SELECT * FROM empleados;


/* INSERT INTO ...... SELECT: Insertar datos en una tabla que están en otra tabla*/

DESC empleados;
DESC clientes;

--Insertar en la tabla de clientes a un nuevo cliente que sea el director general . Solo insertaremos idempleado y nombre
SELECT * FROM empleados;
INSERT INTO CLIENTES (idcliente,nombre) SELECT idempleado,nombre FROM empleados WHERE lower(puesto)='director general';


--Insertar en la tabla de clientes a losempleados que son comerciales . Solo insertaremos idempleado y nombre.
SELECT * FROM clientes;
delete from clientes WHERE idcliente=111;
INSERT INTO CLIENTES (idcliente,nombre) SELECT idcliente,nombre FROM empleados WHERE lower(puesto)='comercial';

desc empleados;


/*Inserta el empleado 805 llamado Pedro Rodriguez en la oficina que m�s empleados tiene*/
INSERT INTO EMPLEADOS (idempleado,nombre,idoficina) VALUES( 805,'Pedro Rodriguez',(SELECT idoficina FROM empleados
GROUP BY idoficina HAVING COUNT(*)=
(SELECT MAX(COUNT(*)) FROM empleados GROUP BY idoficina)));



/* Insertar la oficina:

oficina:33
ciudad:Vitoria-Gasteiz
Region: Norte
Ventas: Suma de las ventas de todos los empleados de la oficina 12.
*/

desc oficinas;
desc empleados;
INSERT INTO oficinas(idoficina,ciudad,region,ventas) VALUES(36,'Vitoria','Norte',(SELECT SUM(ventas) 
FROM empleados WHERE idoficina=12));

-- Insertar la Oficina 38 en Vitoria, región Norte con el objetivo máximo de los empleados de la oficina 12 y las ventas de todos los 
--empleados de la oficina 12

INSERT INTO oficinas (idoficina,ciudad,region,objetivo,ventas) VALUES (38,'VITORIA','NORTE',(SELECT MAX(objetivo) FROM 
empleados WHERE idoficina=12),(SELECT  SUM(ventas) 
FROM empleados WHERE idoficina=12));


/* UPDATE: */
COMMIT;
SELECT * FROM oficinas;
UPDATE tabla SET campo1=valor1,campo2=valor2,campo3=valor3 WHERE condicion=valor.......;

--POner como fecha de contrato del empleado 101 la fecha del día de hoy
UPDATE empleados SET fcontrato=sysdate WHERE idempleado=101;
--POner como fecha de contrato del empleado 101 la fecha del día de hoy, como ventas sumadas 100000 a sus ventas y como oficina la 13
UPDATE empleados SET fcontrato=sysdate,ventas=ventas+100000,idoficina=13 WHERE idempleado=101;

--Asignar una nueva oficina a todos los empleados de la oficina 12. Esta nueva oficina será la de la ciudad de badajoz
UPDATE empleados SET idoficina=(SELECT idoficina FROM oficinas WHERE lower(ciudad)='badajoz') WHERE idoficina=12; 

-- Incrementar en un 5% el objetivo de todos los empleados de la oficina de badajoz
UPDATE empleados SET cuota=cuota*1.05 WHERE idoficina=(SELECT idoficina FROM oficinas WHERE lower(ciudad)='badajoz');

SELECT * FROM empleados;
SELECT * FROM empleados;
ROLLBACK;

/*DELETE*/

DELETE FROM tabla WHERE condicion;

-- Eliminar todos las oficinas que no tienen director
DELETE  FROM oficinas WHERE dir is null ;

--Eliminar todos los empleados cuyo jefe es luis amezti
DELETE empleados WHERE jefe = (SELECT numemp FROM empleados WHERE lower(nombre) like 'luis amezti %');
SELECT * FROM oficinas;
ROLLBACK;




 