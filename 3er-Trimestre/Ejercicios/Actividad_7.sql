-- Actividad 7 --

--1. Seleccionar el no de empleado, salario, comisión, no de departamento y fecha de la
--tabla EMP.
SELECT * FROM EMP;

SELECT 
    eno,
    sal,
    comm,
    deptno,
    hiredate
FROM emp
ORDER BY eno;    

--2. Seleccionar todas las columnas de la tabla DEPT.
SELECT * FROM dept;

--3. Seleccionar aquellos empleados que sean ‘SALESMAN’.
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE LOWER(job)= 'salesman';

--4. Seleccionar aquellos empleados que no trabajen en el departamento 30.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE deptno != 30
ORDER BY eno;

--5. Seleccionar el nombre de aquellos empleados que ganen más de 2000.
SELECT * FROM EMP;

SELECT 
    ename
FROM emp
WHERE sal > 2000
ORDER BY eno;

--6. Seleccionar aquellos empleados que hayan entrado antes del 1/1/82
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE hiredate < TO_DATE('1982/01/01', 'yyyy/mm/dd')
ORDER BY eno;

--7. Seleccionar el nombre de los vendedores que ganen más de 1500.
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE LOWER(job) = 'salesman' AND sal > 1500;

--8. Seleccionar el nombre de aquellos que sean ‘CLERK’ o trabajen en el departamento 30.
SELECT * FROM EMP;

SELECT
    ename
FROM emp
WHERE LOWER(job) = 'clerk' OR deptno = 30
ORDER BY eno;

--9. Seleccionar aquellos que se llamen ‘SMITH’, ‘ALLEN’ o ‘SCOTT ‘.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE LOWER(ename) IN ('smith','allen','scott');
--WHERE LOWER(ename)='smith' OR LOWER(ename)='allen' OR LOWER(ename)='scott';

--10. Seleccionar aquellos que no se llamen ‘SMITH’, ‘ALLEN’ o ‘SCOTT ‘.
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE LOWER(ename) NOT IN ('smith','allen','scott')
--WHERE LOWER(ename)!='smith' AND LOWER(ename)!='allen' AND LOWER(ename)!='scott'
ORDER BY eno;

--11. Seleccionar aquellos cuyo salario esté entre 2000 y 3000.
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE sal BETWEEN 2000 AND 3000
ORDER BY eno;

--12. Seleccionar los empleados que trabajan en el mismo departamento que ‘CLARK’.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE deptno IN(
    SELECT 
        deptno
    FROM emp
    WHERE LOWER(ename)='clark')
ORDER BY eno;

--13. Seleccionar los empleados que trabajen en ‘CHICAGO’.
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT
    *
FROM emp
WHERE deptno IN (
    SELECT 
        deptno
    FROM dept
    WHERE LOWER(loc)='chicago')
ORDER BY eno;

--14. Nombre de todos los empleados, empleo, departamento y localidad.
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT 
    e.ename AS "Nombre Empleado",
    e.job AS "Empleo",
    e.deptno AS "Nro Departamento",
    d.loc AS "Localidad"
FROM emp e JOIN dept d ON e.deptno=d.deptno
ORDER BY e.eno;    

--15. Seleccionar aquellos empleados que trabajen en el departamento 10, o en el 20.
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT 
    *
FROM emp
WHERE deptno IN (
    SELECT 
        deptno
    FROM dept
    WHERE deptno IN (10,20))
ORDER BY eno;

--16. Seleccionar los distintos departamentos que existen en la tabla EMP.
SELECT 
    DISTINCT deptno
FROM emp;     

--17. Seleccionar los distintos empleos que hay en cada departamento.
SELECT * FROM EMP;

SELECT
    DISTINCT deptno,
    job
FROM emp
ORDER BY deptno;  

--18. Seleccionar aquellos empleados que hayan entrado en 1981.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE EXTRACT(YEAR FROM hiredate) = 1981
ORDER BY eno;

--19. Seleccionar aquellos empleados que tienen comisión.
SELECT * FROM EMP;

SELECT
    *
FROM emp    
WHERE comm IS NOT NULL;

--20. Seleccionar aquellos empleados cuyo nombre empiece por ‘A’.
SELECT * FROM EMP;

/*SELECT 
    *
FROM emp
WHERE LOWER(SUBSTR(ename,1,1))='a';*/
SELECT
    *
FROM emp
WHERE LOWER(ename) LIKE 'a%';

--21. Seleccionar aquellos empleados cuyo nombre tenga como segunda letra una ‘D’.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE LOWER(SUBSTR(ename,2,1))='d';
--WHERE LOWER(ename) LIKE '_d%';
-- La _ representa a un carácter cualquiera.

--22. Seleccionar aquellos empleados que ganen más de 1500, ordenados por empleo.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE sal > 1500
ORDER by job;

--23. Calcular el salario anual a percibir por cada empleado.
SELECT * FROM EMP;

SELECT
    ename,
    sal*4*12 AS "Salario Anual"
FROM emp
ORDER BY eno;

--24. Calcular el salario total mensual.
SELECT * FROM EMP;

SELECT
    SUM(sal*4) AS "Salario Total Mensual"
FROM emp;

--25. Calcular el número de empleados que tienen comisión y la media.
SELECT * FROM EMP;

SELECT 
    COUNT(*) AS "Nro Empleados",
    AVG(comm)
FROM emp
WHERE comm IS NOT NULL;    

--26. Seleccionar el salario, mínimo y máximo de los empleados, agrupados por empleo.
SELECT * FROM EMP;

SELECT
    job,
    MIN(sal) AS "Salario Mínimo",
    MAX(sal) AS "Salario Máximo"
FROM emp
GROUP BY job
ORDER BY job;

--27. Seleccionar el número de empleados que tienen comisión y la media de la misma en cada
--departamento.
SELECT * FROM EMP;

SELECT 
    deptno,
    COUNT(comm),
    AVG(comm)
FROM emp
GROUP BY deptno;

--28. Calcular el número de empleados por departamento que tienen un salario superior a la
--media.
SELECT * FROM EMP;

SELECT
    deptno,
    COUNT(*) AS "Nro Empleados"
FROM emp
WHERE sal > (
    SELECT 
        AVG(sal)
    FROM emp)
GROUP BY deptno;

--29. Seleccionar el salario mínimo, máximo y medio de los empleados agrupados por empleo.
SELECT * FROM EMP;

SELECT 
    job,
    MIN(sal) AS "Salario Mínimo",
    MAX(sal) AS "Salario Máximo",
    ROUND(AVG(sal)) AS "Salario Medio"
FROM emp
GROUP BY job
ORDER BY job;

--30. Seleccionar el salario mínimo, máximo y medio de los empleados agrupados por empleo,
--pero sólo aquellos cuya media sea superior a 4000.
SELECT * FROM EMP;

SELECT 
    job,
    MIN(sal) AS "Salario Mínimo",
    MAX(sal) AS "Salario Máximo",
    ROUND(AVG(sal)) AS "Salario Medio"
FROM emp
GROUP BY job
HAVING AVG(sal) > 4000
ORDER BY job;

--31. Seleccionar los empleados cuyo salario sea superior al de ‘ADAMS’.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE sal > (
    SELECT
        sal
    FROM emp
    WHERE LOWER(ename)='adams')
ORDER BY eno;

--32. Seleccionar el nombre y fecha de ingreso del empleado que lleva menos tiempo.
SELECT * FROM EMP;

SELECT
    ename,
    hiredate
FROM emp
WHERE hiredate = (
    SELECT 
        MIN(hiredate)
    FROM emp);
    
--33. Seleccionar el nombre de los empleados que ganen más que todos los ‘SALESMAN’.
SELECT * FROM EMP;

SELECT
    ename
FROM emp
WHERE sal > (
    SELECT
        MAX(sal)
    FROM emp
    WHERE LOWER(job)='salesman')
ORDER BY eno;

--34. Seleccionar los empleados que ganen más que alguno de los ‘SALESMAN’.
SELECT * FROM EMP;

SELECT 
    *
FROM emp
WHERE sal > (
    SELECT
        MIN(sal)
    FROM emp
    WHERE LOWER(job)='salesman')
ORDER BY eno;

--35. Seleccionar el nombre de cada empleado, y el número y nombre de su jefe.
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT 
    e.ename AS "Nombre Empleado",
    j.eno,
    j.ename AS "Nombre Jefe"
FROM emp e JOIN emp j ON e.mgr=j.eno
ORDEr BY e.ename;

--36. Mostrar el trabajo, el nombre y el salario de los empleados ordenados por el tipo de
--trabajo y por salario descendente.
SELECT * FROM EMP;

SELECT
    job,
    ename,
    sal
FROM emp
ORDER BY job,sal DESC;

--37. Mostrar el nombre del empleado y su fecha de alta en la empresa de los empleados que
--son ‘ANALISTA’.
SELECT * FROM EMP;

SELECT 
    ename,
    hiredate
FROM emp
WHERE LOWER(job)='analyst';    
    
--38. Mostrar el nombre del empleado y una columna que contenga el salario multiplicado por
--la comisión cuya cabecera sea ‘BONO’.    
SELECT * FROM EMP;

SELECT
    ename,
    sal*comm AS "BONO"
FROM emp
ORDER BY eno;    

--39. Encontrar el salario medio de aquellos empleados cuyo trabajo sea el de ANALISTA.
SELECT * FROM EMP;

SELECT
    AVG(sal) AS "Salario Medio"
FROM emp
WHERE LOWER(job)='analyst';

--40. Encontrar el salario más alto, el más bajo y la diferencia entre ambos.
SELECT * FROM EMP;

SELECT 
    MAX(sal) AS "Salario Más Alto",
    MIN(sal) AS "Salario Más Bajo",
    MAX(sal) - MIN(sal) AS "Diferencia"
FROM emp;

--41. Hallar el numero de trabajos distintos que existen en el departamento 30.
SELECT * FROM EMP;

SELECT 
    COUNT(DISTINCT job)
FROM emp
WHERE deptno = 30;

--42. Mostrar el nombre del empleado, su trabajo, el nombre y el código del departamento
--en el que trabaja.
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT
    e.ename,
    e.job,
    d.dname,
    d.deptno
FROM emp e JOIN dept d ON e.deptno=d.deptno
ORDER BY e.eno;    

--43. Mostrar el nombre, el trabajo y el salario de todos los empleados que tienen un salario
--superior al salario más bajo del departamento 30.
SELECT * FROM EMP;

SELECT 
    ename,
    job,
    sal
FROM emp
WHERE sal >(
    SELECT 
        MIN(sal)
    FROM emp
    WHERE deptno = 30)
ORDER BY sal DESC;    

--44. Encontrar a los empleados cuyo jefe es ‘BLAKE’.
SELECT * FROM EMP;

SELECT
    *
FROM emp
WHERE mgr = (
    SELECT 
        eno
    FROM emp
    WHERE LOWER(ename)='blake');

--45. Encontrar el no de trabajadores diferentes en el departamento 30 para aquellos
--empleados cuyo salario pertenezca al intervalo [1000, 1800].  
SELECT * FROM EMP;

SELECT
    COUNT(DISTINCT eno)
FROM emp
WHERE deptno = 30 AND sal BETWEEN 1000 AND 1800;

--46. Encontrar el ename, dname, job y sal de los empleados que trabajen en el mismo
--departamento que ‘TURNER’ y su salario sea mayor que la media del salario del
--departamento 10.
SELECT * FROM EMP;

SELECT
    e.ename,
    d.dname,
    e.job,
    e.sal
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE 
    e.deptno = (
        SELECT 
            deptno
        FROM emp
        WHERE LOWER(ename) = 'turner')
    AND
    e.sal > (
        SELECT
            AVG(sal)
        FROM emp
        WHERE deptno = 10);

--47. Indíquese si las siguientes sentencias son correctas, si no lo son, indique en qué
--consiste el error:        
SELECT * 
FROM EMP
WHERE MGR = NULL;
--No es correcta porque MGR es una clave foránea que hace referencia a la Tabla de Empleados(Relacuón Unaria)
--haciendo referencia al jefe.

SELECT * 
FROM DEPT
WHERE DEPTNO = 20 OR WHERE DEPTNO = 30;
--No es correcta porque hay dos WHERE, tendría que ser así:
SELECT * 
FROM DEPT
WHERE DEPTNO = 20 OR DEPTNO = 30;

SELECT * 
FROM EMP
WHERE NOT ENAME LIKE 'R%'
AND SAL BETWEEN 3000 AND 5000;
-- Si es correcto, se refiere a que no hayan nombres que se parezcan a R% y el salario esté entre 3000 y 5000

SELECT * 
FROM EMP
WHERE SAL < 4000 AND JOB NOT = 'ANALYST';
--No es correcto, no se puede utilizar el operador NOT para referirse a que se no sea igual, para eso está el != sería así:
SELECT * 
FROM EMP
WHERE SAL < 4000 AND JOB != 'ANALYST';

SELECT * FROM DEPT
WHERE LOC = 'DALLAS' OR 'CHICAGO';
--No es correcto, cuando se utiliza un operador OR hay que compararlo entero nuevamente es decir, sería algo así:
SELECT * FROM DEPT
WHERE LOC = 'DALLAS' OR LOC = 'CHICAGO';
    
--48. Visualice el número de los departamentos que tengan más de tres empleados asignados.
SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT 
    deptno
FROM dept
WHERE deptno IN (
    SELECT
        deptno
    FROM emp
    GROUP BY
        deptno
    HAVING COUNT(*) > 3);  
    
--49. El salario medio y mínimo de cada puesto, mostrando en el resultado aquellos cuyo
--salario medio esté por encima de 1500.    
SELECT * FROM EMP;

SELECT
    job,
    ROUND(AVG(sal)),
    MIN(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) > 1500
ORDER BY job;        

--50. ¿Qué empleados trabajan en ‘DALLAS’ ?
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT
    *
FROM emp
WHERE deptno = (
    SELECT 
    deptno
    FROM dept
    WHERE LOWER(loc)='dallas')
ORDER BY eno;

--51. ¿Cuántos trabajan en ‘CHICAGO’ ?
SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT
    COUNT(*)
FROM emp
WHERE deptno =(
    SELECT
        deptno
    FROM dept
    WHERE LOWER(loc)='chicago');
    
--52. Listar el nombre de los empleados que ganan menos que sus supervisores.
SELECT * FROM EMP;

SELECT
    e.ename
FROM emp e JOIN emp j ON e.mgr=j.eno
WHERE e.sal<j.sal
ORDER BY e.eno;

--53. Listar el nombre, trabajo, departamento, localidad y salario de aquellos empleados que
--tengan un salario mayor de 2000 y trabajen en ‘DALLAS’ o ‘NEW YORK’.
SELECT * FROM EMP;

SELECT 
    e.ename,
    e.job,
    e.deptno,
    d.loc,
    e.sal
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE 
    e.sal>2000 
    AND 
    LOWER(d.loc) IN ('dallas','new york')
ORDER BY e.eno;





