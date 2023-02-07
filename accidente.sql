drop database sprint_prev_riesgos;
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
ADD COLUMN idUsuario INT NULL /*FK CLIENTE*/;

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

/*A las tablas anteriores debe sumar las siguientes*/

/*1.- Una tabla que registre los pagos de cada cliente. Esta tabla debe contener un campo
identificador correlativo autoincremental, la fecha del pago, el monto del pago, el mes y
año que se está pagando (en campos distintos). Es necesario recordar que un cliente tiene
muchos pagos, pero un registro de pago se asociará solo a un cliente*/
CREATE TABLE pagos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fechaPago DATE NOT NULL,
    montoPago INT NOT NULL,
    mes INT NOT NULL,
    anio INT NOT NULL,
    idCliente INT NOT NULL /*FK CLIENTE*/
);

ALTER TABLE pagos
ADD CONSTRAINT pagos_cliente_FK
FOREIGN KEY (idCliente) REFERENCES Cliente(rutCliente);

/*2.- Una tabla que registre asesorías realizadas a los clientes. Una asesoría es una actividad
de verificación de situaciones que pueden generar problemas en el mediano plazo. Por
cada una de estas instancias se desea conocer un código único, la fecha de realización, el motivo por el cual se solicita y el profesional al que se asignará dicha asesoría (debe existir
una llave foránea a la tabla profesional)*/
CREATE TABLE asesoria(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    motivoSolicitud VARCHAR(50) NULL,
    idProfesional INT NOT NULL /*FK PROFESIONAL*/
);

ALTER TABLE asesoria
ADD CONSTRAINT profesionales_asesoria_FK
FOREIGN KEY (idProfesional) REFERENCES profesionales(rut);


/*3.- Por cada asesoría, se generan una o más actividades de mejora, que son
recomendaciones que el profesional hace al cliente. En cada una de estas instancias se
registra un campo único autoincremental, el título de la actividad de mejora, la
descripción de esta y el plazo en días de resolución.*/
CREATE TABLE mejoras(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    mejora VARCHAR(50) NULL,
    descripcion VARCHAR(200) NULL,
    plazo INT NOT NULL,
    idAsesoria INT NOT NULL /*FK asesoria*/
);
ALTER TABLE mejoras
ADD CONSTRAINT mejoras_asesoria_FK
FOREIGN KEY (idAsesoria) REFERENCES asesoria(id);

/*En base al enunciado anterior, se solicita que realice las siguientes labores como parte de esta evaluación:*/

/*1.- Script completo con la creación de la base de datos. Debe crear las tablas en el orden lógico, y debe considerar en ello todas las restricciones y elementos que sea necesario abordar*/
/*OK*/

/*2.-Al script anterior debe agregar consultas de inserción de registros en cada tabla. Se pide como mínimo tres registros en cada tabla insertados. Debe cuidar el orden lógico de inserción de datos, a fin de no generar conflictos con las restricciones*/
INSERT INTO cliente
(rutCliente, cliNombres, cliApellidos, cliTelefono, cliAfp, cliSistemaSalud, cliDireccion, cliComuna, cliEdad)
VALUES
(1, "Benjamín", "Pavéz", 555555, "AFP A", 1, "", "Viña del Mar", 25 ),
(2, "Matías", "Calderón", 44444, "AFP B", 2, "", "Viña del Mar", 22 ),
(3, "Leonel", "Briones", 33333, "AFP C", 1, "", "Quillota", 40 ),
(5, "Priscila", "Carrillo", 222222, "AFP A", 2, "", "Valparaíso", 28 ),
(4, "Adrián", "Fredes", 111111, "AFP C", 1, "", "Casablanca", 28 );

INSERT INTO accidente (idAccidente, acciFecha, acciHora, acciLugar, acciOrigen, acciConsecuencias, cliente_rutCliente) 
VALUES (11, '05-04-23', '22:00', 'Providencia', 'mal estacionado', 'parteEmpadronado', 1),
		(12, '06-07-22', '21:30', 'Calle7', 'atropello', ' heridos', 2),
		(13, '11-03-22', '15:45', 'Calle mirador', 'colicionPare', ' herido', 3),
		(14, '06-04-19', '16:15', 'Libertad', 'PersonaCorriendo', 'caida', 5),
		(15, '07-05-23', '17:45', 'Lomiras Bajo', 'Pelea de almunos', 'moreton', 4);
        
     
        
