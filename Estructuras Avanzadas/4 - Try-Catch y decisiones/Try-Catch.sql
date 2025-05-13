-- Estructura Try-Catch
BEGIN TRY
	-- Instrucciones a ejecutar.
	-- Si alguna instrucci�n de ac� genera un error, salta al CATCH
END TRY
BEGIN CATCH
	-- Instrucciones a ejecutar en caso de un eventual error en el TRY
END CATCH

----------------------

-- RAISEERROR
-- Se utiliza para generar un mensaje de error
-- RAISEERROR({c�digo | mensaje}, {gravedad, estado})
-- C�digo: Se puede establecer un c�digo existente en la tabla de sysmessages.
-- Mensaje: Mensaje de error a mostrar.
-- Gravedad: Especifica la gravedad del error, (0 - 24) Normalmente entre 11 y 16, pero menor que 18, ya que eso indica un error grave, haciendo que se cierre la conexi�n.
-- Estado: Permite establecer el origen/contexto del error. Se usa para asociar con la documentaci�n de la aplicaci�n

-- WITH LOG 
-- Sirve para generar un registro en la carpeta logs de la base de datos:
-- RAISEERROR({c�digo | mensaje}, {gravedad, estado}) WITH LOG;

-- ERROR_MESSAGE()
-- Devuelve el mensaje de error producido de una consulta con resultado negativo:

SELECT * FROM Empleados;

BEGIN TRY
	INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso)
	VALUES (106, 'Correa', 'Leandro', 3, GETDATE())
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH