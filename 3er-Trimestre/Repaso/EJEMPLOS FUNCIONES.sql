-- Descripción , precio actual, y precio amigo (productos de asa rebaja del 2%)
-- productos de bra rebaja del 3% y demás rebaja del 5%)

SELECT * FROM PRODUCTOS;
SELECT 
    idfabricante,
    descripcion,
    punitario AS "PRECIO ACTUAL",
    CASE LOWER(idfabricante)
    WHEN 'asa' THEN ROUND(punitario*0.98,2)
    WHEN 'bra' THEN ROUND(punitario*0.97,2)
    ELSE ROUND(punitario*0.95,2)
    END AS "PRECIO AMIGO"
FROM productos;  

SELECT 
    idfabricante,
    descripcion,
    punitario AS "PRECIO ACTUAL",
    CASE LOWER(idfabricante)
    WHEN 'asa' THEN ROUND(punitario*0.98,2)
    WHEN 'bra' THEN ROUND(punitario*0.97,2)
    ELSE ROUND(punitario*0.95,2)
    END AS "PRECIO AMIGO"
FROM productos; 

--Si el empleado lleva mas de 20 años en la empresa incrementar su cuota un 2%, si lleva 10 y 20 años incrementar en un 3%
-- y si lleva menos de 10 años incrementar en un 4%
SELECT * FROM EMPLEADOS;

SELECT
    idempleado,
    nombre,
    NVL(cuota,0) AS "Cuota Vieja",
    TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12) AS "Años en la Empresa",
    CASE
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12)>20 THEN NVL(cuota*1.02,0)
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fcontrato)/12) BETWEEN 10 AND 20 THEN NVL(cuota*1.03,0)
    ELSE NVL(cuota*1.04,0)
    END AS "Nueva Cuota"
FROM EMPLEADOS;        


