-- TRIGGERS:
-- Nos permite ejecutar comandos de manera desatendida de manera automática, se ejecutará cuando
-- suceda algún tipo de acción en la base de datos.
-- Se los conocen como desencadenadores

-- Para los DML: (Data Manipulation)
-- Se ejecutan cuando hay un INSERT, UPDATE o DELETE:

-- AFTER: El trigger se ejecuta después del INSERT, UPDATE o DELETE
-- Syntax: AFTER [INSERT / UPDATE / DELETE]
-- INSTEAD OF: Las acciones se ejecutan en lugar de la accion de INSERT, UPDATE o DELETE
-- Syntax: INSTEAD OF [INSERT / UPDATE / DELETE]

CREATE TRIGGER nombreTrigger ON [TABLA]
INSTEAD OF DELETE -- También puede ser AFTER DELETE
AS
BEGIN
	-- Acciones a ejecutar al desencadenar el trigger
	UPDATE Sucursales SET estado = 0 WHERE idsucursal IN (SELECT idsucursal FROM deleted);
END

-- Supongamos otro ejemplo, en el que el banco quisiera impedir que un cliente tenga más de una tarjeta de débito. Esto quiere decir que cuando insertamos un registro de tarjeta y si es de débito debemos sólo hacer el insert si el cliente no posee otra registrada.

CREATE TRIGGER tr_TarjetaDebito ON Tarjetas
INSTEAD OF INSERT
AS
BEGIN
    IF (SELECT tipotarjeta FROM inserted) = 'D'
    BEGIN
        IF (SELECT COUNT(*) FROM Tarjetas WHERE tipotarjeta = 'D' AND idCliente IN (SELECT idcliente FROM inserted)) = 1
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END

    INSERT INTO Tarjetas (nrotarjeta, idcliente, tipotarjeta, estado)
    SELECT nrotarjeta, idcliente, tipotarjeta, estado
    FROM inserted;
END;
