-- Procedimientos almacenados
-- Son rutinas complejas que se almacenan en el servidor de Base de Datos.
-- Esto ofrece una gran ventaja, ya que la lógica está en el motor, y puede recibir llamados desde cualquier aplicacion o lenguaje,
-- y el servidor de base de datos ejecutaría el procemmdimiento, y devolvería los datos al que lo llamó. Abstrayendo de la lógica SQL al lenguaje o aplicacion
-- La aplicacion llama al procedimiento, y el procedimiento hace las peticiones a la base de datos.
-- Puede ejecutar multiples acciones, muy útil para automatizar tareas que demanden mucha lógica e insersiones de datos.

CREATE PROCEDURE sp_NombreProcedimiento AS
BEGIN
	-- CONSULTA SQL
END

-- También puede recibir argumentos:
CREATE PROCEDURE sp_NombreProcedimiento (@arg1 INT, @arg2 NVARCHAR(50)) AS
BEGIN
	-- CONSULTA SQL
END

-- Para ejecutar el procedimiento:
EXEC sp_NombreProcedimiento;

-- Para alterar o modificar un prodecimiento:
ALTER PROCEDURE sp_NombreProcedimiento AS
BEGIN
	-- CONSULTA SQL
END

-- Para borrar un procedimiento:
DROP PROCEDURE sp_NombreProcedimiento;

------------ EJERCITACION ------------

-- Creo el procedimiento
CREATE PROCEDURE SP_OBTENER_EMPLEADOS
AS
BEGIN
	SELECT * FROM Empleados
END

-- Lo ejecuto:
EXEC SP_OBTENER_EMPLEADOS;

---- EJEMPLO USANDO UPDATE ----

-- Por ejemplo, puedo crear un procedimiento, para actualizar un stock:

-- Es un ejemplo del contenido de la materia, va a fallar en esta db
-- Creo el procedimiento
CREATE PROCEDURE SP_AGREGAR_STOCK(
	@IDARTICULO BIGINT,
	@CANTIDAD INT
)
AS
BEGIN
	UPDATE ARTICULOS SET STOCK = STOCK + @CANTIDAD
	WHERE IDARTICULO = @IDARTICULO
END

-- ORDEN DE LOS ARGUMENTOS: IDARTICULO, CANTIDAD
EXEC SP_AGREGAR_STOCK 1, 6

-- (Se puede editar un procedimiento, desde la instruccion ALTER PROCEDURE)
-- Incluir condiciones para mejorar la lógica (NO permitir ingreso de números negativos)
