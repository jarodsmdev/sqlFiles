/* CREAR BASE DE DATOS LLAMADA MININMARKET */
CREATE DATABASE MINIMARKET;

/* SELECCIONAR BD MINMARKET */
USE MINIMARKET;

/* CREAR TABLA VENTAS */
CREATE TABLE VENTAS(
idVenta INT NOT NULL,
vendedor VARCHAR(50) NULL,
cantArticulos INT NOT NULL,
subTotal INT NOT NULL,
impuesto INT NOT NULL,
total INT NOT NULL,
clientes_idCliente INT NOT NULL
);

/* AGREGAR PRIMARY KEY A LA TABLA VENTAS*/
ALTER TABLE VENTAS
ADD CONSTRAINT ventas_pk PRIMARY KEY (idVenta);

/* TABLA VENTAS
+--------------------+-------------+------+-----+---------+-------+
| Field              | Type        | Null | Key | Default | Extra |
+--------------------+-------------+------+-----+---------+-------+
| idVenta            | int         | NO   | PRI | NULL    |       |
| vendedor           | varchar(50) | YES  |     | NULL    |       |
| cantArticulos      | int         | NO   |     | NULL    |       |
| subTotal           | int         | NO   |     | NULL    |       |
| impuesto           | int         | NO   |     | NULL    |       |
| total              | int         | NO   |     | NULL    |       |
| clientes_idCliente | int         | NO   |     | NULL    |       |
+--------------------+-------------+------+-----+---------+-------+
7 rows in set (0,00 sec)
*/


/* CREAR TABLA CLIENTES */
CREATE TABLE CLIENTES(
idCliente INT NOT NULL,
nombres VARCHAR(50) NOT NULL,
apellidos VARCHAR(50) NOT NULL,
direccion VARCHAR(70) NULL,
telefono INT NULL
);

/* AGREGAR PRIMARY KEY A LA TABLA CLIENTES */
ALTER TABLE CLIENTES
ADD CONSTRAINT clientes_pk PRIMARY KEY (idCliente);

/* TABLA CLIENTES
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| idCliente | int         | NO   | PRI | NULL    |       |
| nombres   | varchar(50) | NO   |     | NULL    |       |
| apellidos | varchar(50) | NO   |     | NULL    |       |
| direccion | varchar(70) | YES  |     | NULL    |       |
| telefono  | int         | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
5 rows in set (0,01 sec)

*/

/* AGREGAR FOREIGN KEY A LA TABLA VENTAS*/
ALTER TABLE VENTAS
ADD CONSTRAINT ventas_clientes_fk FOREIGN KEY (clientes_idCliente)
REFERENCES CLIENTES (idCliente);

/* SHOW CREATE TABLE VENTAS;
| VENTAS | CREATE TABLE `VENTAS` (
  `idVenta` int NOT NULL,
  `vendedor` varchar(50) DEFAULT NULL,
  `cantArticulos` int NOT NULL,
  `subTotal` int NOT NULL,
  `impuesto` int NOT NULL,
  `total` int NOT NULL,
  `clientes_idCliente` int NOT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `ventas_clientes_fk` (`clientes_idCliente`),
  CONSTRAINT `ventas_clientes_fk` FOREIGN KEY (`clientes_idCliente`) REFERENCES `CLIENTES` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
 */
 
 /* POBLAR DATOS EN LA TABLA CLIENTES */
 INSERT INTO CLIENTES
 (idCliente, nombres, apellidos, direccion, telefono)
 VALUES
 (1, "Antonia", "Aranda", "Calle Los Aromos #123", 991111111),
 (2, "Bernarda", "Barros", "Pasaje Manuel Balmaceda #456", 992222222),
 (3, "Carlos", "Costa", "Avenida Simón Bolivar #789", 993333333);
 
 /* POBLAR DATOS EN LA TABLA VENTAS */
  /* INGRESA REGISTRO EN LA TABLA VENTAS A LOS SIGUIENTES CAMPOS */
 
 /* idVenta, vendedor, cantArticulos, subTotal, impuesto, total, clientes_idCliente */
INSERT INTO VENTAS
(idVenta, vendedor, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
VALUES
(1,'Andrés Aranda',3,4500,500,5000,1);

/* idVenta, cantArticulos, subTotal, impuesto, total, clientes_idCliente (NO INGRESAR 'vendedor' */
INSERT INTO VENTAS
(idVenta, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
VALUES
(2,2,1200,100,1400,1);

/* vendedor, idVenta, subTotal, cantArticulos, impuesto, total, cliente_idCliente
(***INGRESO DE TODOS LOS CAMPOS EN UN ORDEN DISTINTO AL ESTABLECIDO POR LA TABLA***) */
INSERT INTO VENTAS (vendedor, idVenta, subTotal, cantArticulos, impuesto, total, clientes_idCliente)
VALUES
('Cristina Cortés',3,10480,5,20,10500,2);

/* INGESO DE TODOS LOS CAMPOS EN EL MISMO ORDEN ESTABLECIDO EN LA TABLA */
INSERT INTO VENTAS (idVenta, vendedor, cantArticulos, subTotal, impuesto, total, clientes_idCliente)
VALUES
(4,'Daniela Durán',1,5000,2500,7500,2);

/* idVenta, cantArituclos, clientes_idCliente, subTotal, impuesto, total
**(NO INGRESAR 'vendedor'*** */
INSERT INTO VENTAS
(idVenta, cantArticulos, clientes_idCliente, subTotal, impuesto, total)
VALUES (5,3,3,3800,100,4000);

/* *** EJERCICIOS *** */
/* 1. Una consulta que permita obtener todas las ventas tales que la suma entre el subtotal y el
impuesto difieren del total*/
SELECT * FROM VENTAS
WHERE (subTotal + impuesto) != total;
/*
+---------+----------+---------------+----------+----------+-------+--------------------+
| idVenta | vendedor | cantArticulos | subTotal | impuesto | total | clientes_idCliente |
+---------+----------+---------------+----------+----------+-------+--------------------+
|       2 | NULL     |             2 |     1200 |      100 |  1400 |                  1 |
|       5 | NULL     |             3 |     3800 |      100 |  4000 |                  3 |
+---------+----------+---------------+----------+----------+-------+--------------------+
2 rows in set (0,00 sec)
*/


/* 2. Una consulta que permita conocer la suma del total de todas las ventas registradas */
SELECT sum(total) FROM VENTAS;
/*
+------------+
| sum(total) |
+------------+
|      28400 |
+------------+
1 row in set (0,05 sec)

*/

/* 3. Una consulta que permita conocer el listado de ventas de la cliente de nombre “Antonia
Aranda”. */
SELECT *
FROM CLIENTES c JOIN VENTAS v
ON c.idCliente = v.clientes_idCliente
WHERE nombres = 'Antonia' and apellidos = 'Aranda';

/*
+-----------+---------+-----------+-----------------------+-----------+---------+----------------+---------------+----------+----------+-------+--------------------+
| idCliente | nombres | apellidos | direccion             | telefono  | idVenta | vendedor       | cantArticulos | subTotal | impuesto | total | clientes_idCliente |
+-----------+---------+-----------+-----------------------+-----------+---------+----------------+---------------+----------+----------+-------+--------------------+
|         1 | Antonia | Aranda    | Calle Los Aromos #123 | 991111111 |       1 | Andrés Aranda  |             3 |     4500 |      500 |  5000 |                  1 |
|         1 | Antonia | Aranda    | Calle Los Aromos #123 | 991111111 |       2 | NULL           |             2 |     1200 |      100 |  1400 |                  1 |
+-----------+---------+-----------+-----------------------+-----------+---------+----------------+---------------+----------+----------+-------+--------------------+
2 rows in set (0,00 sec)

*/

/* 4.Una consulta que despliegue el identificador del cliente, junto con su nombre y apellidos
juntos en un solo campo. Debe desplegar solo los clientes que no tienen una dirección
registrada */
SELECT concat(idCliente," ", nombres, " ", apellidos) as 'ID | Nombre Completo'
FROM CLIENTES
WHERE direccion is Null;
/*
Empty set (0,01 sec)
*/

/* 5. Una consulta que permita saber, al mismo tiempo, el monto de la mínima venta y máxima
venta registrada en la tabla respectiva */
SELECT min(total) AS 'Venta Mínima', max(total) as 'Venta Máxima'
FROM VENTAS;
/*
+---------------+---------------+
| Venta Mínima  | Venta Máxima  |
+---------------+---------------+
|          1400 |         10500 |
+---------------+---------------+
1 row in set (0,00 sec)
*/

