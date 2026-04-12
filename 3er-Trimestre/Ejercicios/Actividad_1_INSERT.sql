-- EJERCICIOS INSERT  
--1.- Insertar los siguientes empleados: 
SELECT * FROM EMPLEADOS;

--701
INSERT INTO 
    empleados 
VALUES 
    (701,
    'PILAR GALLEGO RIVAS',
    TO_DATE('10-10-1968','dd-mm-yyyy'),
    12,
    'Directora Comercial',
    TO_DATE('01-05-1997','dd-mm-yyyy'),
    100,
    999888777,
    100000,
    150000);

SELECT * FROM empleados WHERE idempleado = 701;

--702
INSERT INTO 
    empleados 
        (idempleado, 
        nombre, 
        idoficina, 
        puesto, 
        fcontrato, 
        jefe, 
        movil) 
VALUES 
    (702,
    'ROSA MAR OCEANO',
    12,
    'Directora Area',
    SYSDATE,
    104,
    888777999);

SELECT * FROM empleados WHERE idempleado = 702;

--703
INSERT INTO
    empleados
        (idempleado,
        nombre,
        idoficina)
VALUES 
    (703,
    'SUSANA DIAZ ROMERO',
    12);
    
SELECT * FROM empleados WHERE idempleado = 703;

--704
INSERT INTO 
    empleados
        (idempleado,
        nombre,
        idoficina,
        puesto,
        fcontrato,
        jefe,
        movil,
        cuota)
VALUES
    (704,
    'MARTIN GOMEZ ACEBO',
    (SELECT idoficina FROM empleados WHERE LOWER(nombre) LIKE '%bego a marquez sevilla%'),
    (SELECT puesto FROM empleados WHERE LOWER(nombre) LIKE '%pablo rivas%'),
    SYSDATE-1,
    (SELECT director FROM oficinas WHERE idoficina = 21),
    666777888,
    (SELECT MIN(cuota) FROM empleados WHERE idoficina=21));

DELETE FROM empleados
WHERE idempleado = 704;

SELECT * FROM empleados WHERE idempleado = 704;

--2.- Insertar en la tabla de clientes, solamente los campos idempleado, nombre y fecha de alta los empleados de la oficina 21. De estos empleados 
--se tomarán los datos idempleado, nombre y fecha de alta. 
SELECT * FROM EMPLEADOS WHERE IDOFICINA = 21;
SELECT * FROM CLIENTES;

INSERT INTO
    clientes
        (idcliente,
        nombre,
        falta)
SELECT
    idempleado,
    nombre,
    fcontrato
FROM 
    empleados 
WHERE 
    idoficina = 21;

--3.- Insertar un cliente con identificativo 9130, con nombre Juan Iglesias Jurado, con fecha de alta para dentro de una semana, el representante 
--será el idempleado del primer comercial que fue contratado en la empresa.
SELECT * FROM CLIENTES;
SELECT * FROM EMPLEADOS;

INSERT INTO
    clientes
        (idcliente,
        nombre,
        falta,
        representante)
VALUES
    (9130,
    'JUAN IGLESIAS JURADO',
    SYSDATE+7,
    (SELECT idempleado
     FROM empleados
     WHERE fcontrato =(
         SELECT MIN(fcontrato)
         FROM empleados
         WHERE LOWER(puesto) = 'comercial')));
   
SELECT * FROM CLIENTES WHERE IDCLIENTE = 9130; 
