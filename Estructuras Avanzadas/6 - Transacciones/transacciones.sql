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
		VALUES (GETDATE(), @nroCuenta, @descripcion, @tipoMovimiento, @importe);

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
END;

-------------------------------------------------------------------------------
-- Para procedimientos que requieran obtener el ID autogenerado por IDENTITY --
-------------------------------------------------------------------------------

-- C�digo que est� en el material de estudio, no aplica a esta DB:
CREATE PROCEDURE spAgregarCliente (
    @nombre     VARCHAR(50),
    @apellido   VARCHAR(50),
    @sexo       CHAR,
    @idsucursal INT
)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Generamos el cliente
        INSERT INTO Clientes (nombre, apellido, sexo, idsucursal, estado)
        VALUES (@nombre, @apellido, @sexo, @idsucursal, 1);

        -- Obtenemos el ID del cliente reci�n insertado
        DECLARE @idCliente BIGINT;
        SET @idCliente = @@IDENTITY;

        -- Generamos el n�mero de cuenta
        DECLARE @nroCuenta BIGINT;
        SELECT @nroCuenta = MAX(nrocuenta) FROM Cuentas;

        -- Insertamos la cuenta del cliente
        INSERT INTO Cuentas (nrocuenta, idcliente, idtipocuenta, saldo, limite_descubierto, fecha_alta, fecha_baja, estado)
        VALUES (@nroCuenta + 1, @idCliente, 1, 0, 0, GETDATE(), NULL, 1);

        -- Generamos la tarjeta de d�bito
        INSERT INTO Tarjetas (nrotarjeta, idcliente, tipotarjeta, estado)
        VALUES ('D-' + CONVERT(NVARCHAR(10), @idCliente) + '-1', @idCliente, 'D', 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        PRINT 'QU� RARO, EN MI CASA FUNCIONA';
        ROLLBACK TRANSACTION;
    END CATCH
END;

-- Tambi�n se pueden ejecutar transacciones anidadas:
-- Usando la funcion global @@TRANCOUNT > 0 hacer rollback transaction en el bloque catch
-- Ejecutar el Procedimiento / Transacion 
CREATE PROCEDURE spAgregarCliente (
    @nombre     VARCHAR(50),
    @apellido   VARCHAR(50),
    @sexo       CHAR,
    @idsucursal INT
)
AS
BEGIN
    BEGIN TRANSACTION

    BEGIN TRY
        -- Generamos el cliente
        INSERT INTO Clientes (nombre, apellido, sexo, idsucursal, estado)
        VALUES (@nombre, @apellido, @sexo, @idsucursal, 1);

        -- Obtenemos el ID del cliente reci�n insertado
        DECLARE @idCliente BIGINT;
        SET @idCliente = @@IDENTITY;

        -- Generamos el n�mero de cuenta
        DECLARE @nroCuenta BIGINT;
        SELECT @nroCuenta = MAX(nrocuenta) FROM Cuentas;

        -- Insertamos la cuenta del cliente
        INSERT INTO Cuentas (nrocuenta, idcliente, idtipocuenta, saldo, limite_descubierto, fecha_alta, fecha_baja, estado)
        VALUES (@nroCuenta + 1, @idCliente, 1, 0, 0, GETDATE(), NULL, 1);

        -- Generamos la tarjeta de d�bito
        INSERT INTO Tarjetas (nrotarjeta, idcliente, tipotarjeta, estado)
        VALUES ('D-' + CONVERT(NVARCHAR(10), @idCliente) + '-1', @idCliente, 'D', 1);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
		IF @@TRANCOUNT > 0 BEGIN
			ROLLBACK TRANSACTION; -- Ejecutar el ROLLBACK solo una vez, si se ejecut� en la transaccion anidada, ya hizo rollback, y ROWCOUNT es 0
		END
        PRINT 'QU� RARO, EN MI CASA FUNCIONA';
    END CATCH
END;

-- Por cada BEGIN TRANSACTION, se suma + 1 al @@TRANSCOUNT, y por cada COMMIT hace -1, pero al