/* ABP_5 (IND) */

/* CREAR BD */
CREATE DATABASE MINORISTA;

/* SELECCIONAR BD */
USE MINORISTA;

/* CREAR TABLA VENTAS */
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

INSERT INTO clientes
(idCliente, nombres, apellidos)
values
(3, 'Chuletas', 'Dinamita')
;

INSERT INTO ventas
(idVenta, vendedor, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
values
(1, 'Aitor Tilla', 5, 4500, 41, 78522, 1 ),
(2, 'Alan Brito Delgado', 7, 78421, 9855, 987986, 2),
(3, 'Aitor Tilla', 60, 96599, 25698, 102354, 3),
(4, 'Alan Brito Delgado', 9, 87798, 36297, 362541,1),
(5, 'Evita Dolores', 20, 45656, 85, 999877,2)
;

/* ACTIVIDADES */
/*1.- Desarrolle una consulta que permita generar una secuencia para el campo idcliente de la tabla clientes. Junto con ello, debe crear un trigger o disparador que, al momento de insertar un registro, asigne de manera automática el identificador a la tabla.*/
CREATE TRIGGER clientes_autoNumericId_BI
BEFORE INSERT
ON clientes
FOR EACH ROW
SET NEW.idCliente = (SELECT MAX(idCliente) + 1 FROM clientes);

/*2.- Genere dos consultas de inserción de registros en la tabla clientes, sin indicar el identificador de clientes en ella. */
INSERT INTO clientes
(nombres, apellidos, direccion, telefono)
VALUES
('Gatillo','Cucho', 'La Parrilla', 8444444),
('Gato','Con Botas', 'El Pantano', 9555555)
;

/*3.- Genere una consulta que añada una restricción por chequeo de control de valores en la tabla ventas al campo cantarticulos, dando opción a que este sea solo un valor entre 1 y 5 (sólo números enteros).*/
DELIMITER $$
CREATE TRIGGER ventas_max5CantArticulos_BI
BEFORE INSERT
ON ventas
FOR EACH ROW BEGIN
	IF (NEW.cantArticulos >5) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: No más de 5 productos';
	END IF;
END;
$$
DELIMITER ;

/* COMPROBAR EL FUNCIONAMIENTO DEL TRIGGER DE VALIDACIÓN CREADO ANTERIORMENTE */
INSERT INTO ventas
(idVenta, vendedor, cantArticulos, subTotal, impuesto, total, clientes_idCliente )
VALUES
(6, 'Evita Dolores', 9, 7800, 1422, 541522 ,3)
;

