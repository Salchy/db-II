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