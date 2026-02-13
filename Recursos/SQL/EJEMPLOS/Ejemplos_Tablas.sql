--Primer ejemplo TABLA P_EMPLEADOS (SOLO CAMPOS)

CREATE TABLE P_Empleados(
    idEmpleado NUMBER(5),
    nombre VARCHAR2(25),
    direccion VARCHAR2(40),
    CPostal CHAR(5),
    Poblacion VARCHAR2(15),
    Provincia VARCHAR2(30),
    FNacimiento DATE,
    FContrato DATE,
    Jefe NUMBER(5)
);
DESC P_Empleados;

CREATE TABLE P_Empleados_2(
    idEmpleado NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(25) NOT NULL UNIQUE,
    direccion VARCHAR2(40),
    CPostal CHAR(5) CHECK (Cpostal LIKE '48%'),
    Poblacion VARCHAR2(15),
    Provincia VARCHAR2(30) CHECK (LOWER(Provincia) IN ('bizkaia','gipuzkoa','araba')),
    FNacimiento DATE ,
    FContrato DATE,
    Jefe NUMBER(5) REFERENCES P_EMPLEADOS_2(idempleado)
);
--Ver campos de P_EMPLEADOS_2
DESC P_Empleados_2;
--Ver las restricciones de la tabla P_Empleados_2
SELECT * FROM USER_CONSTRAINTS WHERE lower(table_name)='p_empleados_2';


--Pongo nombres a las restricciones en P_EMPLEADOS_3
CREATE TABLE P_Empleados_3(
    IdEmpleado NUMBER(5) CONSTRAINT PK_P_EMPLEADOS_3 PRIMARY KEY,
    Nombre VARCHAR2(25) CONSTRAINT NN_NOMBRE NOT NULL CONSTRAINT U_NOMBRE UNIQUE,
    Direccion VARCHAR2(40) ,
    CPostal CHAR(5) CONSTRAINT CK_CPOSTAL CHECK (CPostal LIKE '48%'),
    Poblacion VARCHAR2(15),
    Provincia VARCHAR2(30) CONSTRAINT CK_PROVINCIA CHECK (LOWER (Provincia) IN ('vizcaya', 'guipuzcoa', 'alava')),
    FNacimiento DATE,
    FContrato DATE,
    Jefe NUMBER(5) CONSTRAINT FK_EMPLEADOS_JEFE REFERENCES P_Empleados_2(IdEmpleado)
);
--Ver campos de P_EMPLEADOS_3
DESC P_Empleados_3;
--Ver las restricciones de la tabla P_Empleados_2
SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)='p_empleados_3';

--Elimino la restricción de Primary key del campo idEmpleado
ALTER TABLE P_EMPLEADOS_3 DROP CONSTRAINT PK_P_EMPLEADOS_3;
--Añado la restricción de Primary key al campo idEmpleado
ALTER TABLE P_EMPLEADOS_3 ADD CONSTRAINT PK_P_EMPLEADOS_3 PRIMARY KEY(idEmpleado);

--Mostrar los campos sobre los que están aplicadas las restricciones (Vista USER_CONS_COLUMNS)
SELECT * FROM USER_CONS_COLUMNS WHERE LOWER(TABLE_NAME)='p_empleados_3';

--CREACIÓN TABLA P_OFICINA
CREATE TABLE P_Oficinas(
    Oficina NUMBER(2) CONSTRAINT PK_P_OFICINAS PRIMARY KEY,
    Ciudad VARCHAR2(15),
    Region VARCHAR2(10) CONSTRAINT CK_REGION CHECK(LOWER(Region) IN ('norte', 'centro', 'sur', 'este', 'oeste')),
    Dir NUMBER(3),
    Objetivo NUMBER(10),
    Ventas NUMBER(10)
);

--Inserto algunos datos en la tabla P_OFICINAS
INSERT INTO P_Oficinas VALUES (10, 'Basauri', 'norte', 101, 100000, 150000);
INSERT INTO P_Oficinas VALUES (11, 'Basauri', 'norte', null, null, 150000);
INSERT INTO P_Oficinas VALUES (12, 'Basauri', 'NORTE', null, null, 150000);
SELECT * FROM P_OFICINAS;
DESC P_Oficinas;
--Mostramos restricciones de la tabla P_OFICINAS
SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)='p_oficinas';

--Mostramos campos sobre los que están aplicadas las restricciones de la tabla P_OFICINAS
SELECT * FROM USER_CONS_COLUMNS WHERE LOWER(TABLE_NAME)='p_oficinas';

--RESTRICCIÓN TIPO 2 (Al final de la tabla)
CREATE TABLE P_Productos(
    IdFab CHAR(3),
    IdProducto CHAR(5),
    Descripcion VARCHAR2(20),
    Precio NUMBER(4),
    Existencias NUMBER(3),
    CONSTRAINT PK_P_PRODUCTOS PRIMARY KEY (Idfab, IdProducto),
    CONSTRAINT U_DESCRIPCION UNIQUE(descripcion),
    CONSTRAINT CKPrecio CHECK (precio>0)
);

--Eliminar tabla P_PRODUCTOS (porque ya estaba creada y vamos a introducir alguna restricción más)
DROP TABLE P_PRODUCTOS;

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME)='p_productos';
SELECT * FROM USER_CONS_COLUMNS WHERE LOWER(TABLE_NAME)='p_productos';

--TIPOS DE RESTRICCIONES (PALABRAS RESERVADAS)
--PRIMARY KEY : Clave Principal
--NOT NULL : Campos Requeridos
--UNIQUE : Índices Únicos
--CHECK : Condiciones a los Campos
--REFERENCES : Clave Extranjera

--RESTRICCIONES DE TIPO 1
--Esas 5 restricciones se colocan justo detrás del campo al que afectan.

--RESTRICCIONES DE TIPO 2
/*Se colocan justo detrás de todos los campos (Como si fuese uotro campo mas)
y aparte de las palabras reservadas hay que colocar sobre que campo o campos afecta esa
restricción.*/

/* Generalmente es mejor poner nombres a las restricciones para poder
eliminarlas o modificarlas cuando sea necesario. Eso se hace escribiendo :
CONSTRAINT Nombre_restricción Palabras Reservadas.

NOTA: Un nombre de restricción no se pueden repetir en todo el esquema*/

--TIPOS DE RESTRICCIONES (Palabras reservadas)
--PRIMARY KEY : Clave Principal
--NOT NULL: Campos requeridos
--UNIQUE: Índices Únicos
--CHECK: Condiciones a los campos
--REFERENCES: Clave Extranjera

--RESTRICCIONES  TIPO 1
--Esas 5 restricciones se colocan justo detras del campo al que afectan

--RESTRICCIONES DE TIPO 2
/*Se colocan justo detras de todos los campos (como si fuese otro campos),
y a parte de las pàlabras reservadas hay que colocar sobre qué campo/s afecta esa restricción  */

/*GEneralmente es mejor poner nombres a las restricciones para poder 
eliminarlas o modificarlas cuando sea necesario. Eso se hace escribiendo:

constraint NOMBRe_RESTRICCIÓN palabras reservadas


NOTA: Un nombre de restricción no se puede repetir en todo el esquema*/


