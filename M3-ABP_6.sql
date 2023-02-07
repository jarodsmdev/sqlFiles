/* ABP_6 (IND) */

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
/*1.- Genere una consulta de inserción de datos en la tabla clientes. Inserte un registro indicando solo los campos que no permiten valores nulos.*/
START TRANSACTION;
SET autocommit = 0;
INSERT INTO clientes
(idCliente, nombres, apellidos)
VALUES
(8, 'Perro', 'Peludo')
;

/*2.- Genere dos consultas de inserción de datos en la tabla de ventas. Inserte dos registros distintos de esta manera, usando dos sintaxis diversas. Ambas ventas ingresadas deben estar asociadas al cliente ingresado en el ítem anterior.*/
INSERT INTO ventas
(idVenta, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
VALUES
(5, 5, 74521, 45111, 879465, 8)
;

INSERT INTO ventas
(idVenta, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
VALUES
(6, 4, 52662, 3326, 563254, 8)
;

/*3.- Incluya un comando para confirmar los cambios incluidos en las sentencias anteriores */
/*COMMIT;*/
SELECT * FROM cliente;
SELECT * FROM ventas;

/*4.- Genere una consulta que modifique el registro ingresado en el ítem 1 de este ejercicio, en específico otorgando valores a los campos que están nulos */
UPDATE clientes
SET direccion = 'Wakanda', telefono = '9999999'
WHERE idCliente = 8
;

/*5.- Incluya un comando para deshacer los cambios realizados anteriormente.*/

ROLLBACK;
SET autocommit = 1;
/* Todas las consultas anteriores deben estar en un mismo archivo, y deben ser parte de una misma transacción. Por ello, tenga en consideración el formato a indicar en cada consulta */