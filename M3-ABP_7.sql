/* M3-ABP_7 */
/* CREAR BD */
CREATE DATABASE MINORISTA;

/* SELECCIONAR BD */
USE MINORISTA;

/* CREAR TABLA VENTAS */
/* En el ejercicio anterior se añadió un trigger que controla el campo idCliente */
CREATE TABLE ventas(
idVenta INT NOT NULL PRIMARY KEY,
vendedor VARCHAR(50) NULL,
cantArticulos INT NOT NULL,
subTotal INT NOT NULL,
impuesto INT NOT NULL,
total INT NOT NULL,
clientes_idCliente INT
);

/* CREAR TABLA CLIENTES */
CREATE TABLE clientes(
idCliente INT NOT NULL PRIMARY KEY,
nombres VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
direccion VARCHAR(70),
telefono INT
);

/* CREAR LLAVE FORÁNEA A LA TABLA ventas */
ALTER TABLE ventas
ADD FOREIGN KEY (clientes_idCliente) REFERENCES clientes (idCliente);

/* POBLADO DE DATOS */
INSERT INTO clientes
(idCliente, nombres, apellidos, direccion, telefono)
values
(1, 'Frijolito', 'Chupito', 'En mi casa', 555555),
(2, 'Garbancito','Firulais', 'En su casa', 6666666)
;

/* ACTIVIDADES */
/*1.- Genere una sentencia que permita activar el auto guardado de transacciones en la base de
datos.*/

SET autocommit = 1;

/*2.- Genere dos consultas independientes: una que permita insertar un registro en la tabla de
clientes, y otra que inserte una nueva, asociada al cliente antes registrado.*/
INSERT INTO clientes (idCliente, nombres, apellidos) VALUES (8, 'Perro','Peludo');
INSERT INTO ventas (idVenta, cantArticulos, subTotal, impuesto, total, clientes_idCliente) VALUES (5, 2, 14999, 253, 25484, 8);

/* MUESTRA LAS TABLAS */
SELECT * FROM clientes;
SELECT * FROM ventas;

/*3.- Genere una sentencia que permita desactivar el auto guardado de transacciones en la base
de datos.*/
START TRANSACTION;
SET autocommit = 0;

/*4.- Incluya una consulta de eliminación de la venta recién creada */
DELETE FROM ventas WHERE idVenta = 5;
SELECT * FROM ventas;

/*5.- Genere una consulta que deshaga todos los cambios antes realizados. */
ROLLBACK;
SELECT * FROM ventas;