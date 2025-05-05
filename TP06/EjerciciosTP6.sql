-- Ejercicios TP 6

-- Ejercicio 1: Los nombres y extensiones y tama�o en Megabytes de los archivos que pesen m�s
-- que el promedio de archivos.
SELECT A.Nombre, A.Extension, A.Tama�o / 1024.0 / 1024.0 AS 'MB'
FROM Archivos AS A
WHERE A.Tama�o > (SELECT AVG(A2.Tama�o * 1.0) FROM Archivos AS A2);

-- Ejercicio 2: Los usuarios indicando apellido y nombre que no sean due�os de ning�n
-- archivo con extensi�n 'zip'.
SELECT DISTINCT U.Apellido + ', ' + U.Nombre AS 'Usuarios Sin Archivos zip'
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDue�o
WHERE U.IDUsuario NOT IN (SELECT A2.IDUsuarioDue�o
	FROM Archivos AS A2
	WHERE A2.Extension = 'zip'
);

-- Ejercicio 3: Los usuarios indicando IDUsuario, apellido, nombre y tipo de usuario que
-- no hayan creado ni modificado ning�n archivo en el a�o actual.
SELECT U.IDUsuario, U.Apellido + ', ' + U.Nombre AS 'Usuario', TU.TipoUsuario
FROM Usuarios AS U
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE U.IDUsuario NOT IN (SELECT U2.IDUsuario
	FROM Usuarios AS U2
	INNER JOIN Archivos AS A2 ON U2.IDUsuario = A2.IDUsuarioDue�o
	WHERE YEAR(A2.FechaUltimaModificacion) = YEAR(GETDATE()) OR YEAR(A2.FechaCreacion) = YEAR(GETDATE())
);

-- Ejercicio 4: Los tipos de usuario que no registren usuario con archivos eliminados.
SELECT DISTINCT TU.TipoUsuario
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDue�o
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario NOT IN(
	SELECT DISTINCT TU2.TipoUsuario
	FROM Usuarios AS U2
	INNER JOIN Archivos AS A2 ON U2.IDUsuario = A2.IDUsuarioDue�o
	INNER JOIN TiposUsuario AS TU2 ON U2.IDTipoUsuario = TU2.IDTipoUsuario
	WHERE A2.Eliminado = 1
);

-- Ejercicio 5: Los tipos de archivos que no se hayan compartido con el permiso de 'Lectura'
SELECT DISTINCT TA.TipoArchivo
FROM TiposArchivos AS TA
WHERE TA.TipoArchivo NOT IN(
	SELECT DISTINCT TA.TipoArchivo
	FROM ArchivosCompartidos AS AC
	INNER JOIN Archivos AS A ON AC.IDArchivo = A.IDArchivo
	INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
	INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
	WHERE P.Nombre = 'Lectura'
);

-- Ejercicio 6: Los nombres y extensiones de los archivos que tengan un tama�o mayor al del archivo con extensi�n 
-- 'xls' m�s grande.


-- Ejercicio 7: Los nombres y extensiones de los archivos que tengan un tama�o mayor al del archivo con extensi�n 'zip' m�s peque�o.


-- Ejercicio 8: Por cada tipo de archivo indicar el tipo y la cantidad de archivos eliminados y la cantidad de archivos no eliminados.


-- Ejercicio 9 Por cada usuario indicar el IDUsuario, el apellido, el nombre, la cantidad de archivos peque�os (menos de 20MB) y la cantidad de archivos grandes (20MBs o m�s)


-- Ejercicio 10 Por cada usuario indicar el IDUsuario, el apellido, el nombre y la cantidad de archivos creados en el a�o 2022, la cantidad en el a�o 2023 y la cantidad creados en el 2024.


-- Ejercicio 11 Los archivos que fueron compartidos con permiso de 'Comentario' pero no con permiso de 'Lectura'


-- Ejercicio 12 Los tipos de archivos que registran m�s archivos eliminados que no eliminados.


-- Ejercicio 13 Los usuario que registren m�s archivos peque�os que archivos grandes (pero que al menos registren un archivo de cada uno)


-- Ejercicio 14 Los usuarios que hayan creado m�s archivos en el 2022 que en el 2023 y en el 2023 que en el 2024.

