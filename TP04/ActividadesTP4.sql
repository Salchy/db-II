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
SELECT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
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
SELECT A.Nombre + '.' + A.Extension AS 'Archivo', A.Tamaño, A.FechaCreacion, A.FechaUltimaModificacion,
U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE A.Descripcion LIKE '%empresa%' OR A.Descripcion LIKE '%presupuesto%';

-- Ejercicio 8:
-- Listar las extensiones sin repetir de los archivos cuyos usuarios dueños tengan tipo
-- de usuario 'Suscripción Plus', 'Suscripción Premium' o 'Suscripción Empresarial'
SELECT DISTINCT A.Extension
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario IN('Suscripción Plus', 'Suscripción Premium', 'Suscripción Empresarial');

-- Ejercicio 9:
-- Listar los apellidos y nombres de los usuarios dueños y el tamaño del archivo de los
-- tres archivos con extensión 'zip' más pesados. Puede ocurrir que el mismo usuario
-- aparezca varias veces en el listado.
SELECT TOP(3) U.Apellido + ', ' + U.Nombre AS 'Apellido y Nombre', A.Tamaño
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE A.Extension = 'zip'
ORDER BY A.Tamaño DESC;

-- Ejercicio 10:
-- Por cada archivo listar el nombre del archivo, la extensión, el tamaño en bytes, el
-- nombre del tipo de archivo y el tamaño calculado en su mayor expresión y la unidad
-- calculada. Siendo Gigabytes si al menos pesa un gigabyte, Megabytes si al menos pesa
-- un megabyte, Kilobyte si al menos pesa un kilobyte o en su defecto expresado en bytes.
-- Por ejemplo, si el archivo imagen.jpg pesa 40960 bytes entonces debe figurar 40 en
-- la columna Tamaño Calculado y 'Kilobytes' en la columna unidad.
SELECT A.Nombre + '.' + A.Extension AS 'Archivo', A.Tamaño, TA.TipoArchivo
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
-- No entiendo como hacer la consigna 'tamaño calculado en su mayor expresión y la unidad
-- calculada'

-- Ejercicio 11
-- Listar los nombres de archivo y extensión de los archivos que han sido compartidos.
SELECT DISTINCT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo;

-- Ejercicio 12:
-- Listar los nombres de archivo y extensión de los archivos que han sido compartidos a
-- usuarios con apellido 'Clarck' o 'Jones'
SELECT DISTINCT A.Nombre + '.' + A.Extension AS 'Archivo'
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido IN('Clarck', 'Jones');

-- Ejercicio 13:
-- Listar los nombres de archivo, extensión, apellidos y nombres de los usuarios a quienes
-- se le hayan compartido archivos con permiso de 'Escritura'
SELECT A.Nombre + '.' + A.Extension AS 'Fichero', U.Apellido, U.Nombre
FROM ArchivosCompartidos AS AC
INNER JOIN Archivos AS A ON AC.IDArchivo = A.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE AC.IDPermiso = 3;

-- Ejercicio 14:
-- Listar los nombres de archivos y extensión de los archivos que no han sido compartidos.
SELECT A.Nombre + '.' + A.Extension AS 'Archivos sin compartir'
FROM Archivos AS A
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
WHERE AC.IDArchivo IS NULL;

-- Ejercicio 15:
-- Listar los apellidos y nombres de los usuarios dueños que tienen archivos eliminados.
SELECT DISTINCT U.Nombre, U.Apellido
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDueño
WHERE A.Eliminado = 1;

-- Ejercicio 16:
-- Listar los nombres de los tipos de suscripciones, sin repetir, que tienen archivos que pesan al menos
-- 120 Megabytes.
SELECT DISTINCT TU.TipoUsuario
FROM TiposUsuario AS TU
INNER JOIN Usuarios AS U ON TU.IDTipoUsuario = U.IDTipoUsuario
INNER JOIN Archivos AS A ON U.IDUsuario = a.IDUsuarioDueño
WHERE A.Tamaño / 1024 / 1024 > 120;

-- Ejercicio 17:
-- Listar los apellidos y nombres de los usuarios dueños, nombre del archivo, extensión, fecha de creación,
-- fecha de modificación y la cantidad de días transcurridos desde la última modificación. Sólo incluir a
-- los archivos que se hayan modificado (fecha de modificación distinta a la fecha de creación).
SELECT U.Apellido + ', ' + U.Nombre AS 'Usuario', A.Nombre + '.' + A.Extension AS 'Fichero',
CAST(A.FechaCreacion AS DATE) AS 'Fecha de Creacion',
CAST(A.FechaUltimaModificacion AS DATE) AS 'Fecha De Modificacion',
DATEDIFF(DAY, A.FechaUltimaModificacion, GETDATE()) AS 'Dias desde Modificacion'
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDueño
WHERE A.FechaCreacion != A.FechaUltimaModificacion;

-- Ejercicio 18:
-- Listar nombres de archivos, extensión, tamaño, apellido y nombre del usuario dueño del archivo, apellido y
-- nombre del usuario que tiene el archivo compartido y el nombre de permiso otorgado.
SELECT 
	A.Nombre + '.' + A.Extension AS 'Fichero',
	A.Tamaño,
	U.Apellido + ', ' + U.Nombre AS 'Dueño',
	U2.Nombre + ', ' + U2.Apellido AS 'Compartido con',
	P.Nombre AS 'Permiso'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
INNER JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario;

-- Ejercicio 19:
-- Listar nombres de archivos, extensión, tamaño, apellido y nombre del usuario dueño del archivo, apellido y
-- nombre del usuario que tiene el archivo compartido y el nombre de permiso otorgado. Sólo listar aquellos
-- registros cuyos tipos de usuarios coincidan tanto para el dueño como para el usuario al que le comparten el
-- archivo.
SELECT 
	A.Nombre + '.' + A.Extension AS 'Fichero',
	A.Tamaño,
	U.Apellido + ', ' + U.Nombre AS 'Dueño',
	U2.Nombre + ', ' + U2.Apellido AS 'Compartido con',
	P.Nombre AS 'Permiso'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
INNER JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario
WHERE U.IDTipoUsuario = U2.IDTipoUsuario;

-- Ejercicio 20:
-- Apellido y nombre de los usuarios que tengan compartido o sean dueños del archivo con nombre 'Documento Legal'.
SELECT 
	U.Apellido + ', ' + U.Nombre AS 'Dueño',
	U2.Apellido + ', ' + U2.Nombre AS 'Compartido'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
LEFT JOIN Usuarios AS U2 ON AC.IDUsuario = U2.IDUsuario
WHERE A.Nombre = 'Documento Legal';