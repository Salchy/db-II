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
SELECT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
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
SELECT A.Nombre + '.' + A.Extension AS 'Archivo', A.Tama�o, A.FechaCreacion, A.FechaUltimaModificacion,
U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
WHERE A.Descripcion LIKE '%empresa%' OR A.Descripcion LIKE '%presupuesto%';

-- Ejercicio 8:
-- Listar las extensiones sin repetir de los archivos cuyos usuarios due�os tengan tipo
-- de usuario 'Suscripci�n Plus', 'Suscripci�n Premium' o 'Suscripci�n Empresarial'
SELECT DISTINCT A.Extension
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario IN('Suscripci�n Plus', 'Suscripci�n Premium', 'Suscripci�n Empresarial');

-- Ejercicio 9:
-- Listar los apellidos y nombres de los usuarios due�os y el tama�o del archivo de los
-- tres archivos con extensi�n 'zip' m�s pesados. Puede ocurrir que el mismo usuario
-- aparezca varias veces en el listado.
SELECT TOP(3) U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre', A.Tama�o
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
WHERE A.Extension = 'zip'
ORDER BY A.Tama�o DESC;

-- Ejercicio 10:
-- Por cada archivo listar el nombre del archivo, la extensi�n, el tama�o en bytes, el
-- nombre del tipo de archivo y el tama�o calculado en su mayor expresi�n y la unidad
-- calculada. Siendo Gigabytes si al menos pesa un gigabyte, Megabytes si al menos pesa
-- un megabyte, Kilobyte si al menos pesa un kilobyte o en su defecto expresado en bytes.
-- Por ejemplo, si el archivo imagen.jpg pesa 40960 bytes entonces debe figurar 40 en
-- la columna Tama�o Calculado y 'Kilobytes' en la columna unidad.
SELECT A.Nombre + '.' + A.Extension AS 'Archivo', A.Tama�o, TA.TipoArchivo
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
-- No entiendo como hacer la consigna 'tama�o calculado en su mayor expresi�n y la unidad
-- calculada'

-- Ejercicio 11
-- Listar los nombres de archivo y extensi�n de los archivos que han sido compartidos.
SELECT DISTINCT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo;

-- Ejercicio 12:
-- Listar los nombres de archivo y extensi�n de los archivos que han sido compartidos a
-- usuarios con apellido 'Clarck' o 'Jones'
SELECT DISTINCT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido IN('Clarck', 'Jones');

-- Ejercicio 13:
-- Listar los nombres de archivo, extensi�n, apellidos y nombres de los usuarios a quienes
-- se le hayan compartido archivos con permiso de 'Escritura'
SELECT A.Nombre + '.' + A.Extension AS 'Fichero', U.Apellido, U.Nombre
FROM ArchivosCompartidos AS AC
INNER JOIN Archivos AS A ON AC.IDArchivo = A.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE AC.IDPermiso = 3;

-- Ejercicio 14:
-- Listar los nombres de archivos y extensi�n de los archivos que no han sido compartidos.
SELECT A.Nombre + '.' + A.Extension AS 'Archivos sin compartir'
FROM Archivos AS A
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
WHERE AC.IDArchivo IS NULL;

-- Ejercicio 15:
-- Listar los apellidos y nombres de los usuarios due�os que tienen archivos eliminados.
SELECT DISTINCT U.Nombre, U.Apellido
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDue�o
WHERE A.Eliminado = 1;

-- Ejercicio 16:
-- Listar los nombres de los tipos de suscripciones, sin repetir, que tienen archivos que pesan al menos
-- 120 Megabytes.
SELECT DISTINCT TU.TipoUsuario
FROM TiposUsuario AS TU
INNER JOIN Usuarios AS U ON TU.IDTipoUsuario = U.IDTipoUsuario
INNER JOIN Archivos AS A ON U.IDUsuario = a.IDUsuarioDue�o
WHERE A.Tama�o / 1024 / 1024 > 120;

-- Ejercicio 17:
-- Listar los apellidos y nombres de los usuarios due�os, nombre del archivo, extensi�n, fecha de creaci�n,
-- fecha de modificaci�n y la cantidad de d�as transcurridos desde la �ltima modificaci�n. S�lo incluir a
-- los archivos que se hayan modificado (fecha de modificaci�n distinta a la fecha de creaci�n).
SELECT U.Apellido + ', ' + U.Nombre AS 'Usuario', A.Nombre + '.' + A.Extension AS 'Fichero',
CAST(A.FechaCreacion AS DATE) AS 'Fecha de Creacion',
CAST(A.FechaUltimaModificacion AS DATE) AS 'Fecha De Modificacion',
DATEDIFF(DAY, A.FechaUltimaModificacion, GETDATE()) AS 'Dias desde Modificacion'
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDue�o
WHERE A.FechaCreacion != A.FechaUltimaModificacion;

-- Ejercicio 18:
-- Listar nombres de archivos, extensi�n, tama�o, apellido y nombre del usuario due�o del archivo, apellido y
-- nombre del usuario que tiene el archivo compartido y el nombre de permiso otorgado.
SELECT 
	A.Nombre + '.' + A.Extension AS 'Fichero',
	A.Tama�o,
	U.Apellido + ', ' + U.Nombre AS 'Due�o',
	U2.Nombre + ', ' + U2.Apellido AS 'Compartido con',
	P.Nombre AS 'Permiso'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
INNER JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario;

-- Ejercicio 19:
-- Listar nombres de archivos, extensi�n, tama�o, apellido y nombre del usuario due�o del archivo, apellido y
-- nombre del usuario que tiene el archivo compartido y el nombre de permiso otorgado. S�lo listar aquellos
-- registros cuyos tipos de usuarios coincidan tanto para el due�o como para el usuario al que le comparten el
-- archivo.
SELECT 
	A.Nombre + '.' + A.Extension AS 'Fichero',
	A.Tama�o,
	U.Apellido + ', ' + U.Nombre AS 'Due�o',
	U2.Nombre + ', ' + U2.Apellido AS 'Compartido con',
	P.Nombre AS 'Permiso'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
INNER JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario
WHERE U.IDTipoUsuario = U2.IDTipoUsuario;

-- Ejercicio 20:
-- Apellido y nombre de los usuarios que tengan compartido o sean due�os del archivo con nombre 'Documento Legal'.
SELECT 
	U.Apellido + ', ' + U.Nombre AS 'Due�o',
	U2.Apellido + ', ' + U2.Nombre AS 'Compartido'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDue�o = U.IDUsuario
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
LEFT JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario
WHERE A.Nombre = 'Documento Legal';