-- TRIGGERS:
-- Nos permite ejecutar comandos de manera desatendida de manera automática, se ejecutará cuando
-- suceda algún tipo de acción en la base de datos.
-- Se los conocen como desencadenadores

-- Para los DML: (Data Manipulation)
-- Se ejecutan cuando hay un INSERT, UPDATE o DELETE:

-- AFTER: El trigger se ejecuta después del INSERT, UPDATE o DELETE
-- Syntax: AFTER [INSERT / UPDATE / DELETE]

-- INSTEAD OF: Las acciones se ejecutan en lugar de la accion original de INSERT, UPDATE o DELETE
-- Syntax: INSTEAD OF [INSERT / UPDATE / DELETE]

-- Acá entran en juego, 2 tablas temporales dentro de la estructura del trigger:
-- INSERTED y DELETED:
-- Son tablas temporales, que va ejecutando el trigger, durante la ejecución del trigger, luego cuando hace COMIT, manda los datos de esa tabla temporal, a la tabla original del trigger.
-- Esto nos permite realizar consultas en esa subtabla, que nos pueden servir para almacenarlas en variables, o manipular otros datos de otras tablas por ejemplo, en el caso que sean claves foraneas de otras tablas.
-- En el caso del trigger UPDATE, se almacenan datos en las 2 tablas temporales, en la de INSERTED, los nuevos datos, y en la de DELETED los datos actuales, que van a ser actualizados por los nuevos.

CREATE TRIGGER nombreTrigger ON [TABLA]
INSTEAD OF DELETE -- También puede ser AFTER DELETE
AS
BEGIN
	-- Acciones a ejecutar al desencadenar el trigger
	UPDATE Sucursales SET estado = 0 WHERE idsucursal IN (SELECT idsucursal FROM deleted);
END

-- Supongamos otro ejemplo, en el que el banco quisiera impedir que un cliente tenga más de una tarjeta de débito. Esto quiere decir que cuando insertamos un registro de tarjeta y
-- si es de débito debemos sólo hacer el insert si el cliente no posee otra registrada.
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

-- Para evitar la eliminacion física de manera accidental, y haga una baja lógica:
CREATE TRIGGER tr_Eliminar_Sucursal ON Sucursales
INSTEAD OF DELETE -- En lugar de DELETE, reemplaza la instruccion DELETE hacia la tabla Sucursales
AS
BEGIN
	UPDATE Sucursales SET estado = 0 WHERE idsucursal IN (SELECT idsucursal FROM deleted); -- Nótese la utilizacion de la tabla temporal DELTED en una subconsulta para obtener el ID de sucursal que se quiere 'eliminar'.
END

-- Al ser un trigger (Evento) se ejecuta al llamarse a una eliminacion:
DELETE FROM Sucursales;

-------------------------------
-- MODIFICACION DE TRIGGERS  --
-------------------------------

ALTER TRIGGER nombre_trigger
ON nombre_tabla
{ AFTER | INSTEAD OF }
{ INSERT | UPDATE | DELETE }
AS
BEGIN
  sentencia_sql_1
  sentencia_sql_2
  sentencia_sql_N
END

------------------------------
-- ELIMINACION DE TRIGGERS  --
------------------------------

DROP TRIGGER nombre_trigger

--------------------------
-- DESACTIVAR TRIGGERS  --
--------------------------

-- Deshabilitar:
DISABLE TRIGGER nombre_trigger ON nombre_objeto

-- Habilitar:
ENABLE TRIGGER nombre_trigger ON nombre_objeto