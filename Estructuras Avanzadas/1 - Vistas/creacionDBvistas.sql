CREATE DATABASE EjemploVista
COLLATE Latin1_General_CI_AI
Go

Use EjemploVista
Go
CREATE TABLE Areas (
	IDArea INT PRIMARY KEY,
	Descripcion NVARCHAR(100) NOT NULL
);

CREATE TABLE Empleados (
	IDEmpleado INT PRIMARY KEY,
	Apellido NVARCHAR(50) NOT NULL,
	Nombre NVARCHAR(50) NOT NULL,
	IDArea INT NOT NULL,
	FechaIngreso DATE NOT NULL,
	FOREIGN KEY (IDArea) REFERENCES Areas(IDArea)
);

CREATE TABLE Sueldos (
	IDEmpleado INT NOT NULL,
	FechaPago DATE NOT NULL,
	Sueldo DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (IDEmpleado, FechaPago),
	FOREIGN KEY (IDEmpleado) REFERENCES Empleados(IDEmpleado)
);

INSERT INTO Areas (IDArea, Descripcion) VALUES (1, 'Recursos Humanos');
INSERT INTO Areas (IDArea, Descripcion) VALUES (2, 'Sistemas');
INSERT INTO Areas (IDArea, Descripcion) VALUES (3, 'Contabilidad');

INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso) VALUES (101, 'González', 'María', 1, '2022-03-15');
INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso) VALUES (102, 'Pérez', 'Juan', 2, '2021-07-01');
INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso) VALUES (103, 'López', 'Ana', 2, '2023-01-10');
INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso) VALUES (104, 'Fernández', 'Carlos', 3, '2020-11-20');
INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso) VALUES (105, 'Ramírez', 'Lucía', 1, '2022-05-05');

INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (101, '2024-03-31', 150000.00);
INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (101, '2024-04-30', 152000.00);

INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (102, '2024-03-31', 200000.00);
INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (102, '2024-04-30', 205000.00);

INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (103, '2024-03-31', 180000.00);
INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (103, '2024-04-30', 182500.00);

INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (104, '2024-03-31', 170000.00);
INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (104, '2024-04-30', 172000.00);

INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (105, '2024-03-31', 155000.00);
INSERT INTO Sueldos (IDEmpleado, FechaPago, Sueldo) VALUES (105, '2024-04-30', 157000.00);