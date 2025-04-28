USE BDArchivos;

-- Ejercicio 1: Todos los usuarios indicando Apellido, Nombre.
SELECT Apellido + ', ' + Nombre AS 'Apellido, Nombre' FROM Usuarios;

-- Ejercicio 2: Todos los usuarios indicando Apellido y Nombre con el formato: [Apellido], [Nombre] (ordenados por Apellido en forma descendente). 
SELECT Apellido + ', ' + Nombre AS 'Apellido, Nombre' FROM Usuarios ORDER BY Apellido DESC;

-- Ejercicio 3: Los usuarios cuyo IDTipoUsuario sea 5 (indicando Nombre, Apellido)
SELECT U.Nombre + ', ' + U.Apellido AS 'Nombre, Apellido' FROM Usuarios U WHERE IDTipoUsuario = 5;

-- Ejercicio 4: El último usuario del listado en orden alfabético (ordenado por Apellido y luego por Nombre). Indicar IDUsuario, Apellido y Nombre
SELECT TOP (1) IDUsuario, Apellido, Nombre
FROM Usuarios
ORDER BY Apellido DESC, Nombre DESC;

-- Ejercicio 5: Los archivos cuyo año de creación haya sido 2021 (Indicar Nombre, Extensión y Fecha de creación).
SELECT Nombre, Extension, FechaCreacion FROM Archivos WHERE YEAR(FechaCreacion) = 2021;
SELECT Nombre + '.' + Extension AS 'Fichero', FechaCreacion FROM Archivos WHERE YEAR(FechaCreacion) = 2021;

-- Ejercicio 6: Todos los usuarios con el siguiente formato Apellido, Nombre en una nueva columna llamada ApellidoYNombre, en orden alfabético.
SELECT Apellido + ', ' + Nombre AS 'ApellidoYNombre' FROM Usuarios ORDER BY ApellidoYNombre ASC;

-- Ejercicio 7: Todos los archivos, indicando el semestre en el cual se produjo su fecha de creación. Indicar Nombre, Extensión, Fecha de Creación y la frase “Primer Semestre” o “Segundo Semestre” según corresponda.
SELECT Nombre, Extension, FechaCreacion,
CASE
	WHEN MONTH(FechaCreacion) <= 6 THEN
		'Primer semestre'
	ELSE
		'Segundo Semestre'
END AS Semestre
FROM Archivos;

-- Ejercicio 8: Ídem al punto anterior, pero ordenarlo por semestre y fecha de creación.
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

-- Ejercicio 10: Todos los archivos que no estén eliminados. Indicar IDArchivo, IDUsuarioDueño, Fecha de Creación y Tamaño del archivo. Ordenar los resultados por Fecha de Creación (del más reciente al más antiguo).
SELECT IDArchivo, IDUsuarioDueño, FechaCreacion, Tamaño FROM Archivos WHERE Eliminado = 0 ORDER BY FechaCreacion DESC;

-- Ejercicio 11: Todos los archivos que estén eliminados cuyo Tamaño del archivo se encuentre entre 40960 y 204800 (ambos inclusive). Indicar el valor de todas las columnas. 
SELECT * FROM Archivos WHERE Eliminado = 1 AND Tamaño BETWEEN 40960 AND 204800;

-- Ejercicio 12: Listar los meses del año en los que se crearon los archivos entre los años 2020 y 2022 (ambos inclusive). NOTA: no indicar más de una vez el mismo mes.
SELECT DISTINCT MONTH(FechaCreacion) FROM Archivos WHERE YEAR(FechaCreacion) BETWEEN 2020 AND 2022;

-- Ejercicio 13: Indicar los distintos ID de los Usuarios Dueños de archivos que nunca modificaron sus archivos y que no se encuentren eliminados. NOTA: no se pueden repetir.
SELECT DISTINCT IDusuarioDueño FROM Archivos WHERE FechaCreacion = FechaUltimaModificacion AND Eliminado = 0;

-- Ejercicio 14: Listar todos los datos de los Archivos cuyos Dueños sean los usuarios con ID 1, 3, 5, 8, 9. Los registros deben estar ordenados por IDUsuarioDueño y Tamaño de forma ascendente.
SELECT * FROM Archivos WHERE IDUsuarioDueño IN (1, 3, 5, 8, 9) ORDER BY IDusuarioDueño ASC, Tamaño ASC;

-- Ejercicio 15: Listar todos los datos de los tres Archivos de más bajo Tamaño que no se encuentren Eliminados.
SELECT TOP(3) * FROM Archivos WHERE Eliminado = 0 ORDER BY Tamaño ASC;

-- Ejercicio 16: Listar los Archivos que estén Eliminados y la Fecha de Ultima
-- Modificación sea menor o igual al año 2021 o bien no estén Eliminados y la
-- Fecha de Ultima Modificación sean mayor al año 2021. Indicar todas las columnas
-- excepto IDUsuarioDueño y Fecha de Creación. Ordenar por IDArchivo.
SELECT IDArchivo, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaUltimaModificacion, Eliminado
FROM Archivos
WHERE
	(Eliminado = 1 AND YEAR(FechaUltimaModificacion) <= 2021)
	OR
	(Eliminado = 0 AND YEAR(FechaUltimaModificacion) > 2021)
ORDER BY IDArchivo;

-- Faltan ejercicios 17 al 22:
17 - Listar los Archivos creados en el año 2023 indicando todas las columnas y además una llamada “DiaSemana” que devuelva a qué día de la semana (1-7) corresponde la fecha de creación del archivo. Ordenar los registros por la columna que contiene el día de la semana.
DESAFÍO: crear otra columna llamada DiaSemanaEnLetras que contenga el día de la semana, pero en letras (suponiendo que la semana comienza en 1-DOMINGO). Por ejemplo, si la fecha del Archivo es 20/08/2023, la columna DiaSemana debe contener 1 y la columna DiaSemanaEnLetras debe contener DOMINGO.

18 - Listar los Archivos que no estén Eliminados y cuyo mes de creación coincida con el mes actual (sin importar el año). NOTA: obtener el mes actual mediante una función, no forzar el valor.

19 - Listar la cantidad total de archivos creados en cada año, mostrando una columna con el año (obtenido a partir de la fecha de creación) y otra con la cantidad de archivos correspondientes a ese año. Además, si se animan, como desafío adicional, agreguen a la consulta una tercera columna llamada PorcentajeSobreElTotal, que indique qué porcentaje representa dicha cantidad sobre el total general de archivos registrados en la base. El porcentaje debe mostrarse con dos decimales y calcularse sin utilizar subconsultas. Ordenar el resultado por año.

20 - Listar los Archivos que no hayan sido creados por los Usuarios con ID 1, 2, ,5, 9 y 10. Indicar IDUsuarioDueño, IDArchivo, fecha de creación y Tamaño. Ordenar por IDUsuarioDueño.

21 - Listar todos los datos de los Usuarios cuyos apellidos comienzan con J. Hacer la misma consulta para los Usuarios con apellido que comienza con J y el Nombre comienza con E. Ordenar los registros por IDUsuario.

22 - Listar todos los datos de los Archivos que tengan el mayor Tamaño. En caso de empate se deben listar todos los Archivos con igual Tamaño.

