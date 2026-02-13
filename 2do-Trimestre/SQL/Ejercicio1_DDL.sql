--1
DROP TABLE P_Oficinas CASCADE CONSTRAINTS;
CREATE TABLE P_Oficinas(
    oficina NUMBER(2) CONSTRAINT PK_P_Oficinas PRIMARY KEY,
    ciudad VARCHAR2(15),
    region VARCHAR2(10) CONSTRAINT CK_Region CHECK(LOWER(region) IN ('norte', 'centro', 'sur', 'este', 'oeste') ),
    dir NUMBER(3),
    objetivo NUMBER(10),
    ventas NUMBER(10)
);

DROP TABLE P_Empleados CASCADE CONSTRAINTS;
CREATE TABLE P_Empleados(
    numEmp NUMBER(3) CONSTRAINT PK_P_Empleados PRIMARY KEY,
    nombre VARCHAR2(20) CONSTRAINT NN_Nombre_Emp NOT NULL CONSTRAINT U_Nombre_Emp UNIQUE,
    edad NUMBER(2),
    oficina NUMBER(2) CONSTRAINT FK_Oficina_Emp REFERENCES P_Oficinas(oficina), -- Restricción Tipo 1
    titulo VARCHAR2(25),
    contrato DATE,
    jefe NUMBER(3),
    cuota NUMBER(10),
    ventas NUMBER(10),
    -- Restricción Tipo 2
    CONSTRAINT CK_Edad_Emp CHECK(edad BETWEEN 18 AND 65) -- (edad>=18 AND edad<=65)
);

DROP TABLE P_Clientes CASCADE CONSTRAINTS;
CREATE TABLE P_Clientes(
    numCliente NUMBER(4) CONSTRAINT PK_P_Clientes PRIMARY KEY,
    nombre VARCHAR2(25) CONSTRAINT NN_Nombre_Cliente NOT NULL CONSTRAINT U_Nombre_Cliente UNIQUE, 
    representanteCliente NUMBER(3) CONSTRAINT FK_Cliente_Empleado REFERENCES P_Empleados(numEmp),
    limiteCredito NUMBER(9) DEFAULT 20000
);
DROP TABLE P_Productos CASCADE CONSTRAINTS;
CREATE TABLE P_Productos(
    idFabricante CHAR(3),
    idProducto CHAR(5),
    descripcion VARCHAR2(20) CONSTRAINT NN_Descripcion_Producto NOT NULL,
    precio NUMBER(4) CONSTRAINT CK_Precio_Producto CHECK(precio > 0),
    existencias NUMBER(3),
    CONSTRAINT PK_P_Productos PRIMARY KEY(idFabricante, idProducto)
);

DROP TABLE P_Pedidos CASCADE CONSTRAINTS;
CREATE TABLE P_Pedidos(
    codigo NUMBER(3) CONSTRAINT PK_P_Pedidos PRIMARY KEY,
    numPedido NUMBER(6),
    fechaPedido DATE,
    cliente NUMBER(4) CONSTRAINT FK_Pedido_Cliente REFERENCES P_Clientes(numCliente),
    representante NUMBER(3) CONSTRAINT FK_Pedido_Empleado REFERENCES P_Empleados(numEmp),
    fabricante CHAR(3),
    producto CHAR(5),
    cantidad NUMBER(2)CONSTRAINT CK_Cantidad_Pedido CHECK(cantidad > 0),
    importe NUMBER(10),
    CONSTRAINT FK_Pedido_Producto FOREIGN KEY (fabricante, producto) REFERENCES P_Productos(idFabricante, idProducto)
);

--2
ALTER TABLE P_Clientes ADD(mail VARCHAR2(20) CONSTRAINT CK_Mail CHECK(mail LIKE '%@%'), movil CHAR(9) CONSTRAINT NN_Movil NOT NULL);

--3
ALTER TABLE P_Pedidos DROP CONSTRAINT PK_P_Pedidos;

--4
ALTER TABLE P_Pedidos ADD CONSTRAINT PK_P_Pedidos PRIMARY KEY(numPedido);

--5
ALTER TABLE P_Empleados MODIFY(cuota NUMBER(10,2), ventas NUMBER(10,2));

--6
ALTER TABLE P_Empleados DROP CONSTRAINT FK_Empleados_Jefe;
ALTER TABLE P_Empleados ADD CONSTRAINT FK_Empleados_Jefe FOREIGN KEY(jefe) REFERENCES P_Empleados(numEmp);

SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS WHERE LOWER(table_name) IN ('p_empleados_2','p_empleados_3');

--7
INSERT INTO P_OFICINAS VALUES (11, 'MADRID', 'CENTRO', 100, 100000, 150000);
INSERT INTO P_EMPLEADOS	VALUES (100, 'ALEX CAMPOS', 27, 11, 'dir general', '10/10/2007', 110, 10000, 15000);
SELECT * FROM P_EMPLEADOS;
INSERT INTO P_EMPLEADOS	VALUES (100, 'ALEX CAMPOS', 27, 11, 'dir general', '10/10/2007', 100, 10000, 15000);
SELECT * FROM P_EMPLEADOS;

--8
ALTER TABLE P_Empleados DISABLE CONSTRAINT FK_Empleados_Jefe;

--9
INSERT INTO P_EMPLEADOS	VALUES (101, 'MARIA	LOMAS', 35,	11, 'dir ventas' , '12/01/2009', 110, 10000, 15000);

--10
ALTER TABLE P_Empleados ENABLE CONSTRAINT FK_Empleados_Jefe;
--No deja porque hay campos que no están creados.

--11
DELETE FROM P_EMPLEADOS WHERE numemp=101;

--12
ALTER TABLE P_Empleados ENABLE CONSTRAINT FK_Empleados_Jefe;

--13
ALTER TABLE P_Oficinas ADD CONSTRAINT FK_Director_Oficina FOREIGN KEY(dir) REFERENCES P_Empleados ON DELETE CASCADE;

--14
SELECT * FROM USER_CONTRAINTS WHERE LOWER(TABLE_NAME)='p_oficinas' OR LOWER(TABLE_NAME)='p_empleados';
--SELECT * FROM USER_CONTRAINTS WHERE LOWER(TABLE_NAME) IN ('p_oficinas', 'p_empleados'); // MÁS LEGIBLE Y CÓMODA

--15
ALTER TABLE P_Empleados DROP CONSTRAINT FK_Empleados_Jefe;

--16
DROP TABLE P_Productos CASCADE CONSTRAINTS;   
DROP TABLE P_Clientes CASCADE CONSTRAINTS;
DROP TABLE P_Oficinas CASCADE CONSTRAINTS;
DROP TABLE P_Empleados CASCADE CONSTRAINTS;
DROP TABLE P_Pedidos CASCADE CONSTRAINTS;

--17
START D:\PEDIDOS.sql;

--18
INSERT INTO P_Oficinas VALUES (90, 'Bilbao', 'Norte', 110, 100000, 175000);

--19


--20


--21


--22


--23


--24


--25


--26


--27


--28


--29


--30


--31


--32


--33


--34


--35


--36


--37


--38


--39


--40


--41






