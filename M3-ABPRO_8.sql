/*SPRINT_PREV_RIESGOS;*/

/*CREAR DATABASE SPRINT_PREV_RIESGOS;*/
DROP DATABASE IF EXISTS SPRINT_PREV_RIESGOS;
CREATE DATABASE SPRINT_PREV_RIESGOS;

/*USAR TABLA ABPRO_6_PREV_RIESGOS*/
USE SPRINT_PREV_RIESGOS;

/*CREAR TABLA Cliente*/
CREATE TABLE Cliente(
	rutCliente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    afp VARCHAR(30) NULL,
    sistemaSalud VARCHAR(2) NULL,
    direccion VARCHAR(70) NULL,
    comuna VARCHAR(50) NULL,
    edad INT(3) NOT NULL
);

/*CREAR TABLA Accidente*/
CREATE TABLE Accidente(
	accidenteId INT(9) NOT NULL PRIMARY KEY,
    dia DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    origen VARCHAR(100) NULL,
    consecuencias VARCHAR(100) NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE ACCIDENTE Y CLIENTE*/
ALTER TABLE Accidente
ADD CONSTRAINT accidente_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);


/*CREAR TABLA Capacitacion*/
CREATE TABLE Capacitacion(
	idCapacitacion INT(9) NOT NULL PRIMARY KEY,
    fecha DATE NULL,
    hora TIME NULL,
    lugar VARCHAR(50) NOT NULL,
    duracion INT(3) NULL,
    cantidadAsistentes INT(5) NOT NULL,
    cliente_rutCliente INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE CAPACITACION Y CLIENTE*/
ALTER TABLE Capacitacion
ADD CONSTRAINT capacitacion_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);

/*CREAR TABLA Asistentes*/
CREATE TABLE Asistentes(
	idAsistente INT(9) NOT NULL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    edad INT(3) NOT NULL,
    capacitacion_idCapacitacion INT(9) NOT NULL
);

/*CREAR LLAVE FORÁNEA ENTRE ASISTENTES Y CAPACITACION*/
ALTER TABLE Asistentes
ADD CONSTRAINT asistentes_capacitacion_FK
FOREIGN KEY (capacitacion_idCapacitacion) REFERENCES Capacitacion(idCapacitacion);

/*MODIFICAR TABLA Cliente*/

ALTER TABLE Cliente
RENAME COLUMN nombres TO cliNombres,
CHANGE COLUMN apellidos cliApellidos VARCHAR(50) NOT NULL,
RENAME COLUMN telefono TO cliTelefono,
RENAME COLUMN afp TO cliAfp,
RENAME COLUMN sistemaSalud TO cliSistemaSalud,
CHANGE COLUMN direccion cliDireccion VARCHAR(100) NOT NULL,
CHANGE COLUMN comuna cliComuna VARCHAR(50) NOT NULL,
CHANGE COLUMN edad cliEdad INT(3) NOT NULL;


/*MODIFICAR TABLA Capacitacion*/

ALTER TABLE Capacitacion
RENAME COLUMN fecha TO capFecha,
RENAME COLUMN hora TO capHora,
CHANGE COLUMN lugar capLugar VARCHAR(100) NOT NULL,
CHANGE COLUMN duracion capDuracion INT(4) NULL,
DROP COLUMN cantidadAsistentes;
;

ALTER TABLE Asistentes
CHANGE COLUMN nombres asisNombreCompleto VARCHAR(100) NOT NULL,
CHANGE COLUMN edad asisEdad INT(3) NOT NULL,
ADD COLUMN asisCorreo VARCHAR(70) NULL,
ADD COLUMN asisTelefono VARCHAR(20) NULL;

/*MODIFICAR TABLA Accidente*/

ALTER TABLE Accidente
RENAME COLUMN accidenteId TO idAccidente,
RENAME COLUMN dia TO acciFecha,
CHANGE COLUMN hora acciHora TIME NOT NULL,
CHANGE COLUMN lugar acciLugar VARCHAR(150) NOT NULL,
CHANGE COLUMN origen acciOrigen VARCHAR(100) NOT NULL,
RENAME COLUMN consecuencias TO acciConsecuencias;
;

/*CREAR TABLA Visita*/
CREATE TABLE Visita(
	idVisita INT(9) NOT NULL PRIMARY KEY,
    visFecha DATE NOT NULL,
    visHora TIME NULL,
    visLugar VARCHAR(50) NOT NULL,
    visComentarios VARCHAR(250) NOT NULL,
    cliente_rutCliente INT(9) NOT NULL
    /*idCheckeo INT NOT NULL*/
);

/*ALTER TABLE Visita
ADD CONSTRAINT visita_checkeo_FK
FOREIGN KEY (idCheckeo) REFERENCES checkeos(id);
*/

CREATE TABLE visitaCheckeo(
	idVisita INT NOT NULL, /*FK VISITA ok*/
    idCheckeo INT NOT NULL /*FK CHECKEO*/
);



/*CREAR LLAVE FORÁNEA ENTRE VISITA Y CLIENTE*/
ALTER TABLE Visita
ADD CONSTRAINT visita_cliente_FK
FOREIGN KEY (cliente_rutCliente) REFERENCES Cliente(rutCliente);

/*ACTIVIDAD*/

CREATE TABLE checkeos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NULL
);

ALTER TABLE visitaCheckeo
ADD CONSTRAINT visitaCheckeo_vista_FK
FOREIGN KEY (idVisita) REFERENCES Visita(idVisita),
ADD CONSTRAINT visitaCheckeo_checkeo_FK
FOREIGN KEY (idCheckeo) REFERENCES checkeos(id)
;

CREATE TABLE resultadoCheckeo(
	checkeos_id INT NOT NULL, /*FK CHECKEOS*/
    resultadoCheckeo ENUM("CUMPLE","C/OBSERVACIONES","NO CUMPLE") NOT NULL
);
ALTER TABLE resultadoCheckeo
ADD CONSTRAINT checkeos_resultadoCheckeo_FK
FOREIGN KEY (checkeos_id) REFERENCES checkeos(id);


CREATE TABLE usuarios(
	id INT NOT NULL PRIMARY KEY,
    run INT NOT NULL,
	nombre VARCHAR(20) NULL,
    apellidos VARCHAR(20) NULL,
    fechaNac DATE NOT NULL
);

ALTER TABLE usuarios
ADD COLUMN idUsuario INT NULL /*FK usuario*/;

ALTER TABLE usuarios
ADD CONSTRAINT usuario_cliente_FK
FOREIGN KEY (idUsuario) REFERENCES Cliente(rutCliente);


CREATE TABLE administrativos(
	run INT NOT NULL PRIMARY KEY,
    nombres VARCHAR(45) NULL,
    apellidos VARCHAR(45) NULL,
    email VARCHAR(25) NULL,
    area VARCHAR(25) NULL,
    idUsuario INT NOT NULL /*FK usuario*/
);

ALTER TABLE administrativos
ADD CONSTRAINT administrativos_usuario_FK
FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario);

CREATE TABLE profesionales(
	rut INT NOT NULL PRIMARY KEY,
    nombres VARCHAR(45) NULL,
    apellidos VARCHAR(45) NULL,
    telefono INT NULL,
    tituloProfesional VARCHAR(30) NULL,
    proyecto VARCHAR(45) NULL,
    idUsuario INT NOT NULL
);

ALTER TABLE profesionales
ADD CONSTRAINT profesionales_usuario_FK
FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario);