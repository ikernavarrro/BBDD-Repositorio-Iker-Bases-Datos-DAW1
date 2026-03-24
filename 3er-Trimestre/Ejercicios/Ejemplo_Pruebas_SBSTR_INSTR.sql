-- QUIERO UN CAMPO QUE SEA EL EMAIL; INICIA + PRIMER APELLIDO + 3 PRIMERAS LETRAS DEL SEGUNDO APELLIDO + @zabalburu.org
SELECT LOWER(SUBSTR(nombre,1,1) 
|| SUBSTR(nombre,INSTR(nombre,' ',1,1)+1,INSTR(nombre,' ',1,2)-INSTR(nombre,' ',1,1)-1) 
|| SUBSTR(nombre,INSTR(nombre,' ',1,2)+1,3) 
|| '@zabalburu.org') AS "Email Empleado"
FROM EMPLEADOS;
// 3 = (INSTR(nombre,' ',1,2)+4)-(INSTR(nombre,' ',1,2)+1)
--Alfonso Pérez Navarro