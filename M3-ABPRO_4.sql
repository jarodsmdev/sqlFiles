/*M3-ABPRO_4*/

/*CREAR BD*/

CREATE DATABASE ABPRO_4_PREV_RIESGOS;

/*USAR BD*/

USE ABPRO_4_PREV_RIESGOS;

/*CREAR TABLA CAPACITACION*/

CREATE TABLE CAPACITACION(
	idCapacitacion INT NOT NULL PRIMARY KEY,
    rutCliente VARCHAR(15) NOT NULL,
    dia VARCHAR(25) NULL,
    hora VARCHAR(5) NULL,
    lugar VARCHAR(50) NOT NULL,
    duracion INT NOT NULL,
    cantidadAsistentes INT NULL
);

/* TABLA CAPACITACION
+--------------------+-------------+------+-----+---------+-------+
| Field              | Type        | Null | Key | Default | Extra |
+--------------------+-------------+------+-----+---------+-------+
| idCapacitacion     | int         | NO   | PRI | NULL    |       |
| rutCliente         | varchar(15) | NO   |     | NULL    |       |
| dia                | varchar(25) | YES  |     | NULL    |       |
| hora               | varchar(5)  | YES  |     | NULL    |       |
| lugar              | varchar(50) | NO   |     | NULL    |       |
| duracion           | int         | NO   |     | NULL    |       |
| cantidadAsistentes | int         | YES  |     | NULL    |       |
+--------------------+-------------+------+-----+---------+-------+
7 rows in set (0,00 sec)

*/

/*CREAR TABLA ASISTENTES*/

CREATE TABLE ASISTENTES(
	idAsistente INT NOT NULL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    capacitacion_idCapacitacion INT NOT NULL
);
/* TABLA ASISTENTES
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

/*CREAR LLAVE FORÁNEA ENTRE ASISTENTES CON CAPACITACION*/

ALTER TABLE ASISTENTES
ADD CONSTRAINT Asistentes_capacitacion_FK 
FOREIGN KEY (capacitacion_idCapacitacion) REFERENCES CAPACITACION(idCapacitacion);

/*
| ASISTENTES | CREATE TABLE `ASISTENTES` (
  `idAsistente` int NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `edad` int NOT NULL,
  `capacitacion_idCapacitacion` int NOT NULL,
  PRIMARY KEY (`idAsistente`),
  KEY `Asistentes_capacitacion_FK` (`capacitacion_idCapacitacion`),
  CONSTRAINT `Asistentes_capacitacion_FK` FOREIGN KEY (`capacitacion_idCapacitacion`) REFERENCES `CAPACITACION` (`idCapacitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
*/

/*ACTIVIDADES*/
/**Estas sentencias se deben ejecutar como una sola**/
/*1.- Genere una consulta que permita insertar un registro en la tabla de capacitaciones, indicando solo los campos que son obligatorios a la consulta.*/

START TRANSACTION;

SET autocommit = 0;

INSERT INTO CAPACITACION
(idCapacitacion, rutCliente, lugar, duracion)
VALUES
('11', '189273845', 'Olmué', 60);

/*2.- Incluya una sentencia que confirme los cambios incorporados en la sentencia anterior.*/

COMMIT;
SELECT * FROM CAPACITACION; 

/*3.- Agregue una consulta o instrucción que habilite el auto guardado de instrucciones para un total de dos sentencias.*/

SET autocommit = 1;

/*4.- Agregue dos consultas para insertar un registro en la tabla de asistentes en cada una. Incluya en la consulta todos los campos de la tabla en orden descendente respecto de cómo aparece en la definición de la tabla. Asocie estos registros a la capacitación creada en el ítem 1 de este ejercicio.*/

INSERT INTO ASISTENTES
(capacitacion_IdCapacitacion, edad, nombres, idAsistente)
VALUES
('11','56','Paul Vasquez','11'),
('11','45','Bronko Yotte','12')
;

SET autocommit = 0;

/*5.- Genere una consulta de actualización del registro insertado en la tabla de capacitaciones,
que permita darles valores a los campos que no fueron considerados en la consulta original*/

UPDATE CAPACITACION
SET dia = 'Lunes', hora = '16:30', cantidadAsistentes=50
WHERE idCapacitacion = 11;

SELECT * FROM CAPACITACION;

/*6.- Genere una consulta que permita eliminar los asistentes anteriormente ingresados, pero en
una sola consulta.*/

DELETE FROM ASISTENTES WHERE idAsistente IN (11, 12);

SELECT * FROM ASISTENTES;

/*7.- Agregue una consulta para deshacer los cambios realizados.*/
ROLLBACK;
SELECT * FROM ASISTENTES;
SELECT * FROM CAPACITACION;