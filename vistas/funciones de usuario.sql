-- Funciones de usuario:
-- Son un bloque de código SQL que puede ser reutilizado desde diferentes partes. (Como funciones)
SELECT * FROM Sueldos;

CREATE FUNCTION dbo.Calcular(@arg1 INT, @arg2 INT)
RETURNS INT
AS
BEGIN
	-- Declaro la variable 'resultado' como INT
	DECLARE @resultado INT;

	-- Asigno el valor del resultado de arg1 + arg2 a la variable 'resultado'
	SET @resultado = @arg1 + @arg2;

	-- Resto de lógica, pueden ir IF, etc.
	RETURN @resultado;
END