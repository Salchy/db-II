-- TP 5

-- 1 - La cantidad de archivos con extensi�n zip.
SELECT COUNT(*) AS 'Archivos ZIP' FROM Archivos WHERE Extension = 'zip';

-- 2 - La cantidad de archivos que fueron modificados y, por lo tanto, su fecha de �ltima modificaci�n no es la misma que la fecha de creaci�n.
SELECT COUNT (*) AS 'Archivos Modificados' FROM Archivos WHERE FechaCreacion != FechaUltimaModificacion;

-- 3 - La fecha de creaci�n m�s antigua de los archivos con extensi�n pdf.
SELECT MIN(FechaCreacion) AS 'Fecha mas antigua .PDF' FROM Archivos WHERE Extension = 'pdf';

-- 4 - La cantidad de extensiones distintas cuyos archivos tienen en su nombre o en su descripci�n la palabra 'Informe' o 'Documento'.


-- 5 - El promedio de tama�o (expresado en Megabytes) de los archivos con extensi�n 'doc', 'docx', 'xls', 'xlsx'.


-- 6 - La cantidad de archivos que le fueron compartidos al usuario con apellido 'Clarck'


-- 7 - La cantidad de tipos de usuario que tienen asociado usuarios que registren, como due�os, archivos con extensi�n pdf.


-- 8 - El tama�o m�ximo expresado en Megabytes de los archivos que hayan sido creados en el a�o 2024.


-- 9 - El nombre del tipo de usuario y la cantidad de usuarios distintos de dicho tipo que registran, como due�os, archivos con extensi�n pdf.


-- 10 - El nombre y apellido de los usuarios due�os y la suma total del tama�o de los archivos que tengan compartidos con otros usuarios. Mostrar  ordenado de mayor sumatoria de tama�o a menor.


-- 11 - El nombre del tipo de archivo y el promedio de tama�o de los archivos que corresponden a dicho tipo de archivo.


-- 12 - Por cada extensi�n, indicar la extensi�n, la cantidad de archivos con esa extensi�n y el total acumulado en bytes. Ordenado por cantidad de archivos de forma ascendente.


-- 13 - Por cada usuario, indicar IDUSuario, Apellido, Nombre y la sumatoria total en bytes de los archivos que es due�o. Si alg�n usuario no registra archivos indicar 0 en la sumatoria total.


-- 14 - Los tipos de archivos que fueron compartidos m�s de una vez con el permiso con nombre 'Lectura'


-- 15 - Escrib� una consulta que requiera una funci�n de resumen, el uso de joins y de having. Pega en el Foro de Actividad 2.3 en el hilo "Queries del Ejercicio 15" el enunciado de la consulta y la tabla en formato texto plano de lo que dar�a como resultado con los datos que trabajamos en conjunto.


-- 16 - Por cada tipo de archivo indicar el tipo de archivo y el tama�o del archivo de dicho tipo que sea m�s pesado.


-- 17 - El nombre del tipo de archivo y el promedio de tama�o de los archivos que corresponden a dicho tipo de archivo. Solamente listar aquellos registros que superen los 50 Megabytes de promedio.


-- 18 - Listar las extensiones que registren m�s de 2 archivos que no hayan sido compartidos.

