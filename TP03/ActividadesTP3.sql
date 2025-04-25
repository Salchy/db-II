USE BDArchivos;

-- Ejercicio 1: Todos los usuarios indicando Apellido, Nombre.
SELECT Apellido + ', ' + Nombre AS 'Apellido, Nombre' FROM Usuarios;

-- Ejercicio 2: Todos los usuarios indicando Apellido y Nombre con el formato: [Apellido], [Nombre] (ordenados por Apellido en forma descendente). 
SELECT Apellido + ', ' + Nombre AS 'Apellido, Nombre' FROM Usuarios ORDER BY Apellido DESC;

-- Ejercicio 3: Los usuarios cuyo IDTipoUsuario sea 5 (indicando Nombre, Apellido)
SELECT U.Nombre + ', ' + U.Apellido AS 'Nombre, Apellido' FROM Usuarios U WHERE IDTipoUsuario = 5;

-- Ejercicio 4: El �ltimo usuario del listado en orden alfab�tico (ordenado por Apellido y luego por Nombre). Indicar IDUsuario, Apellido y Nombre
SELECT TOP (1) IDUsuario, Apellido, Nombre
FROM Usuarios
ORDER BY Apellido DESC, Nombre DESC;

-- Ejercicio 5: Los archivos cuyo a�o de creaci�n haya sido 2021 (Indicar Nombre, Extensi�n y Fecha de creaci�n).
SELECT Nombre, Extension, FechaCreacion FROM Archivos WHERE YEAR(FechaCreacion) = 2021;
SELECT Nombre + '.' + Extension AS 'Fichero', FechaCreacion FROM Archivos WHERE YEAR(FechaCreacion) = 2021;

-- Ejercicio 6: Todos los usuarios con el siguiente formato Apellido, Nombre en una nueva columna llamada ApellidoYNombre, en orden alfab�tico.
SELECT Apellido + ', ' + Nombre AS 'ApellidoYNombre' FROM Usuarios ORDER BY ApellidoYNombre ASC;

-- Ejercicio 7: Todos los archivos, indicando el semestre en el cual se produjo su fecha de creaci�n. Indicar Nombre, Extensi�n, Fecha de Creaci�n y la frase �Primer Semestre� o �Segundo Semestre� seg�n corresponda.
SELECT Nombre, Extension, FechaCreacion,
CASE
	WHEN MONTH(FechaCreacion) <= 6 THEN
		'Primer semestre'
	ELSE
		'Segundo Semestre'
END AS Semestre
FROM Archivos;

-- Ejercicio 8: �dem al punto anterior, pero ordenarlo por semestre y fecha de creaci�n.
SELECT Nombre, Extension, FechaCreacion,
CASE
	WHEN MONTH(FechaCreacion) <= 6 THEN
		'Primer semestre'
	ELSE
		'Segundo Semestre'
END AS Semestre
FROM Archivos ORDER BY Semestre, FechaCreacion ASC;

-- Ejercicio 9: Todas las Extensiones de los archivos creados. NOTA: no se pueden repetir.
SELECT DISTINCT Extension FROM Archivos;

-- Ejercicio 10: Todos los archivos que no est�n eliminados. Indicar IDArchivo, IDUsuarioDue�o, Fecha de Creaci�n y Tama�o del archivo. Ordenar los resultados por Fecha de Creaci�n (del m�s reciente al m�s antiguo).
SELECT IDArchivo, IDUsuarioDue�o, FechaCreacion, Tama�o FROM Archivos WHERE Eliminado = 0 ORDER BY FechaCreacion DESC;

-- Ejercicio 11: Todos los archivos que est�n eliminados cuyo Tama�o del archivo se encuentre entre 40960 y 204800 (ambos inclusive). Indicar el valor de todas las columnas. 
SELECT * FROM Archivos WHERE Eliminado = 1 AND Tama�o BETWEEN 40960 AND 204800;

-- Ejercicio 12: Listar los meses del a�o en los que se crearon los archivos entre los a�os 2020 y 2022 (ambos inclusive). NOTA: no indicar m�s de una vez el mismo mes.
SELECT DISTINCT MONTH(FechaCreacion) FROM Archivos WHERE YEAR(FechaCreacion) BETWEEN 2020 AND 2022;

-- Ejercicio 13: Indicar los distintos ID de los Usuarios Due�os de archivos que nunca modificaron sus archivos y que no se encuentren eliminados. NOTA: no se pueden repetir.
SELECT DISTINCT IDusuarioDue�o FROM Archivos WHERE FechaCreacion = FechaUltimaModificacion AND Eliminado = 0;

-- Ejercicio 14: Listar todos los datos de los Archivos cuyos Due�os sean los usuarios con ID 1, 3, 5, 8, 9. Los registros deben estar ordenados por IDUsuarioDue�o y Tama�o de forma ascendente.
SELECT * FROM Archivos WHERE IDUsuarioDue�o IN (1, 3, 5, 8, 9) ORDER BY IDusuarioDue�o ASC, Tama�o ASC;

-- Ejercicio 15: Listar todos los datos de los tres Archivos de m�s bajo Tama�o que no se encuentren Eliminados.
SELECT TOP(3) * FROM Archivos WHERE Eliminado = 0 ORDER BY Tama�o ASC;

-- Ejercicio 16: Listar los Archivos que est�n Eliminados y la Fecha de Ultima
-- Modificaci�n sea menor o igual al a�o 2021 o bien no est�n Eliminados y la
-- Fecha de Ultima Modificaci�n sean mayor al a�o 2021. Indicar todas las columnas
-- excepto IDUsuarioDue�o y Fecha de Creaci�n. Ordenar por IDArchivo.
SELECT IDArchivo, Nombre, Extension, Descripcion, IDTipoArchivo, Tama�o, FechaUltimaModificacion, Eliminado
FROM Archivos
WHERE
	(Eliminado = 1 AND YEAR(FechaUltimaModificacion) <= 2021)
	OR
	(Eliminado = 0 AND YEAR(FechaUltimaModificacion) > 2021)
ORDER BY IDArchivo;