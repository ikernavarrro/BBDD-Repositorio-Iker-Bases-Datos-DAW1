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


    




