-- Ejemplo de transacciones:
-- Ejecutar bloques de c�digo como si fuera uno solo, o no ejecutar nada (atomicidad)
-- BEGIN TRANSACTION: Indica el comienzo del proceso de transacci�n:
-- COMMIT TRANSACTION: Indica la finalizacion de la transacci�n, enviar� todas las sentencias a la DB
-- ROLLBACK TRANSACTION: Indica que hay que deshacer los cambios sobre los datos ya que ha ocurrido un
-- error y se deber� dejar la base de datos en el estado previo a la ejecuci�n de la transacci�n.

CREATE PROCEDURE spRegistrarMovimiento(
    @nroCuenta VARCHAR(20),
    @tipoMovimiento CHAR,
    @descripcion VARCHAR(50),
    @importe DECIMAL(10, 2)
)
AS
BEGIN
    -- Comenzamos con el manejo de errores
    BEGIN TRY
        -- Comienza la transacci�n
        BEGIN TRANSACTION

        -- Verificamos si el tipo de movimiento es Extracci�n
        IF @tipoMovimiento = 'E' OR @tipoMovimiento = 'e'
        BEGIN
            -- Declaramos las variables
            DECLARE @saldo DECIMAL(10, 2)
            DECLARE @tipoCuenta INT
            DECLARE @descubierto DECIMAL(10, 2)

            -- Le asignamos valores que provienen de una consulta SQL
            IF (SELECT COUNT(*) FROM cuentas WHERE nroCuenta = @nroCuenta) = 1
            BEGIN
                SELECT 
                    @saldo = C.saldo, 
                    @tipoCuenta = C.idTipoCuenta, 
                    @descubierto = C.limite_descubierto
                FROM cuentas C 
                WHERE C.nroCuenta = @nroCuenta
            END
            ELSE
            BEGIN
                RAISERROR('NO EXISTE LA CUENTA', 16, 1)
            END

            -- Verificamos si se puede hacer la Extracci�n
            IF @saldo - @importe < 0 AND @tipoCuenta = 1
            BEGIN
                RAISERROR('NO SE PUEDE REALIZAR EL MOVIMIENTO, SALDO ES INSUFICIENTE', 16, 1)
            END

            IF @saldo - @importe < (0 - @descubierto) AND @tipoCuenta = 2
            BEGIN
                RAISERROR('NO SE PUEDE REALIZAR EL MOVIMIENTO, SALDO ES INSUFICIENTE', 16, 1)
            END
        END

       -- Registramos el movimiento en la tabla de Movimientos
        INSERT INTO movimientos (fecha, nrocuenta, descripcion, tipomovimiento, importe)
		VALUES (GETDATE(), @nroCuenta, @descripcion, @tipoMovimiento, @importe)

        -- Si es Extracci�n el importe debe restarse
        IF @tipoMovimiento = 'E' OR @tipoMovimiento = 'e'
        BEGIN
            SET @importe = @importe * -1
        END

        -- Actualizamos el saldo de la cuenta
        UPDATE cuentas 
        SET saldo = saldo + @importe 
        WHERE nroCuenta = @nroCuenta

        -- Si no actualiz� ninguna fila
        IF @@ROWCOUNT = 0 -- funcion global para obtener los rows que fueron afectados
        BEGIN
            RAISERROR('OCURRIO UN ERROR', 16, 1)
        END

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        ROLLBACK TRANSACTION -- Revierte todos los cambios de datos, que fueron modificados dentro de la TRANSACTION
    END CATCH
    -- Finaliza el manejo de errores
END