-- TP04

-- Algunos ejercicios quedaron en la netbook de mi trabajo:

-- Ejercicio 3:
-- Listar los nombres de archivos, extensión, tamaño expresado en Megabytes y el nombre
-- del tipo de archivo.
-- NOTA: En la tabla Archivos el tamaño está expresado en Bytes
SELECT A.Nombre, A.Extension, A.Tamaño / 1024.0 / 1024.0 AS 'MB', TA.TipoArchivo
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo;

-- Ejercicio 4:
-- Listar los nombres de archivos junto a la extensión con el siguiente formato
-- 'NombreArchivo.extension'. Por ejemplo, 'Actividad.pdf'. Sólo listar aquellos cuyo
-- tipo de archivo contenga los términos 'ZIP', 'Word', 'Excel', 'Javascript' o 'GIF'
SELECT A.Nombre + '.' + A.Extension AS 'Archivo' FROM Archivos AS A
	INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
WHERE TA.TipoArchivo LIKE '%ZIP%' 
	OR TA.TipoArchivo LIKE '%Word%'
	OR TA.TipoArchivo LIKE '%Excel%'
	OR TA.TipoArchivo LIKE '%JavaScript%'
	OR TA.TipoArchivo LIKE '%GIF%'

-- Ejercicio 5:
-- Listar los nombres de archivos, su extensión, el tamaño en megabytes y la fecha de 
-- creación de aquellos archivos que le pertenezcan al usuario dueño con nombre 'Michael'
-- y apellido 'Williams'.
SELECT A.Nombre, A.Extension, ROUND(A.Tamaño / 1024.0 / 1024.0, 2) AS 'MB', FechaCreacion
FROM Archivos A
INNER JOIN Usuarios U ON A.IDUsuarioDueño = U.IDTipoUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams';

-- Ejercicio 6:
-- Listar los datos completos del archivo más pesado del usuario dueño con nombre
-- 'Michael' y apellido 'Williams'. Si hay varios archivos que cumplen esa condición, listarlos a todos.
-- Creo que se hace con subconsultas, aun no lo vimos
SELECT *
FROM Archivos A
INNER JOIN Usuarios U ON A.IDUsuarioDueño = U.IDTipoUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams';

-- Ejercicio 7:
-- Listar nombres de archivos, extensión, tamaño en bytes, fecha de creación y de 
-- modificación, apellido y nombre del usuario dueño de aquellos archivos cuya
-- descripción contengan el término 'empresa' o 'presupuesto'.
SELECT A.Nombre + ', ' + A.Extension AS 'Archivo', A.Tamaño, A.FechaCreacion, A.FechaUltimaModificacion,
U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE A.Descripcion LIKE '%empresa%' OR A.Descripcion LIKE '%presupuesto%';

-- Ejercicio 8:
-- Listar las extensiones sin repetir de los archivos cuyos usuarios dueños tengan tipo
-- de usuario 'Suscripción Plus', 'Suscripción Premium' o 'Suscripción Empresarial'
SELECT DISTINCT A.Extension FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario IN('Suscripción Plus', 'Suscripción Premium', 'Suscripción Empresarial');

