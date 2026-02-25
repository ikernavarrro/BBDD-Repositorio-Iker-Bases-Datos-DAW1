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

/*Mostrar todos los empleados que no act�an como representantes de clientes.*/
SELECT * FROM EMPLEADOS;
SELECT * FROM CLIENTES;

SELECT *
FROM empleados e
WHERE idempleado NOT IN(
    SELECT representante
    FROM clientes);

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

/*4.- Listar los productos (idfab, idproducto y descripci�n) que aparecen en pedidos de m�s de 25000� o m�s.*/

/*5.- Listar los clientes asignados a Maria Bego�a Se�or Se�or que han remitido un pedido superior a 3000 �. 
�Y los que no han remitido un pedido superior a 3000�?*/

/*6.- Listar las oficinas en donde haya un vendedor cuyas ventas representen m�s del 55% del objetivo de su oficina.*/

/*7.- Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/

/*8.- Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus vendedores.*/