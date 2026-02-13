/*ELIMINAR TABLAS : DROP TABLE */

/*DROP TABLE TABLA;*/

DROP TABLE P_PEDIDOS;




/*Si la tabla es la parte 1 de una relacion 1-N y est� creada esa relaci�n no te dejar� borrarla, a menos que escribas tras el comando
DROP TABLE tabla CASCADE CONSTRAINTS;*/

/*Por ejemplo:*/

DROP TABLE P_EMPLEADOS CASCADE CONSTRAINTS;

/* Elimina tanto la tabla de la parte 1 como la restricción de clave foránea 
en el campo de la tabla de la parte N*/
SELECT * FROM USER_CONSTRAINTS WHERE LOWEr(TABLE_NAME) IN ('p_oficinas','p_pedidos');