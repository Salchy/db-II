-- Funciones globales:
-- @@ROWCOUNT, @@ERROR, @@IDENTITY

-- ROWCOUNT
-- Devuelve la cantidad de filas que fueron modificadas en la consulta anterior:
SELECT * FROM Empleados;
SELECT @@ROWCOUNT;

-- IDENTITY
-- Nos devuelve el ultimo id generado por la instruccion identity, de la �ltima consulta:
-- INSERT BLA LA
SELECT @@IDENTITY

-- ERROR
-- Nos muestra el c�digo de error de la consulta anterior, si la tuviese, si no hay error, retorna 0:
SELECT @@ERROR