-- Funciones de usuario:
-- Son un bloque de c�digo SQL que puede ser reutilizado desde diferentes partes. (Como funciones)
SELECT * FROM Sueldos;

CREATE FUNCTION dbo.Calcular(@arg1 INT, @arg2 INT)
RETURNS INT
AS
BEGIN
	-- Declaro la variable 'resultado' como INT
	DECLARE @resultado INT;

	-- Asigno el valor del resultado de arg1 + arg2 a la variable 'resultado'
	SET @resultado = @arg1 + @arg2;

	-- Resto de l�gica, pueden ir IF, etc.
	RETURN @resultado;
END

SELECT dbo.Calcular(2, 5) AS 'Resultado Suma';

CREATE FUNCTION dbo.CalcularA�os(@fecha1 DATE, @fecha2 DATE)
RETURNS INT
AS
BEGIN
	DECLARE @a�os INT;
    
	-- Calcular la diferencia en a�os entre las dos fechas
	SET @a�os = DATEDIFF(YEAR, @fecha1, @fecha2);

	-- Restar un a�o si la persona a�n no ha cumplido a�os en el a�o actual
    IF (MONTH(@fecha2) < MONTH(@fecha1))
        OR (MONTH(@fecha2) = MONTH(@fecha1) AND DAY(@fecha2) < DAY(@fecha1))
    BEGIN
        SET @a�os = @a�os - 1;
    END

	RETURN @a�os;
END;

SELECT dbo.CalcularA�os('2000-06-27', GETDATE()) AS 'Edad';