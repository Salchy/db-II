-- TP04

-- Algunos ejercicios quedaron en la netbook de mi trabajo:

-- Ejercicio 3:
-- Listar los nombres de archivos, extensi�n, tama�o expresado en Megabytes y el nombre
-- del tipo de archivo.
-- NOTA: En la tabla Archivos el tama�o est� expresado en Bytes
SELECT A.Nombre, A.Extension, A.Tama�o / 1024.0 / 1024.0 AS 'MB', TA.TipoArchivo
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo;

-- Ejercicio 4:
-- Listar los nombres de archivos junto a la extensi�n con el siguiente formato
-- 'NombreArchivo.extension'. Por ejemplo, 'Actividad.pdf'. S�lo listar aquellos cuyo
-- tipo de archivo contenga los t�rminos 'ZIP', 'Word', 'Excel', 'Javascript' o 'GIF'
SELECT A.Nombre + '.' + A.Extension AS 'Archivo' FROM Archivos AS A
	INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
WHERE TA.TipoArchivo LIKE '%ZIP%' 
	OR TA.TipoArchivo LIKE '%Word%'
	OR TA.TipoArchivo LIKE '%Excel%'
	OR TA.TipoArchivo LIKE '%JavaScript%'
	OR TA.TipoArchivo LIKE '%GIF%'

-- Ejercicio 5:
-- Listar los nombres de archivos, su extensi�n, el tama�o en megabytes y la fecha de 
-- creaci�n de aquellos archivos que le pertenezcan al usuario due�o con nombre 'Michael'
-- y apellido 'Williams'.
SELECT A.Nombre, A.Extension, ROUND(A.Tama�o / 1024.0 / 1024.0, 2) AS 'MB', FechaCreacion
FROM Archivos A
INNER JOIN Usuarios U ON A.IDUsuarioDue�o = U.IDTipoUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams';

-- Ejercicio 6:
-- Listar los datos completos del archivo m�s pesado del usuario due�o con nombre
-- 'Michael' y apellido 'Williams'. Si hay varios archivos que cumplen esa condici�n, listarlos a todos.
-- Creo que se hace con subconsultas, aun no lo vimos
SELECT *
FROM Archivos A
INNER JOIN Usuarios U ON A.IDUsuarioDue�o = U.IDTipoUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams';

-- Ejercicio 7:
-- Listar nombres de archivos, extensi�n, tama�o en bytes, fecha de creaci�n y de 
-- modificaci�n, apellido y nombre del usuario due�o de aquellos archivos cuya
-- descripci�n contengan el t�rmino 'empresa' o 'presupuesto'.
SELECT A.Nombre + ', ' + A.Extension AS 'Archivo', A.Tama�o, A.FechaCreacion, A.FechaUltimaModificacion,
U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
WHERE A.Descripcion LIKE '%empresa%' OR A.Descripcion LIKE '%presupuesto%';

-- Ejercicio 8:
-- Listar las extensiones sin repetir de los archivos cuyos usuarios due�os tengan tipo
-- de usuario 'Suscripci�n Plus', 'Suscripci�n Premium' o 'Suscripci�n Empresarial'
SELECT DISTINCT A.Extension FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario IN('Suscripci�n Plus', 'Suscripci�n Premium', 'Suscripci�n Empresarial');

