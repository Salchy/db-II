-- TP 5

-- Ejercicio 1 - La cantidad de archivos con extensión zip.
SELECT COUNT(*) AS 'Archivos ZIP'
FROM Archivos
WHERE Extension = 'zip';

-- Ejercicio 2 - La cantidad de archivos que fueron modificados y, por lo tanto, su fecha de última modificación no es la misma que la fecha de creación.
SELECT COUNT (*) AS 'Archivos Modificados'
FROM Archivos
WHERE FechaCreacion != FechaUltimaModificacion;

-- Ejercicio 3 - La fecha de creación más antigua de los archivos con extensión pdf.
SELECT MIN(FechaCreacion) AS 'Fecha mas antigua .PDF'
FROM Archivos
WHERE Extension = 'pdf';

-- Ejercicio 4 - La cantidad de extensiones distintas cuyos archivos tienen en su nombre o en su descripción la palabra 'Informe' o 'Documento'.
SELECT COUNT(DISTINCT Extension) AS 'Cantidad extensiones'
FROM Archivos
WHERE Nombre LIKE '%informe%' OR Descripcion LIKE '%Documento%';

-- Ejercicio 5 - El promedio de tamaño (expresado en Megabytes) de los archivos con extensión 'doc', 'docx', 'xls', 'xlsx'.
SELECT ROUND(AVG(Tamaño) / 1024.0 / 1024.0, 4) AS 'Promedio (MB)'
FROM Archivos
WHERE Extension IN ('doc', 'docx', 'xls', 'xlsx');

-- Ejercicio 6 - La cantidad de archivos que le fueron compartidos al usuario con apellido 'Clarck'
SELECT COUNT(*) AS 'Cantidad Comp. a Clark'
FROM ArchivosCompartidos AS AC
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido = 'Clarck';

-- Ejercicio 7 - La cantidad de tipos de usuario que tienen asociado usuarios que registren, como dueños, archivos con extensión pdf.
SELECT COUNT(DISTINCT TU.TipoUsuario)
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE A.IDUsuarioDueño = U.IDUsuario AND A.Extension = 'pdf';

-- Ejercicio 8 - El tamaño máximo expresado en Megabytes de los archivos que hayan sido creados en el año 2024.
SELECT MAX(Tamaño) / 1024.0 / 1024.0 AS 'Tamaño maximo (MB)'
FROM Archivos
WHERE YEAR(FechaCreacion) = 2024;

-- Ejercicio 9 - El nombre del tipo de usuario y la cantidad de usuarios distintos de dicho tipo que registran, como
-- dueños, archivos con extensión pdf.
SELECT DISTINCT TU.TipoUsuario, COUNT(DISTINCT U.IDUsuario)
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE A.Extension = 'pdf' AND A.IDUsuarioDueño = U.IDUsuario
GROUP BY TU.TipoUsuario; -- Agrupamos los resultados por tipo de usuario

-- Ejercicio 10 - El nombre y apellido de los usuarios dueños y la suma total del tamaño de los archivos que tengan
-- compartidos con otros usuarios. Mostrar ordenado de mayor sumatoria de tamaño a menor.

-- Analisis
-- Necesito obtener el Nombre y Apellido (Tabla Usuarios) de los dueños de los Archivos (Tabla Archivos)
-- sumatoria total del tamaño de los archivos: (SUM de los Tamaños de los archivos que se encuentren compartidos (Tabla ArchivosCompartidos))
SELECT U.Nombre, U.Apellido, ROUND(SUM(A.Tamaño) / 1024.0 / 1024.0, 4) AS 'Sumatoria de MB'
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
GROUP BY U.Nombre, U.Apellido
ORDER BY SUM(A.Tamaño) DESC;

-- Ejercicio 11 - El nombre del tipo de archivo y el promedio de tamaño de los archivos que corresponden a dicho
-- tipo de archivo.
SELECT TA.TipoArchivo, ROUND((AVG(A.Tamaño) * 1.0) / 1024.0 / 1024.0, 4) AS 'Promedio de tamaño (MB)'
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
GROUP BY TA.TipoArchivo;

-- EXTRA: Alternativa para mostrar el promedio de todos los tipos de archivos:
-- Variación del JOIN con TiposArchivos
SELECT TA.TipoArchivo, ISNULL(ROUND((AVG(A.Tamaño) * 1.0) / 1024.0 / 1024.0, 4), 0) AS 'Promedio de tamaño (MB)'
FROM Archivos AS A
RIGHT JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
GROUP BY TA.TipoArchivo;

-- Ejercicio 12 - Por cada extensión, indicar la extensión, la cantidad de archivos con esa extensión y el total
-- acumulado en bytes. Ordenado por cantidad de archivos de forma ascendente.
SELECT A.Extension, COUNT(*) AS 'Cantidad de archivos', SUM(A.Tamaño) AS 'Acumulado (bytes)'
FROM Archivos AS A
GROUP BY A.Extension
ORDER BY COUNT(*) ASC;

-- Ejercicio 13 - Por cada usuario, indicar IDUSuario, Apellido, Nombre y la sumatoria total en bytes de los
-- archivos que es dueño. Si algún usuario no registra archivos indicar 0 en la sumatoria total.
SELECT U.IDUsuario, U.Apellido, U.Nombre, ISNULL(SUM(A.Tamaño), 0) AS 'Acumulado (bytes)'
FROM Usuarios AS U
LEFT JOIN Archivos AS A ON A.IDUsuarioDueño = U.IDUsuario
GROUP BY U.IDUsuario, U.Apellido, U.Nombre;

-- Ejercicio 14 - Los tipos de archivos que fueron compartidos más de una vez con el permiso con nombre 'Lectura'
SELECT TA.TipoArchivo, COUNT(*) AS 'Cant Permisos Lectura'
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
WHERE P.Nombre = 'Lectura'
GROUP BY TA.TipoArchivo
HAVING COUNT(*) > 1;

-- Ejercicio 15 - Escribí una consulta que requiera una función de resumen, el uso de joins y de having. Pega en el Foro de Actividad 2.3 en el hilo "Queries del Ejercicio 15" el enunciado de la consulta y la tabla en formato texto plano de lo que daría como resultado con los datos que trabajamos en conjunto.


-- Ejercicio 16 - Por cada tipo de archivo indicar el tipo de archivo y el tamaño del archivo de dicho tipo que sea más pesado.


-- Ejercicio 17 - El nombre del tipo de archivo y el promedio de tamaño de los archivos que corresponden a dicho tipo de archivo. Solamente listar aquellos registros que superen los 50 Megabytes de promedio.


-- Ejercicio 18 - Listar las extensiones que registren más de 2 archivos que no hayan sido compartidos.

