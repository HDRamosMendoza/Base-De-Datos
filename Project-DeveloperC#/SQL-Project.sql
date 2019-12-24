CREATE DATABASE Geologica
GO
USE Geologica
GO
CREATE TABLE MuestraGeologica
(
	MuestraID INT IDENTITY,
	Nombre NVARCHAR(150) NOT NULL,
	Historial CHAR(1) NOT NULL,
	F_Registro DATETIME,
	Registrado NVARCHAR(50),
	F_Modificacion DATETIME,
	Modificado NVARCHAR(50),
	PRIMARY KEY(MuestraID)
)
GO
CREATE TABLE TiposMuestra
(
	TipoID INT IDENTITY,
	MuestraID INT NOT NULL,
	Muestra VARCHAR(20),
	Observacion VARCHAR(100),
	Orden INT,
	Historial CHAR(1) NOT NULL,
	F_Registro DATETIME,
	Registrado NVARCHAR(50),
	F_Modificacion DATETIME,
	Modificado NVARCHAR(50),
	PRIMARY KEY(TipoID),
	FOREIGN KEY(MuestraID)
		REFERENCES MuestraGeologica(MuestraID)
)
GO
CREATE TABLE Litotipo
(
	LitotipoID INT IDENTITY,
	MuestraID INT NOT NULL,
	Nombre NVARCHAR(30),
	Tipo NVARCHAR(30),
	Geometria NVARCHAR(30),
	DiametroBloque NVARCHAR(30),
	Orden INT,
	Historial CHAR(1) NOT NULL,
	F_Registro DATETIME,
	Registrado NVARCHAR(50),
	F_Modificacion DATETIME,
	Modificado NVARCHAR(50),
	PRIMARY KEY(LitotipoID),
	FOREIGN KEY(MuestraID)
		REFERENCES MuestraGeologica(MuestraID)
)
GO
CREATE TABLE AlteracionMineralizacion
(
	AltMinID INT IDENTITY,
	MuestraID INT NOT NULL,
	Tipo NVARCHAR(30),
	Intesidad NVARCHAR(30),
	Observacion NVARCHAR(500),
	Orden INT,
	Historial CHAR(1) NOT NULL,
	F_Registro DATETIME,
	Registrado NVARCHAR(50),
	F_Modificacion DATETIME,
	Modificado NVARCHAR(50),
	PRIMARY KEY(AltMinID),
	FOREIGN KEY(MuestraID)
		REFERENCES MuestraGeologica(MuestraID)
)
GO
CREATE TABLE MuestraGeologica_ATTACH
(
	AttachID INT IDENTITY,
	MuestraID INT NOT NULL,
	Nombre NVARCHAR(100),
	Tamano NVARCHAR(5),
	Archivo IMAGE,
	Historial CHAR(1) NOT NULL,
	F_Registro DATETIME,
	Registrado NVARCHAR(50),
	F_Modificacion DATETIME,
	Modificado NVARCHAR(50),
	PRIMARY KEY(AttachID),
	FOREIGN KEY(MuestraID)
		REFERENCES MuestraGeologica(MuestraID)
)