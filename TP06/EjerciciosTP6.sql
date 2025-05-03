-- Ejercicios TP 6

-- Ejercicio 1 Los nombres y extensiones y tamaño en Megabytes de los archivos que pesen más
-- que el promedio de archivos.
SELECT A.Nombre, A.Extension, A.Tamaño / 1024.0 / 1024.0 AS 'MB'
FROM Archivos AS A
WHERE A.Tamaño > (SELECT AVG(A2.Tamaño * 1.0) FROM Archivos AS A2);

-- Ejercicio 2 Los usuarios indicando apellido y nombre que no sean dueños de ningún archivo con extensión 'zip'.


-- Ejercicio 3 Los usuarios indicando IDUsuario, apellido, nombre y tipo de usuario que no hayan creado ni modificado ningún archivo en el año actual.


-- Ejercicio 4 Los tipos de usuario que no registren usuario con archivos eliminados.


-- Ejercicio 5 Los tipos de archivos que no se hayan compartido con el permiso de 'Lectura'


-- Ejercicio 6 Los nombres y extensiones de los archivos que tengan un tamaño mayor al del archivo con extensión 'xls' más grande.


-- Ejercicio 7 Los nombres y extensiones de los archivos que tengan un tamaño mayor al del archivo con extensión 'zip' más pequeño.


-- Ejercicio 8 Por cada tipo de archivo indicar el tipo y la cantidad de archivos eliminados y la cantidad de archivos no eliminados.


-- Ejercicio 9 Por cada usuario indicar el IDUsuario, el apellido, el nombre, la cantidad de archivos pequeños (menos de 20MB) y la cantidad de archivos grandes (20MBs o más)


-- Ejercicio 10 Por cada usuario indicar el IDUsuario, el apellido, el nombre y la cantidad de archivos creados en el año 2022, la cantidad en el año 2023 y la cantidad creados en el 2024.


-- Ejercicio 11 Los archivos que fueron compartidos con permiso de 'Comentario' pero no con permiso de 'Lectura'


-- Ejercicio 12 Los tipos de archivos que registran más archivos eliminados que no eliminados.


-- Ejercicio 13 Los usuario que registren más archivos pequeños que archivos grandes (pero que al menos registren un archivo de cada uno)


-- Ejercicio 14 Los usuarios que hayan creado más archivos en el 2022 que en el 2023 y en el 2023 que en el 2024.

