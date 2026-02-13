SELECT * FROM EMPLEADOS;

SELECT nombre,fnacimiento AS "FECHA DE NACIMIENTO" FROM EMPLEADOS;

SELECT nombre, puesto, jefe , ventas FROM EMPLEADOS WHERE ventas > 200000;

SELECT nombre, puesto, jefe , ventas FROM EMPLEADOS WHERE ventas > 200000 AND LOWER(puesto)='comercial';

SELECT nombre, jefe, fnacimiento FROM EMPLEADOS WHERE idoficina=12;

SELECT nombre, jefe, fnacimiento FROM EMPLEADOS WHERE idoficina=12 OR idoficina=21 OR idoficina=22 ;

SELECT * FROM empleados;
SELECT nombre, cuota, cuota*1.05 AS "Cuota Para 2026" FROM empleados;

SELECT * FROM productos;

SELECT 'Producto: ' || descripcion || ' del fabricante ' || idfabricante || ' | Existencias: ' || stock AS "DESCRIPCIÓN PRODUCTOS" FROM productos;

SELECT * FROM oficinas WHERE ventas IS NULL AND UPPER(ciudad) IN ('MADRID','PAMPLONA') ORDER BY ciudad;

SELECT * FROM productos WHERE(nivelnuevopedido)BETWEEN 100 AND 150 AND stock<150 ORDER BY stock desc;

SELECT punitario, idfabricante FROM productos WHERE LOWER(descripcion) LIKE 'mantel %azul marino%' ORDER BY punitario, idfabricante; 

SELECT nombre, puesto, fnacimiento, fcontrato, jefe, ventas-cuota "Diferencia" FROM empleados WHERE fnacimiento<'01/01/1980' AND LOWER(puesto) LIKE '%director%';