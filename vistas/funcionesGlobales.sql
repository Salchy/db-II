-- Funciones globales:
-- @@ROWCOUNT, @@ERROR, @@IDENTITY

-- ROWCOUNT
-- Devuelve la cantidad de filas que fueron modificadas en la consulta anterior:
SELECT * FROM Empleados;
SELECT @@ROWCOUNT;

-- IDENTITY
SELECT @@IDENTITY