-- TABLA DE LIBROS
CREATE TABLE Libros(
    libroID CHAR(5) CONSTRAINT PK_LIBROS PRIMARY KEY,
    titulo VARCHAR2(20) CONSTRAINT NN_TITULO NOT NULL CONSTRAINT U_TITULO UNIQUE,
    tipo VARCHAR2(10) CONSTRAINT CK_TIPO CHECK (LOWER(tipo)IN('novela', 'terror', 'misterio')),
    editor VARCHAR2(25),
    fechaEdicion DATE
);

DESC Libros;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS WHERE LOWER(TABLE_NAME)='libros';

-- TABLA DE AUTORES
CREATE TABLE Autores(
    autorID CHAR(4) CONSTRAINT PK_AUTORES PRIMARY KEY,
    autorNombre VARCHAR2(25) CONSTRAINT NN_AUTORNOMBRE NOT NULL,
    telefono CHAR(9) CONSTRAINT CK_TELEFONO CHECK(telefono LIKE '94%'),
    direccion VARCHAR2(50),
    poblacion VARCHAR2(30),
    provincia VARCHAR2(25) CONSTRAINT CK_PROVINCIA_AUTORES CHECK(LOWER(provincia) IN ('bizkaia','gipuzkoa','araba'))
);

DESC Autores;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS WHERE LOWER(TABLE_NAME)='autores';
SELECT * FROM USER_CONSTRAINTS WHERE LOWER (TABLE_NAME)='autores';

-- TABLA AUTORES LIBROS
/*
-- TIPO 1 ====================================
CREATE TABLE Autor_Libro(
    libroID CHAR(5) CONSTRAINT FK_AUTOR_LIBRO_LIBROS REFERENCES Libros(libroID),
    autorID CHAR(4)CONSTRAINT FK_AUTOR_LIBRO_AUTORES REFERENCES Autores(autorID),
    CONSTRAINT PK_AURO_LIBRO PRIMARY KEY (libroID, autorID)
);
*/
-- TIPO 2 ====================================
CREATE TABLE Autor_Libro(
    libroID CHAR(5),
    autorID CHAR(4),
    CONSTRAINT PK_AUTOR_LIBRO PRIMARY KEY (libroID, autorID),
    CONSTRAINT FK_AUTOR_LIBRO_LIBROS FOREIGN KEY (libroID) REFERENCES Libros(libroID),
    CONSTRAINT FK_AUTOR_LIBRO_AUTORES FOREIGN KEY (autorID) REFERENCES Autores(autorID)
);

-- INTRODUCIENDO DATOS
INSERT INTO Libros VALUES('00001', 'Programacion JAVA', 'misterio', 'Paraninfo', '10-10-2007');
INSERT INTO Libros VALUES('00002', 'Baseiiiiiiiiiiiii de Datos ORACLE', 'terror', 'Paraninfo', '10-12-2005');

INSERT INTO Autores VALUES('0001', 'Iñigo', '944163195', 'Calle Esperanza 12', 'Bilbao', 'Bizkaia');
INSERT INTO Autores VALUES('0002', 'Marta', '944163195', 'Calle Esperanza 12', 'Bilbao', 'Bizkaia');

SELECT * FROM Libros;
SELECT * FROM Autores;

INSERT INTO Autor_Libro VALUES('00001', '0001');
INSERT INTO Autor_Libro VALUES('00002', '0002');
INSERT INTO Autor_Libro VALUES('00002', '0001');

SELECT titulo,tipo,fechaedicion FROM LIBROS WHERE LOWER(titulo) LIKE '% java%';
SELECT titulo,tipo,fechaedicion 
    FROM LIBROS
    WHERE LOWER(editor)='paraninfo'
    ORDER BY titulo DESC;
    
SELECT autorNombre,titulo 
    FROM Autores a,Libros l,Autor_Libro al
    WHERE a.autorID=al.autorID AND l.libroID=al.libroID;

SELECT autorNombre FROM Autores WHERE autorID IN 
    (SELECT autorID FROM Autor_Libro WHERE libroID IN
        (SELECT libroID FROM Libros WHERE LOWER(titulo) LIKE '%datos%'));


COMMIT;