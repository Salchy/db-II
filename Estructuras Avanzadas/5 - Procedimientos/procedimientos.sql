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
CREATE PROCEDURE SP_AGREGAR_EMPLEADO(
	@idEmpleado INT,
	@Apellido NVARCHAR(50),
	@Nombre NVARCHAR(50),
	@IDArea INT,
	@FechaIngreso DATE
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Empleados (IDEmpleado, Apellido, Nombre, IDArea, FechaIngreso)
		VALUES (@idEmpleado, @Apellido, @Nombre, @IDArea, @FechaIngreso)
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END

-- Lo ejecuto:
DECLARE @fecha DATE = GETDATE();
EXEC SP_AGREGAR_EMPLEADO 107, 'Bileni', 'Francisco', 3, @fecha

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

------------------------------------------

-- Ejemplo del material de estudio, no aplicable a esta database.
CREATE PROCEDURE spRegistrarMovimiento(
	@nroCuenta VARCHAR(20),
	@tipoMovimiento CHAR,
	@descripcion VARCHAR(50),
	@importe DECIMAL(10, 2)
)
AS
BEGIN
	--Comenzamos con el manejo de errores
	BEGIN TRY
		--Verificamos si el tipo de movimiento es Extracción
		IF @tipoMovimiento = 'E' OR @tipoMovimiento ='e'
		BEGIN
		--Declaramos las variables
			DECLARE @saldo DECIMAL(10, 2)
			DECLARE @tipoCuenta INT
			DECLARE @descubierto DECIMAL(10, 2)
			--Le asignamos valores que provienen de una consulta SQL
			SELECT @saldo = C.saldo, @tipoCuenta = C.idTipoCuenta, @descubierto = C.limite_descubierto
			FROM cuentas C
			WHERE C.nroCuenta = @nroCuenta

			--Verificamos si se puede hacer la Extracción
			IF @saldo - @importe < 0 AND @tipoCuenta = 1
			BEGIN
				RAISERROR ('NO SE PUEDE REALIZAR EL MOVIMIENTO, SALDO ES INSUFICIENTE', 16, 1)
			END
			IF @saldo - @importe < (0 - @descubierto)
			BEGIN
				RAISERROR ('NO SE PUEDE REALIZAR EL MOVIMIENTO, SALDO ES INSUFICIENTE', 16, 1)
			END
		END
		--Registramos el movimiento en la tabla de Movimientos
		INSERT INTO movimientos (fecha, nrocuenta, descripcion, tipomovimiento, importe) VALUES(GETDATE(), @nroCuenta, @descripcion, @tipoMovimiento, @importe)
		--Si es Extracción el importe debe restarse
		IF @tipoMovimiento = 'E' OR @tipoMovimiento = 'e'
		BEGIN
			SET @importe = @importe * -1
		END
		--Actualizamos el saldo de la cuenta
		UPDATE cuentas SET saldo = saldo + @importe WHERE nroCuenta = @nroCuenta
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END