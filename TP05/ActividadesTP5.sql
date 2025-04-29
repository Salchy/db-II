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
WHERE Nombre LIKE '%informe%' OR Descripcion LIKE '%Documento%'

-- Ejercicio 5 - El promedio de tamaño (expresado en Megabytes) de los archivos con extensión 'doc', 'docx', 'xls', 'xlsx'.
SELECT ROUND(AVG(Tamaño) / 1024.0 / 1024.0, 4) AS 'Promedio (MB)'
FROM Archivos
WHERE Extension IN ('doc', 'docx', 'xls', 'xlsx')

-- Ejercicio 6 - La cantidad de archivos que le fueron compartidos al usuario con apellido 'Clarck'
SELECT COUNT(*) AS 'Cantidad Comp. a Clark'
FROM ArchivosCompartidos AS AC
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido = 'Clarck'

-- Ejercicio 7 - La cantidad de tipos de usuario que tienen asociado usuarios que registren, como dueños, archivos con extensión pdf.


-- Ejercicio 8 - El tamaño máximo expresado en Megabytes de los archivos que hayan sido creados en el año 2024.


-- Ejercicio 9 - El nombre del tipo de usuario y la cantidad de usuarios distintos de dicho tipo que registran, como dueños, archivos con extensión pdf.


-- Ejercicio 10 - El nombre y apellido de los usuarios dueños y la suma total del tamaño de los archivos que tengan compartidos con otros usuarios. Mostrar  ordenado de mayor sumatoria de tamaño a menor.


-- Ejercicio 11 - El nombre del tipo de archivo y el promedio de tamaño de los archivos que corresponden a dicho tipo de archivo.


-- Ejercicio 12 - Por cada extensión, indicar la extensión, la cantidad de archivos con esa extensión y el total acumulado en bytes. Ordenado por cantidad de archivos de forma ascendente.


-- Ejercicio 13 - Por cada usuario, indicar IDUSuario, Apellido, Nombre y la sumatoria total en bytes de los archivos que es dueño. Si algún usuario no registra archivos indicar 0 en la sumatoria total.


-- Ejercicio 14 - Los tipos de archivos que fueron compartidos más de una vez con el permiso con nombre 'Lectura'


-- Ejercicio 15 - Escribí una consulta que requiera una función de resumen, el uso de joins y de having. Pega en el Foro de Actividad 2.3 en el hilo "Queries del Ejercicio 15" el enunciado de la consulta y la tabla en formato texto plano de lo que daría como resultado con los datos que trabajamos en conjunto.


-- Ejercicio 16 - Por cada tipo de archivo indicar el tipo de archivo y el tamaño del archivo de dicho tipo que sea más pesado.


-- Ejercicio 17 - El nombre del tipo de archivo y el promedio de tamaño de los archivos que corresponden a dicho tipo de archivo. Solamente listar aquellos registros que superen los 50 Megabytes de promedio.


-- Ejercicio 18 - Listar las extensiones que registren más de 2 archivos que no hayan sido compartidos.

