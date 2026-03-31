-- Actividad 8 --

--1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros.
SELECT * FROM TRABAJADOR;

SELECT 
    nombre
FROM trabajador
WHERE tarifa BETWEEN 10 AND 12;

--2. ¿Cuáles son los oficios de los trabajadores asignados al edificio 435?
SELECT * FROM TRABAJADOR;
SELECT * FROM ASIGNACION;
SELECT * FROM EDIFICIO;

SELECT 
    t.oficio
FROM trabajador t JOIN asignacion a ON t.id_t=a.id_t
WHERE a.id_e = 435;

--3. Indicar el nombre del trabajador y el de su supervisor.
SELECT * FROM TRABAJADOR;

SELECT 
    t.nombre AS "Nombre Trabajador",
    s.nombre AS "Nombre Supervisor"
FROM trabajador t JOIN trabajador s ON t.id_supv=s.id_t
ORDER BY t.id_t;    

--4. Nombre de los trabajadores asignados a oficinas.
SELECT * FROM TRABAJADOR;
SELECT * FROM ASIGNACION;

SELECT
    nombre
FROM trabajador
WHERE id_t IN(
    SELECT
        DISTINCT id_t
    FROM asignacion)
ORDER BY nombre;

--5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
SELECT * FROM TRABAJADOR;

SELECT
    t.nombre
FROM trabajador t JOIN trabajador s  ON t.id_supv = s.id_t
WHERE t.tarifa > s.tarifa;

--6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?
SELECT * FROM ASIGNACION;
SELECT * FROM TRABAJADOR;

SELECT
    SUM(num_dias)
FROM asignacion
WHERE id_e=312 AND id_t IN (
    SELECT 
        id_t
    FROM trabajador
    WHERE LOWER(oficio)='fontanero'); --Me da 27 en vez de 15....

--7. ¿Cuántos tipos de oficios diferentes hay?
SELECT * FROM TRABAJADOR;

SELECT
    COUNT(DISTINCT oficio)
FROM trabajador;

--8. Para cada supervisor, ¿Cuál es la tarifa por hora más alta que se paga a un trabajador
--que informa a ese supervisor?
SELECT * FROM TRABAJADOR;

SELECT
    t.id_supv,
    MAX(t.tarifa)
FROM trabajador t JOIN trabajador s ON t.id_supv = s.id_t
GROUP BY t.id_supv;

--Si queremos el nombre:
SELECT
    t.id_supv,
    s.nombre AS "Nombre Supervisor",
    MAX(t.tarifa)
FROM trabajador t JOIN trabajador s ON t.id_supv = s.id_t
GROUP BY t.id_supv,s.nombre;

--9. Para cada supervisor que supervisa a más de un trabajador, ¿cuál es la tarifa más alta
--que se paga a un trabajador que informa a ese supervisor?
SELECT * FROM TRABAJADOR;

SELECT
    id_supv,
    MAX(tarifa)
FROM trabajador
GROUP BY id_supv
HAVING COUNT(*) > 1;

--10. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con
--categoría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
--máximo no mayor que 3.
SELECT * FROM EDIFICIO;

/*SELECT
    tipo,
    ROUND(AVG(nivel_calidad))
FROM edificio
WHERE categoria = 1 AND nivel_calidad < 3
GROUP BY tipo;*/

SELECT
    tipo,
    ROUND(AVG(nivel_calidad))
FROM edificio
WHERE categoria = 1
GROUP BY tipo
HAVING MAX(nivel_calidad) <= 3;

--11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?
SELECT * FROM TRABAJADOR;

SELECT 
    *
FROM trabajador
WHERE tarifa < (
    SELECT 
        AVG(tarifa)
    FROM trabajador);

--12. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
--trabajadores que tienen su mismo oficio?
SELECT * FROM TRABAJADOR;

SELECT 
    *
FROM trabajador t1
WHERE tarifa < (
    SELECT 
        AVG(tarifa)
    FROM trabajador t2
    WHERE t1.oficio = t2.oficio);

--13. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
--trabajadores que dependen del mismo supervisor que él?
SELECT * FROM TRABAJADOR;

SELECT 
    *
FROM trabajador t1
WHERE tarifa < (
    SELECT 
        AVG(tarifa)
    FROM trabajador t2
    WHERE t1.id_supv = t2.id_supv);

--14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
--empezaron a trabajar en él.
SELECT * FROM TRABAJADOR;
SELECT * FROM ASIGNACION;

SELECT
    t.nombre,
    a.fecha_inicio
FROM trabajador t JOIN asignacion a ON t.id_t = a.id_t
WHERE LOWER(t.oficio) = 'electricista' AND a.id_e = 435;

--15. ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de
--los 12 euros?
SELECT * FROM TRABAJADOR;

SELECT
    DISTINCT s.nombre
FROM trabajador t JOIN trabajador s ON t.id_supv = s.id_t
WHERE t.tarifa > 12;

