/*USANDO COMO INSUMO LA BD CREADA EN EL EJERCICIO GRUPAL ANTERIOR, REALICE LAS SIGUIENTES OPERACIONES */

USE CAPACITACION2;

/* 1. Haga las consultas necesarias para convertir las llaves primarias de cada tabla en campos
autonuméricos */
ALTER TABLE ASISTENTES
CHANGE COLUMN id_asistente  id_asistente INT NOT NULL AUTO_INCREMENT
;

ALTER TABLE CAPACITACION
CHANGE COLUMN id_capacitacion id_capacitacion INT NOT NULL AUTO_INCREMENT
;

/*
TABLA ASISTENTES:
+------------------------------+--------------+------+-----+---------+----------------+
| Field                        | Type         | Null | Key | Default | Extra          |
+------------------------------+--------------+------+-----+---------+----------------+
| id_asistente                 | int          | NO   | PRI | NULL    | auto_increment |
| nombres                      | varchar(100) | NO   |     | NULL    |                |
| edad                         | int          | NO   |     | NULL    |                |
| capacitacion_id_capacitacion | int          | NO   | MUL | NULL    |                |
+------------------------------+--------------+------+-----+---------+----------------+
4 rows in set (0,00 sec)

TABLA CAPACITACION:
+---------------------+-------------+------+-----+---------+----------------+
| Field               | Type        | Null | Key | Default | Extra          |
+---------------------+-------------+------+-----+---------+----------------+
| id_capacitacion     | int         | NO   | PRI | NULL    | auto_increment |
| rut_asistente       | varchar(15) | NO   |     | NULL    |                |
| dia                 | varchar(25) | YES  |     | NULL    |                |
| hora                | varchar(5)  | YES  |     | NULL    |                |
| lugar               | varchar(50) | NO   |     | NULL    |                |
| duracion            | int         | NO   |     | NULL    |                |
| cantidad_asistentes | int         | YES  |     | NULL    |                |
+---------------------+-------------+------+-----+---------+----------------+
7 rows in set (0,00 sec)
*/

/* 2. Genere 3 consultas que permitan ingresar datos sobre la tabla 'CAPACITACION', sin asignar el campo id_capacitacion en la consulta misma */
INSERT INTO CAPACITACION
(rut_asistente, dia, hora, lugar, duracion, cantidad_asistentes)
VALUES
("12548745-5", "Martes", "09:00", "Quillota", 95, 25)
;
INSERT INTO CAPACITACION
(rut_asistente, dia, hora, lugar, duracion, cantidad_asistentes)
VALUES
("4564651-4", "Miércoles", "10:00", "Quillota", 95, 25)
;
INSERT INTO CAPACITACION
(rut_asistente, dia, hora, lugar, duracion, cantidad_asistentes)
VALUES
("4853654-9", "Viernes", "09:45", "Quillota", 95, 25)
;

/* 3. Genere 5 consultas que permitan ingresar datos sobre la tabla Asistentes, sin asignar el campo idasistente en la consulta misma. */
INSERT INTO ASISTENTES
(nombres, edad, capacitacion_id_capacitacion)
values
('Luis Belmar', 36, 5);

INSERT INTO ASISTENTES
(nombres, edad, capacitacion_id_capacitacion)
values
('Daniel Zapata', 34, 9);

INSERT INTO ASISTENTES
(nombres, edad, capacitacion_id_capacitacion)
values
('Felipe Zamora', 26, 7);

INSERT INTO ASISTENTES
(nombres, edad, capacitacion_id_capacitacion)
values
('Germán Nuñez', 30, 8);

INSERT INTO ASISTENTES
(nombres, edad, capacitacion_id_capacitacion)
values
('Alejandro Muñoz', 28, 4);

/* 4. Realice una consulta que permita establecer una restricción de tipo única sobre el campo
nombres de la tabla Asistentes */
ALTER TABLE ASISTENTES
ADD UNIQUE INDEX nombres (nombres ASC) VISIBLE;
;

/* 5. Realice una consulta que permita actualizar los campos dia a “01/01/2020” y hora a “00:00”
de la tabla capacitación, para todos aquellos registros tales que el día y la hora son igual a
un valor nulo */
UPDATE CAPACITACION
SET dia = "01/01/2020", hora = "00:00"
WHERE dia IS NULL AND hora IS NULL;

/* 6. Realice una consulta que permita eliminar todas aquellas capacitaciones que no tienen asistentes. Esto es, aquellas capacitaciones con el campo cantidadasistentes igual a 0, y sin registros relacionados en la tabla */
DELETE
FROM CAPACITACION
WHERE CAPACITACION.cantidad_asistentes = 0
	AND id_capacitacion NOT IN (
		SELECT capacitacion_id_capacitacion
        FROM ASISTENTES
        )
;