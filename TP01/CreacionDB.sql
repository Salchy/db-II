CREATE DATABASE DBArchivos
GO
USE DBArchivos;

CREATE TABLE TiposUsuario (
	IDTipoUsuario INT PRIMARY KEY IDENTITY(1, 1),
	TipoUsuario VARCHAR(100) NOT NULL
)
GO

CREATE TABLE TiposArchivos (
	IDTipoArchivo INT PRIMARY KEY IDENTITY(1, 1),
	TipoArchivo VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Permisos (
	IDPermiso INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Usuarios (
	IDUsuario INT PRIMARY KEY IDENTITY(1, 1),
	Nombre VARCHAR(100) NOT NULL,
	Apellido VARCHAR(100) NOT NULL,
	IDTipoUsuario INT NOT NULL,

	FOREIGN KEY (IDTipoUsuario) REFERENCES TiposUsuario(IDTipoUsuario)
)
GO

CREATE TABLE Archivos (
	IDArchivo INT PRIMARY KEY IDENTITY(1, 1),
	IDUsuarioDueño INT NOT NULL,
	Nombre VARCHAR(255) NOT NULL,
	Extension VARCHAR(10) NOT NULL,
	Descripcion VARCHAR(1000) NULL,
	IDTipoArchivo INT NOT NULL,
	Tamaño INT NOT NULL,
	FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
	FechaUltimaModificacion DATETIME NOT NULL DEFAULT GETDATE(),
	Eliminado BIT NOT NULL DEFAULT 0,

	FOREIGN KEY (IDUsuarioDueño) REFERENCES Usuarios(IDUsuario),
	FOREIGN KEY (IDTipoArchivo) REFERENCES TiposArchivos(IDTipoArchivo)
)
GO

CREATE TABLE ArchivosCompartidos (
	IDArchivo INT NOT NULL,
	IDUsuario INT NOT NULL,
	IDPermiso INT NOT NULL,
	FechaCompartido DATETIME NOT NULL DEFAULT GETDATE(),

	PRIMARY KEY (IDArchivo, IDUsuario),
	FOREIGN KEY (IDArchivo) REFERENCES Archivos(IDArchivo),
	FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
	FOREIGN KEY (IDPermiso) REFERENCES Permisos(IDPermiso)
);