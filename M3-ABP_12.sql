/* CREAR BASE DE DATOS*/
DROP DATABASE IF EXISTS ABP_12_DISTRIBUIDORA;
CREATE DATABASE ABP_12_DISTRIBUIDORA;

/*SELECCIONAR BD*/
USE ABP_12_DISTRIBUIDORA;

/*CREAR TABLA VENTAS*/
CREATE TABLE ventas(
    idVenta INT(6) NOT NULL PRIMARY KEY,
    vendedor VARCHAR(50) NOT NULL,
    cantArticulos INT(3) NOT NULL,
    subTotal INT(9) NOT NULL,
    impuesto INT(9) NOT NULL,
    total INT(12) NOT NULL,
    clientes_idCliente INT(9) NOT NULL, /*FK CLIENTES*/
    idordenCompra INT NOT NULL /*FK ORDENCOMPRA*/
);

/*CREAR TABLA clientes*/
CREATE TABLE clientes(
    idCliente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(70) NULL,
    telefono VARCHAR(30) NULL

);

/*CREAR TABLA CATEGORIA*/
CREATE TABLE categoria(
    idCategoria INT(8) NOT NULL PRIMARY KEY,
    nombreCategoria VARCHAR(75) NOT NULL
);

/*CREAR TABLA producto*/
CREATE TABLE producto(
    idProducto INT NOT NULL PRIMARY KEY,
    nombreProducto VARCHAR(50) NOT NULL,
    valor INT NOT NULL,
    categoria_idCategoria INT(8) /*FK CATEGORIA*/
);

/*CREAR TABLA detalleVenta*/
CREATE TABLE detalleVenta(
    ventas_idVenta INT NOT NULL,
    producto_idProducto INT NOT NULL, /*FK PRODUCTO*/
    cantidad INT NULL,
    PRIMARY KEY(ventas_idVenta, producto_idProducto)
);

/*CREAR FK ENTRE*/
/*VENTAS Y CLIENTES*/
ALTER TABLE ventas
ADD CONSTRAINT ventas_clientes_FK
FOREIGN KEY (clientes_idCliente) REFERENCES clientes(idCliente);

/*ENTRE DETALLEVENTA Y VENTAS ADEMAS DE DETALLEVENTAS Y PRODUCTO*/
ALTER TABLE detalleVenta
ADD CONSTRAINT detalleVenta_ventas_FK
FOREIGN KEY (ventas_idVenta) REFERENCES ventas(idVenta),
ADD CONSTRAINT detalleVenta_producto_FK
FOREIGN KEY (producto_idProducto) REFERENCES producto(idProducto);

/*ENTRE PRODUCTO Y CATEGORIA*/
ALTER TABLE producto
ADD CONSTRAINT producto_categoria_FK
FOREIGN KEY (categoria_idCategoria) REFERENCES categoria(idCategoria);

/*ACTIVIDAD*/
/*A las tablas anteriormente registradas se deben agregar las siguientes:*/

/*Una tabla que permita registrar las facturas generadas. Cada factura se asocia a una venta
específica, y cada venta al mismo tiempo puede ser cancelada a través de una o más
facturas. De cada factura interesa saber su número único y correlativo, la fecha de
generación, la fecha de pago, el monto de la factura, el subtotal, el impuesto y el total.*/

/*CREAR TABLA facturas*/
CREATE TABLE facturas(
    idFactura INT NOT NULL,
    ventas_idVenta INT NOT NULL,
    fechaCreacion DATE NOT NULL,
    monto INT NOT NULL,
    subTotal INT NOT NULL,
    impuesto INT NOT NULL,
    total INT NOT NULL,
    PRIMARY KEY (idFactura)
);

CREATE TABLE pagosFactura(
    idPagoFactura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    venta_idVenta INT NOT NULL, /*FK VENTAS OK*/
    factura_idFactura INT NOT NULL, /*FK FACTURA OK*/
    fechaPago DATE NOT NULL
);

/*Una tabla que permita almacenar órdenes de compra. De cada orden de compra se debe
registrar un código único, una fecha de creación, el nombre del trabajador que la autoriza y
un campo que permita registrar observaciones. Es necesario destacar que cada venta solo
tendrá una orden de compra asociada*/
CREATE TABLE ordenesCompra(
    idOrdenCompra INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fechaCreacionOrden DATE NOT NULL,
    responsable VARCHAR(20) NOT NULL,
    observaciones VARCHAR(200) NULL,
    ordenCompra_idDetalleOrden INT NOT NULL /*FK DETALLEORDENCOMPRA*/
);

/*Una tabla que permita almacenar las adquisiciones realizadas para cada producto. En esta
tabla se debe registrar un número correlativo, la fecha de compra, el nombre del proveedor
y la cantidad adquirida.*/
CREATE TABLE detalleOrdenCompra(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    producto INT NOT NULL, /*FK producto OK*/
    cantidad INT NOT NULL,
    proveedor VARCHAR(30) NOT NULL
);

/*CREAR FK ENTRE DETALLEORDENCOMPRA CON PRODUCTO*/
ALTER TABLE detalleOrdenCompra
ADD CONSTRAINT detalleOrdenCompra_producto_FK
FOREIGN KEY (producto) REFERENCES producto(idProducto);

/*CREAR FK*/
/* ENTRE PAGOSFACTURA Y VENTAS */
/* ENTRE PAGOSFACTURA Y FACTURA */
ALTER TABLE pagosFactura
ADD CONSTRAINT pagosFactura_ventas_FK
FOREIGN KEY (venta_idVenta) REFERENCES ventas(idVenta),
ADD CONSTRAINT pagosFactura_factura_FK
FOREIGN KEY (factura_idFactura) REFERENCES facturas(idFactura);

/*CREAR FK ORDENESCOMPRA ENTRE DETALLEORDENCOMPRA*/
ALTER TABLE ordenesCompra
ADD CONSTRAINT ordenesCompra_detalleOrdenCompra_FK
FOREIGN KEY (ordenCompra_idDetalleOrden) REFERENCES detalleOrdenCompra(id);
