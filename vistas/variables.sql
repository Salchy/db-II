-- Variables:

-- Creo o declaro una variable:
DECLARE @nombre VARCHAR(30);
DECLARE @edad INT;

-- Les doy un valor:
SET @nombre = 'Leandro';
SET @edad = 24;

-- Las puedo mostrar:
PRINT @nombre;
PRINT @edad;

-- También sirve de esta forma:
SELECT @nombre AS 'Nombre';
GO
---------------------------

-- Consultas con variables:

DECLARE @nombre NVARCHAR(50);
DECLARE @apellido NVARCHAR(50);
DECLARE @area NVARCHAR(50);

SELECT @nombre = E.Nombre, @apellido = E.Apellido, @area = A.IDArea
FROM Empleados AS E
INNER JOIN Areas AS A ON E.IDArea = A.IDArea;

SELECT @apellido + ', ' + @nombre AS 'Empleado', @area AS 'Area';
GO