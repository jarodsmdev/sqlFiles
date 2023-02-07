/* M3-ABPRO_5 */
CREATE DATABASE PREV_RIESGOS;
USE PREV_RIESGOS;

/*  ACTIVIDADES */
/*1.- Genere un set de consultas que permitan crear las tablas indicadas en el modelo. Tenga en
consideración las llaves primarias, los tipos de dato indicados y las condiciones de nulidad. */
CREATE TABLE Cliente(
	rutCliente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    afp VARCHAR(30) NULL,
    sistemaSalud INT(2) NULL,
    direccion VARCHAR(70) NULL,
    comuna VARCHAR(50) NULL,
    edad INT(3) NOT NULL
);

/* Se dejará el campo hora de tipo TIME */
CREATE TABLE Capacitacion(
	idCapacitacion INT(9) NOT NULL PRIMARY KEY,
    fecha DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    duracion INT(5) NOT NULL,
    cantidadAsistentes INT(5) NOT NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/* Se dejará el campo hora de tipo TIME */
CREATE TABLE Accidente(
	accidenteId INT(9) NOT NULL PRIMARY KEY,
    dia DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    origen VARCHAR(100) NULL,
    consecuencias VARCHAR(100) NULL,
    cliente_rutCliente INT(9)
);

CREATE TABLE Asistentes(
	idAsistente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    edad INT(3) NOT NULL,
    capacitacion_idCapacitacion INT(9)
);


/*2.- Desarrolle consultas que permitan crear las llaves foráneas antes indicadas, respetando el
sentido lógico de su creación. */

/* Crear FK entre Capacitación y Cliente*/
ALTER TABLE Capacitacion
ADD CONSTRAINT Capacitacion_Cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);

/* Crear FK entre Accidente y Cliente */
ALTER TABLE Accidente
ADD CONSTRAINT Accidente_Cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);

/* Crear FK entre Asistentes y Capacitacion */
ALTER TABLE Asistentes
ADD CONSTRAINT Asistentes_Capacitacion_FK
FOREIGN KEY (capacitacion_idCapacitacion) REFERENCES Capacitacion(idCapacitacion);


/*3.- Genere una consulta que permita crear una restricción de valor único sobre el campo
“telefono” de la tabla Cliente. */
ALTER TABLE Cliente
CHANGE COLUMN telefono telefono VARCHAR(20) NOT NULL UNIQUE;

/*4.- Genere una consulta que permita restringir los valores posibles del campo sistemasalud de
la tabla Cliente al conjunto {1,2} */

/*OPCION A:*/
/*
ALTER TABLE Cliente
MODIFY COLUMN sistemaSalud ENUM('1','2') NOT NULL;
*/

/*OPCION B:*/
ALTER TABLE Cliente
ADD CONSTRAINT sistemaSalud CHECK(sistemaSalud IN (1,2));

/*5.- Genere las consultas para insertar cuatro registros en la tabla Cliente, y consultas para
insertar siete registros en la tabla Accidente, asociados a los clientes recién ingresados.*/
/* 4 Clientes */
INSERT INTO Cliente
(rutCliente, nombres, apellidos, telefono, afp, sistemaSalud, direccion, comuna, edad)
VALUES
(1, 'Jerrome', 'Terris', '639-647-8363', 'AFP A', 1, 'Suite 77', 'Kraljevo', 43),
(2, 'Wiatt', 'Hegges', '386-413-0226', 'AFP B' , 2, '4th Floor', 'Pinggang', 20),
(3, 'Mort', 'Berggren',	'890-104-4109',	'AFP C', 1,	'PO Box 22877',	'Yaojiaji',	21),
(4, 'Diena', 'Kacheler', '189-126-1209', 'AFP A', 2, 'Suite 71', 'Buluangan', 28)
;

/* SELECT * FROM Cliente:
+------------+---------+-----------+--------------+-------+--------------+--------------+-----------+------+
| rutCliente | nombres | apellidos | telefono     | afp   | sistemaSalud | direccion    | comuna    | edad |
+------------+---------+-----------+--------------+-------+--------------+--------------+-----------+------+
|          1 | Jerrome | Terris    | 639-647-8363 | AFP A |            1 | Suite 77     | Kraljevo  |   43 |
|          2 | Wiatt   | Hegges    | 386-413-0226 | AFP B |            2 | 4th Floor    | Pinggang  |   20 |
|          3 | Mort    | Berggren  | 890-104-4109 | AFP C |            1 | PO Box 22877 | Yaojiaji  |   21 |
|          4 | Diena   | Kacheler  | 189-126-1209 | AFP A |            2 | Suite 71     | Buluangan |   28 |
+------------+---------+-----------+--------------+-------+--------------+--------------+-----------+------+
4 rows in set (0,00 sec)
*/

/* 7 registros asociados a clientes anteriores */
INSERT INTO Accidente
(accidenteId, dia, hora, lugar, cliente_rutCliente, origen, consecuencias)
VALUES
(1, '2023/1/2', '09:00:00', 'Viña del Mar',4, 'Trayecto', 'Licencia 4 días'),
(2, '2023/12/3', '10:00:00', 'Con-Cón',4,'Trayecto', 'Licencia 5 días'),
(3, '2022/7/12', '09:30:00', 'Limache',4, 'Trayecto', 'Licencia 21 días'),
(4, '2023/4/25', '12:00:00', 'Quilpué',4, 'Trayecto','Licencia 90 días'),
(5, '2023/12/26', '13:00:00', 'Quillota',3, 'Trayecto','Licencia 7 días'),
(6, '2022/8/14', '08:30:00' ,'La Calera',2, 'Trayecto','Licencia 15 días'),
(7, '2022/7/15', '09:00:00','La Cruz',1, 'Trayecto','Licencia 12 días')
;

/* SELECT * FROM Accidente;
+-------------+------------+----------+---------------+----------+-------------------+--------------------+
| accidenteId | dia        | hora     | lugar         | origen   | consecuencias     | cliente_rutCliente |
+-------------+------------+----------+---------------+----------+-------------------+--------------------+
|           1 | 2023-01-02 | 09:00:00 | Viña del Mar  | Trayecto | Licencia 4 días   |                  4 |
|           2 | 2023-12-03 | 10:00:00 | Con-Cón       | Trayecto | Licencia 5 días   |                  4 |
|           3 | 2022-07-12 | 09:30:00 | Limache       | Trayecto | Licencia 21 días  |                  4 |
|           4 | 2023-04-25 | 12:00:00 | Quilpué       | Trayecto | Licencia 90 días  |                  4 |
|           5 | 2023-12-26 | 13:00:00 | Quillota      | Trayecto | Licencia 7 días   |                  3 |
|           6 | 2022-08-14 | 08:30:00 | La Calera     | Trayecto | Licencia 15 días  |                  2 |
|           7 | 2022-07-15 | 09:00:00 | La Cruz       | Trayecto | Licencia 12 días  |                  1 |
+-------------+------------+----------+---------------+----------+-------------------+--------------------+
7 rows in set (0,00 sec)
*/

/*Nota 1: Considere que las estructuras propuestas en los ejercicios anteriores de las tablas
Capacitacion y Asistente cambiaron, por tanto, las consultas que existían antes deben ser
modificadas.*/

/*Nota 2: En este ejercicio debe incluir el script completo, aunque se haya solicitado algo similar en
ejercicios anteriores.*/