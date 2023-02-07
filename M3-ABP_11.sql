/* CREAR BASE DE DATOS*/
DROP DATABASE IF EXISTS ABP_11_DISTRIBUIDORA;
CREATE DATABASE ABP_11_DISTRIBUIDORA;

/*SELECCIONAR BD*/
USE ABP_11_DISTRIBUIDORA;

/*CREAR TABLA EMPRESA*/
CREATE TABLE empresa(
	id INT NOT NULL AUTO_INCREMENT,
    rut VARCHAR(10) NOT NULL,
    direccion VARCHAR(50) NULL,
    telefono INT NULL,
    ciudad VARCHAR(15) NULL,
    pais VARCHAR(10),
    PRIMARY KEY (id, rut)
);

/*CREATE TABLE clientes*/
CREATE TABLE clientes(
	id INT NOT NULL AUTO_INCREMENT,
    rut VARCHAR(15) NOT NULL,
	nombre VARCHAR(50) NULL,
    direccion VARCHAR(100) NULL,
    ciudad VARCHAR(50) NULL,
    telefono INT NULL,
    PRIMARY KEY (id, rut)
);


/*CREAR TABLA factura*/
CREATE TABLE factura(
	id INT NOT NULL PRIMARY KEY,
    fechaVenta DATE,
    idEmpresa INT NOT NULL, /*FK EMPRESA*/
    idCliente INT NOT NULL, /*FK CLIENTES*/
    idventa INT NOT NULL, /*FK VENTAS*/
    subTotal INT,
    iva INT NOT NULL,
    total INT NOT NULL
);

/*CREAR TABLA VENTAS */
CREATE TABLE ventas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codProducto INT NOT NULL, /*FK PRODUCTOS*/
	cantidad INT NOT NULL,
    totalLinea INT NOT NULL
);

/*CREAR TABLA PRODUCTOS*/
CREATE TABLE productos(
	id INT NOT NULL PRIMARY KEY,
	desProducto VARCHAR(50) NULL,
    precio INT NOT NULL
);

/*CREAR FK ENTRE*/
/* factura y empresa*/
/*factura y clientes*/
/*factura y ventas*/
ALTER TABLE factura
ADD CONSTRAINT factura_empresa_FK
FOREIGN KEY (idEmpresa) REFERENCES empresa(id),
ADD CONSTRAINT factura_clientes_FK
FOREIGN KEY (idCliente) REFERENCES clientes(id),
ADD CONSTRAINT factura_ventas_FK
FOREIGN KEY (idVenta) REFERENCES ventas(id)
;

/*CREAR FK ENTRE ventas y producto*/
ALTER TABLE ventas
ADD CONSTRAINT ventas_productos_FK
FOREIGN KEY (codProducto) REFERENCES productos(id);

