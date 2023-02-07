/*M3-ABP_10*/

/*CREAR BASE DE DATOS*/
DROP DATABASE IF EXISTS ABP_10_SAN_PATRAS;
CREATE DATABASE ABP_10_SAN_PATRAS;

/*SELECCTIONAR BD*/
USE ABP_10_SAN_PATRAS;

/*CREAR TABLA PACIENTES*/
CREATE TABLE paciente(
	codigoUnico INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(20) NULL,
    direccion VARCHAR(100) NULL,
    poblacion VARCHAR(20) NULL,
    provincia VARCHAR(15) NULL,
    codigoPostal INT NOT NULL,
    fechaNacimiento DATE NOT NULL
);

/*CREAR TABLA MEDICO*/
CREATE TABLE medico(
	codigoMedico INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NULL,
    telefono INT NULL,
    especialidad VARCHAR(15)
);

/*CREAR TABLA INGRESOPACIENTE*/
CREATE TABLE ingresoPaciente(
	codIngreso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numHabitacion INT NULL,
    numCama INT NULL,
    fechaIngreso DATE NOT NULL,
    codPaciente INT NOT NULL, /*FK paciente*/
    medicoAsignado INT NOT NULL /*FK medico*/
);

/*CREAR FK ENTRE INGRESOPACIENTE CON MEDICO*/
/*CREAR KF ENTRE INGRESOPACIENTE CON PACIENTE*/
ALTER TABLE ingresoPaciente
ADD CONSTRAINT ingresoPacientes_medico_FK
FOREIGN KEY (medicoAsignado) REFERENCES medico(codigoMedico),
ADD CONSTRAINT ingresoPaciente_paciente_FK
FOREIGN KEY (codPaciente) REFERENCES paciente(codigoUnico);


/*CREAR TABLA INTERMEDIA medico_ingresos*/
CREATE TABLE medicoIngresos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codIngresoPaciente INT NOT NULL, /*FK ingresoPaciente*/
    codMedico INT NOT NULL /*FK medico*/
);

/*CREAR FK ENTRE medicoIngresos CON ingresoPaciente*/
/*CREAR FK ENTRE medicoIngresos CON medico*/
ALTER TABLE medicoIngresos
ADD CONSTRAINT medicoIngresos_ingresoPaciente_FK
FOREIGN KEY (codIngresoPaciente) REFERENCES ingresoPaciente(codIngreso),
ADD CONSTRAINT medicoIngresos_medico_FK
FOREIGN KEY(codMedico) REFERENCES medico(codigoMedico);



