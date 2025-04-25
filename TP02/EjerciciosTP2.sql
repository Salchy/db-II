USE BDArchivos;
SELECT * FROM Archivos;

-- Punto 2 / Actualizar descripción de archivo eliminado:
UPDATE Archivos SET Descripcion = 'Archivo eliminado por el usuario' WHERE Descripcion LIKE '%eliminado%';

-- Punto 3 / Marcar como eliminados archivos viejos:
UPDATE Archivos SET Eliminado = 1 WHERE FechaCreacion < '2021-01-01' AND Eliminado <> 1;

-- Punto 4 / Eliminar un archivo ZIP del usuario 1:
UPDATE Archivos SET Eliminado = 1 WHERE IDArchivo = 7;

-- Punto 5 / Asignar permiso de lectura:
-- Escritura es permiso ID 3
UPDATE ArchivosCompartidos SET IDPermiso = 3 WHERE IDArchivo = 1 AND IDUsuario = 10;

-- Punto 6 / Eliminar archivos antiguos eliminados:
SELECT * FROM Archivos WHERE Eliminado = 1 AND FechaUltimaModificacion < '2022-01-01';
SELECT * FROM ArchivosCompartidos WHERE IDArchivo IN(3, 5, 12, 16, 18, 23, 28, 31);

DELETE ArchivosCompartidos WHERE IDArchivo IN(3, 5, 12, 16, 18, 23, 28, 31);
DELETE Archivos WHERE Eliminado = 1 AND FechaUltimaModificacion < '2022-01-01';

-- Punto 7 / Corregir extensión de imagen:-- Image JPEG es ID 2UPDATE Archivos SET Extension = 'jpeg' WHERE IDTipoArchivo = 2

-- Punto 8 / Insertar archivo y compartirlo:
SELECT * FROM ArchivosCompartidos;

INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño) VALUES(3, 'Trabajo Practico', 'png', 'Foto de Lean', 18, 2025)
-- Nuevo ID de archivo = 37
-- ID Permiso Lectura: 1
-- ID Permiso Escritura = 3
-- ID Permiso Administrador = 4

-- Usuarios para dar permisos (1 - 10)
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso) VALUES (37, 3, 1);
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso) VALUES (37, 6, 3);
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso) VALUES (37, 9, 4);

------------------

-- Punto 9 / Asignar permiso administrador a un usuario premium:

INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso) VALUES (4, 4, 4)

-- Punto 10 / Reemplazo de archivo eliminado:
SELECT Extension, Nombre, Descripcion FROM Archivos WHERE Extension = 'PPTX';
DELETE Archivos WHERE Nombre LIKE 'Versión%';

INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño) VALUES(8, 'Versión Antigua_v2', 'pptx', 'Versión anterior de la presentación', 8, 204800)

SELECT * FROM TiposArchivos