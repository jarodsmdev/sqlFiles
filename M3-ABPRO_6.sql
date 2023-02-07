/*M3-APBRO_6*/

/*CREAR DATABASE APBRO_6_PREV_RIESGOS*/
CREATE DATABASE ABPRO_6_PREV_RIESGOS;

/*USAR TABLA ABPRO_6_PREV_RIESGOS*/
USE ABPRO_6_PREV_RIESGOS;

/*CREAR TABLA Cliente*/
CREATE TABLE Cliente(
	rutCliente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    afp VARCHAR(30) NULL,
    sistemaSalud VARCHAR(2) NULL,
    direccion VARCHAR(70) NULL,
    comuna VARCHAR(50) NULL,
    edad INT(3) NOT NULL
);

/*CREAR TABLA Accidente*/
CREATE TABLE Accidente(
	accidenteId INT(9) NOT NULL PRIMARY KEY,
    dia DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    origen VARCHAR(100) NULL,
    consecuencias VARCHAR(100) NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE ACCIDENTE Y CLIENTE*/
ALTER TABLE Accidente
ADD CONSTRAINT accidente_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);


/*CREAR TABLA Capacitacion*/
CREATE TABLE Capacitacion(
	idCapacitacion INT(9) NOT NULL PRIMARY KEY,
    fecha DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    duracion INT(3) NULL,
    cantidadAsistentes INT(5) NOT NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE CAPACITACION Y CLIENTE*/
ALTER TABLE Capacitacion
ADD CONSTRAINT capacitacion_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);

/*CREAR TABLA Asistentes*/
CREATE TABLE Asistentes(
	idAsistente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    edad INT(3) NOT NULL,
    capacitacion_idCapacitacion INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE ASISTENTES Y CAPACITACION*/
ALTER TABLE Asistentes
ADD CONSTRAINT asistentes_capacitacion_FK
FOREIGN KEY (capacitacion_idCapacitacion) REFERENCES Capacitacion(idCapacitacion);

/*ACTIVIDAD*/
/*Se solicita que desarrolle un conjunto de sentencias SQL que permita pasar desde el modelo de datos original al modelo de datos actualizado, utilizando las consultas vistas en la clase. No es necesario que sea solo una consulta, lo puede hacer en base a una transacción que tenga un inicio y fin determinados, con consultas independientes, pero que forman parte de un conjunto mayor de instrucciones.
*/
START TRANSACTION;
SET autocommit = 0;
/*MODIFICAR TABLA Cliente*/
/*TABLA Cliente:
+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| rutCliente   | int         | NO   | PRI | NULL    |       |
| nombres      | varchar(30) | NO   |     | NULL    |       |
| apellidos    | varchar(30) | NO   |     | NULL    |       |
| telefono     | varchar(20) | NO   |     | NULL    |       |
| afp          | varchar(30) | YES  |     | NULL    |       |
| sistemaSalud | varchar(2)  | YES  |     | NULL    |       |
| direccion    | varchar(70) | YES  |     | NULL    |       |
| comuna       | varchar(50) | YES  |     | NULL    |       |
| edad         | int         | NO   |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
9 rows in set (0,00 sec)
*/
ALTER TABLE Cliente
RENAME COLUMN nombres TO cliNombres,
CHANGE COLUMN apellidos cliApellidos VARCHAR(50) NOT NULL,
RENAME COLUMN telefono TO cliTelefono,
RENAME COLUMN afp TO cliAfp,
RENAME COLUMN sistemaSalud TO cliSistemaSalud,
CHANGE COLUMN direccion cliDireccion VARCHAR(100) NOT NULL,
CHANGE COLUMN comuna cliComuna VARCHAR(50) NOT NULL,
CHANGE COLUMN edad cliEdad INT(3) NOT NULL;

/* TABLA Cliente:
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| rutCliente      | int          | NO   | PRI | NULL    |       |
| cliNombres      | varchar(30)  | NO   |     | NULL    |       |
| cliApellidos    | varchar(50)  | NO   |     | NULL    |       |
| cliTelefono     | varchar(20)  | NO   |     | NULL    |       |
| cliAfp          | varchar(30)  | YES  |     | NULL    |       |
| cliSistemaSalud | varchar(2)   | YES  |     | NULL    |       |
| cliDireccion    | varchar(100) | NO   |     | NULL    |       |
| cliComuna       | varchar(50)  | NO   |     | NULL    |       |
| cliEdad         | int          | NO   |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
9 rows in set (0,00 sec)
*/

/*MODIFICAR TABLA Capacitacion*/
/*TABLA Capacitacion:
+--------------------+-------------+------+-----+---------+-------+
| Field              | Type        | Null | Key | Default | Extra |
+--------------------+-------------+------+-----+---------+-------+
| idCapacitacion     | int         | NO   | PRI | NULL    |       |
| fecha              | date        | YES  |     | NULL    |       |
| hora               | time        | YES  |     | NULL    |       |
| lugar              | varchar(50) | NO   |     | NULL    |       |
| duracion           | int         | YES  |     | NULL    |       |
| cantidadAsistentes | int         | NO   |     | NULL    |       |
| cliente_rutCliente | int         | NO   | MUL | NULL    |       |
+--------------------+-------------+------+-----+---------+-------+
7 rows in set (0,00 sec)
*/
ALTER TABLE Capacitacion
RENAME COLUMN fecha TO capFecha,
RENAME COLUMN hora TO capHora,
CHANGE COLUMN lugar capLugar VARCHAR(100) NOT NULL,
CHANGE COLUMN duracion capDuracion INT(4) NULL,
DROP COLUMN cantidadAsistentes;
;

/* TABLA Capacitacion:
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| idCapacitacion     | int          | NO   | PRI | NULL    |       |
| capFecha           | date         | YES  |     | NULL    |       |
| capHora            | time         | YES  |     | NULL    |       |
| capLugar           | varchar(100) | NO   |     | NULL    |       |
| capDuracion        | int          | YES  |     | NULL    |       |
| cliente_rutCliente | int          | NO   | MUL | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+
6 rows in set (0,00 sec)
*/

/*MODIFICAR TABLA Asistentes*/
/* TABLA Asistentes:
+-----------------------------+--------------+------+-----+---------+-------+
| Field                       | Type         | Null | Key | Default | Extra |
+-----------------------------+--------------+------+-----+---------+-------+
| idAsistente                 | int          | NO   | PRI | NULL    |       |
| nombres                     | varchar(100) | NO   |     | NULL    |       |
| edad                        | int          | NO   |     | NULL    |       |
| capacitacion_idCapacitacion | int          | NO   | MUL | NULL    |       |
+-----------------------------+--------------+------+-----+---------+-------+
4 rows in set (0,00 sec)
*/
ALTER TABLE Asistentes
CHANGE COLUMN nombres asisNombreCompleto VARCHAR(100) NOT NULL,
CHANGE COLUMN edad asisEdad INT(3) NOT NULL,
ADD COLUMN asisCorreo VARCHAR(70) NULL,
ADD COLUMN asisTelefono VARCHAR(20) NULL;

/* TABLA Asistentes:
+-----------------------------+--------------+------+-----+---------+-------+
| Field                       | Type         | Null | Key | Default | Extra |
+-----------------------------+--------------+------+-----+---------+-------+
| idAsistente                 | int          | NO   | PRI | NULL    |       |
| asisNombreCompleto          | varchar(100) | NO   |     | NULL    |       |
| asisEdad                    | int          | NO   |     | NULL    |       |
| capacitacion_idCapacitacion | int          | NO   | MUL | NULL    |       |
| asisCorreo                  | varchar(70)  | YES  |     | NULL    |       |
| asisTelefono                | varchar(20)  | YES  |     | NULL    |       |
+-----------------------------+--------------+------+-----+---------+-------+
6 rows in set (0,00 sec)
*/

/*MODIFICAR TABLA Accidente*/
/* TABLA Accidente:
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| accidenteId        | int          | NO   | PRI | NULL    |       |
| dia                | date         | YES  |     | NULL    |       |
| hora               | time         | YES  |     | NULL    |       |
| lugar              | varchar(50)  | NO   |     | NULL    |       |
| origen             | varchar(100) | YES  |     | NULL    |       |
| consecuencias      | varchar(100) | YES  |     | NULL    |       |
| cliente_rutCliente | int          | NO   | MUL | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+
7 rows in set (0,00 sec)
*/
ALTER TABLE Accidente
RENAME COLUMN accidenteId TO idAccidente,
RENAME COLUMN dia TO acciFecha,
CHANGE COLUMN hora acciHora TIME NOT NULL,
CHANGE COLUMN lugar acciLugar VARCHAR(150) NOT NULL,
CHANGE COLUMN origen acciOrigen VARCHAR(100) NOT NULL,
RENAME COLUMN consecuencias TO acciConsecuencias;
;

/*CREAR TABLA Visita*/
CREATE TABLE Visita(
	idVisita INT(9) NOT NULL PRIMARY KEY,
    visFecha DATE NOT NULL,
    visHora TIME NULL,
    visLugar VARCHAR(50) NOT NULL,
    visComentarios VARCHAR(250) NOT NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE VISITA Y CLIENTE*/
ALTER TABLE Visita
ADD CONSTRAINT visita_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);
COMMIT;
SET autocommit = 1;