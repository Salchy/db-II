-- Estructura de decision (IF)

DECLARE @order BIT;
SET @order = 1;

IF @order = 1 BEGIN
	SELECT * FROM Empleados ORDER BY Apellido ASC;
END
ELSE BEGIN
	SELECT * FROM Empleados ORDER BY Apellido DESC;
END
GO