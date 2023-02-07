CREATE DATABASE CAPACITACION2;

USE CAPACITACION2;

INSERT INTO CAPACITACION
(id_capacitacion, rut_asistente, dia, hora, lugar, duracion, cantidad_asistentes)
VALUES
(1, "139875674", "lunes", "09:00", "Valparaíso", 60, 5),
(2, "167859660", "martes", "10:00", "Viña del Mar", 30, 10),
(3, "124556764", "miercoles", "11:00", "Valparaíso", 40, 15),
(4, "154566543", "jueves", "12:00", "Con cón", 60, 3),
(5, "465456654", "viernes", "13:00", "Limache", 20, 2),
(6, "139875674", "lunes", "14:00", "Peñablanca", 40, 30),
(7, "139875674", "martes", "15:00", "Viña del Mar", 90, 5),
(8, "139875674", "miércoles", "15:00", "Con cón", 120, 20),
(9, "139875674", "jueves", "15:00", "Limache", 150, 40),
(10, "139875674", "viernes", "15:00", "Peñablanca", 30, 60);

INSERT INTO ASISTENTES
(id_asistente, nombres, edad, capacitacion_id_capacitacion)
VALUES
(1, "Juan Pérez", 30, 1),
(2, "Pedro Garrido", 35, 2),
(3, "Matías Calderón", 40, 3),
(4, "Cristian López", 25, 4),
(5, "Sebastán Rojas", 30, 5),
(6, "Paola Muñoz", 45, 6),
(7, "Lorena Valdéz", 28, 7),
(8, "Javiera Saavedra", 26, 8),
(9, "Benjamín Berríos", 24, 9),
(10, "Valentina Rojas", 32, 10);

/* 1. consulta que despliegue todas las capacitaciones realizadas un lunes, que hayan
durado menos de una hora y media. */

SELECT * FROM CAPACITACION
WHERE dia = "lunes"
AND duracion < 90;

/* CAPACITACION
+-----------------+---------------+-------+-------+-------------+----------+---------------------+
| id_capacitacion | rut_asistente | dia   | hora  | lugar       | duracion | cantidad_asistentes |
+-----------------+---------------+-------+-------+-------------+----------+---------------------+
|               1 | 139875674     | lunes | 09:00 | Valparaíso  |       60 |                   5 |
|               6 | 139875674     | lunes | 14:00 | Peñablanca  |       40 |                  30 |
+-----------------+---------------+-------+-------+-------------+----------+---------------------+
2 rows in set (0,00 sec)
*/

/* 2. Una consulta que despliegue el listado de asistentes, mostrando el apellido y el nombre,
y el RUT del cliente, lugar y duración de la capacitación a la que asistió.*/

SELECT a.nombres, c.rut_asistente, c.lugar, c.duracion, c.id_capacitacion
FROM ASISTENTES a
JOIN CAPACITACION c
ON c.id_capacitacion = a.capacitacion_id_capacitacion;

/* TABLA ASISTENTES
+--------------------+---------------+---------------+----------+-----------------+
| nombres            | rut_asistente | lugar         | duracion | id_capacitacion |
+--------------------+---------------+---------------+----------+-----------------+
| Juan Pérez         | 139875674     | Valparaíso    |       60 |               1 |
| Pedro Garrido      | 167859660     | Viña del Mar  |       30 |               2 |
| Matías Calderón    | 124556764     | Valparaíso    |       40 |               3 |
| Cristian López     | 154566543     | Con cón       |       60 |               4 |
| Sebastán Rojas     | 465456654     | Limache       |       20 |               5 |
| Paola Muñoz        | 139875674     | Peñablanca    |       40 |               6 |
| Lorena Valdéz      | 139875674     | Viña del Mar  |       90 |               7 |
| Javiera Saavedra   | 139875674     | Con cón       |      120 |               8 |
| Benjamín Berríos   | 139875674     | Limache       |      150 |               9 |
| Valentina Rojas    | 139875674     | Peñablanca    |       30 |              10 |
+--------------------+---------------+---------------+----------+-----------------+
10 rows in set (0,00 sec)

*/

/* 3. Una consulta que despliegue el listado de capacitaciones mostrando RUT del cliente, día
y hora, tales que la cantidad de asistentes registrada en el campo cant_asistentes no
coincida con la cantidad existente en la tabla Asistentes.*/

SELECT c.rut_asistente, c.dia, c.hora
FROM CAPACITACION c
where c.cantidad_asistentes <> (select count(id_asistente) from ASISTENTES);

/*
+---------------+------------+-------+
| rut_asistente | dia        | hora  |
+---------------+------------+-------+
| 139875674     | lunes      | 09:00 |
| 124556764     | miercoles  | 11:00 |
| 154566543     | jueves     | 12:00 |
| 465456654     | viernes    | 13:00 |
| 139875674     | lunes      | 14:00 |
| 139875674     | martes     | 15:00 |
| 139875674     | miércoles  | 15:00 |
| 139875674     | jueves     | 15:00 |
| 139875674     | viernes    | 15:00 |
+---------------+------------+-------+
9 rows in set (0,00 sec)
*/

/* 4. Una consulta que muestre el listado de capacitaciones que tengan más de tres
asistentes registrados en la tabla respectiva. De la tabla de capacitaciones debe mostrar
el lugar, la duración, el día y la hora.*/

SELECT lugar, duracion, dia, hora FROM CAPACITACION
WHERE cantidad_asistentes > 3;

/*
+---------------+----------+------------+-------+
| lugar         | duracion | dia        | hora  |
+---------------+----------+------------+-------+
| Valparaíso    |       60 | lunes      | 09:00 |
| Viña del Mar  |       30 | martes     | 10:00 |
| Valparaíso    |       40 | miercoles  | 11:00 |
| Peñablanca    |       40 | lunes      | 14:00 |
| Viña del Mar  |       90 | martes     | 15:00 |
| Con cón       |      120 | miércoles  | 15:00 |
| Limache       |      150 | jueves     | 15:00 |
| Peñablanca    |       30 | viernes    | 15:00 |
+---------------+----------+------------+-------+
8 rows in set (0,00 sec)

*/

USE CAPACITACION2;

SELECT  lugar, duracion, dia, hora 
FROM CAPACITACION
WHERE (select count(*) FROM ASISTENTES a WHERE CAPACITACION.id = a.capacitacion_idcapacitacion ) >= 3;

SELECT  lugar, duracion, dia, hora 
FROM
(SELECT c.lugar, c.duracion, c.dia, c.hora, 
count(a.capacitacion_idcapacitacion) as totales
FROM capacitacion c
INNER JOIN ASISTENTES a on a.capacitacion_idcapacitacion = c.id
GROUP BY c.lugar, c.duracion, c.dia, c.hora
HAVING totales >= 3
) AS asistencia;