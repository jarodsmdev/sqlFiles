/*M3-ABPRO_7 (MER)*/

/*CREAR BASE DE DATOS*/
DROP DATABASE IF EXISTS ABPRO_7_PREV_RIESGOS;
CREATE DATABASE ABPRO_7_PREV_RIESGOS;

/*SELECCIONAR BD*/
USE ABPRO_7_PREV_RIESGOS;

/*CREAR TABLAS*/
CREATE TABLE CLIENTE(
	rutCliente INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    repLegal VARCHAR(50) NULL,
    telefono INT NULL
);

CREATE TABLE VISITAS(
	idVisita INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    lugar VARCHAR(20) NULL,
    comentarios VARCHAR(200) NULL,
    visita_rutCliente INT NOT NULL
);

/*CREAR FK ENTRE VISITAS Y CLIENTES*/
ALTER TABLE VISITAS
ADD CONSTRAINT visitas_clientes_FK
FOREIGN KEY (visita_rutCliente) REFERENCES CLIENTE(rutCliente);

CREATE TABLE RESULTADOVISITA(
	idResultado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    resultado_idVisita INT NOT NULL,
    resultado ENUM('CUMPLE','CUMPLE C/OBS','NO CUMPLE') NOT NULL
);

/*CREAR FK ENTRE RESULTADOVISITA Y VISITAS*/
ALTER TABLE RESULTADOVISITA
ADD CONSTRAINT resultadoVisita_visita_FK
FOREIGN KEY (resultado_idVisita) REFERENCES VISITAS(idVisita);

CREATE TABLE CAPACITACION(
	idCapacitacion INT NOT NULL PRIMARY KEY,
    dia DATE,
    hora TIME,
    lugar VARCHAR(20),
    capacitacion_idCliente INT NOT NULL
);

/*CREAR FK ENTRE CAPACITACION Y CLIENTES*/
ALTER TABLE CAPACITACION
ADD CONSTRAINT capacitacion_clientes_FK
FOREIGN KEY (capacitacion_idCliente) REFERENCES CLIENTE(rutCliente);

CREATE TABLE ASISTENTES(
	idAsistente INT NOT NULL PRIMARY KEY,
    nombreCompleto VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    email VARCHAR(30),
    telefono INT,
    asistentes_idCapacitacion INT NOT NULL
);

/*CREAR FK ENTRE ASISTENTES Y CAPACITACION*/
ALTER TABLE ASISTENTES
ADD CONSTRAINT asistentes_capacitacion_FK
FOREIGN KEY (asistentes_idCapacitacion) REFERENCES CAPACITACION(idCapacitacion);

CREATE TABLE USUARIOS(
	idUsuario INT NOT NULL,
    rutCliente INT NOT NULL UNIQUE,
    nombre VARCHAR(20) NULL,
    apellido VARCHAR(20) NULL,
    fechaNac DATE NOT NULL,
    PRIMARY KEY(idUsuario, rutCliente)
);

/*CREAR FK ENTRE USUARIOS Y CLIENTES*/
ALTER TABLE USUARIOS
ADD CONSTRAINT usuarios_clientes_FK
FOREIGN KEY (rutCliente) REFERENCES CLIENTE(rutCliente);
