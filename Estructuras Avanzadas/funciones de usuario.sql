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

SELECT dbo.Calcular(2, 5) AS 'Resultado Suma';

CREATE FUNCTION dbo.CalcularAños(@fecha1 DATE, @fecha2 DATE)
RETURNS INT
AS
BEGIN
	DECLARE @años INT;
    
	-- Calcular la diferencia en años entre las dos fechas
	SET @años = DATEDIFF(YEAR, @fecha1, @fecha2);

	-- Restar un año si la persona aún no ha cumplido años en el año actual
    IF (MONTH(@fecha2) < MONTH(@fecha1))
        OR (MONTH(@fecha2) = MONTH(@fecha1) AND DAY(@fecha2) < DAY(@fecha1))
    BEGIN
        SET @años = @años - 1;
    END

	RETURN @años;
END;

SELECT dbo.CalcularAños('2000-06-27', GETDATE()) AS 'Edad';