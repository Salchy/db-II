Use DBArchivos
GO

-- Inserts a tabla TiposUsuario
INSERT INTO TiposUsuario (TipoUsuario) VALUES ('Suscripción Free');
INSERT INTO TiposUsuario (TipoUsuario) VALUES ('Suscripción Básica');
INSERT INTO TiposUsuario (TipoUsuario) VALUES ('Suscripción Plus');
INSERT INTO TiposUsuario (TipoUsuario) VALUES ('Suscripción Premium');
INSERT INTO TiposUsuario (TipoUsuario) VALUES ('Suscripción Empresarial');

-- Compruebo que la inserción sea correcta
SELECT * FROM TiposUsuario;

-- Insert a tabla Permisos
INSERT INTO Permisos (Nombre) VALUES ('Lectura');
INSERT INTO Permisos (Nombre) VALUES ('Comentario');
INSERT INTO Permisos (Nombre) VALUES ('Escritura');
INSERT INTO Permisos (Nombre) VALUES ('Administrador');

-- Compruebo que la inserción sea correcta
SELECT * FROM Permisos;
GO

-- Insert a tabla TipoUsuario
-- Obtengo los ID de cada tipo de usuario para asignar acorde al ejercicio:
SELECT IDTipoUsuario, TipoUsuario FROM TiposUsuario;

-- Inserto datos:
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Adrián', 'Clarck', 1);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('María', 'González', 2);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Carlos', 'López', 3);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Ana', 'Martínez', 4);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Luis', 'Fernández', 5);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('John', 'Smith', 1);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Emily', 'Johnson', 2);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Michael', 'Williams', 3);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('Jessica', 'Brown', 4);
INSERT INTO Usuarios (Nombre, Apellido, IDTipoUsuario) VALUES ('David', 'Jones', 5);

-- Compruebo que la inserción sea correcta
SELECT * FROM Usuarios;
GO

-- Insert a tabla TiposArchivos
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Documento PDF');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Imagen JPEG');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Imagen BMP');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo ZIP');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Ejecutable EXE');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Documento Word');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Hoja de Cálculo Excel');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Presentación PowerPoint');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo de Texto TXT');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo HTML');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo CSS');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo JavaScript');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo XML');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo JSON');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo MP3');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Video MP4');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo WAV');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Imagen PNG');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo GIF');
INSERT INTO TiposArchivos (TipoArchivo) VALUES ('Archivo TAR');

-- Compruebo que la inserción sea correcta
SELECT * FROM TiposArchivos;
GO
-- INSERT a tabla Archivos:
-- Obtengo los ID de los usuarios para asignar acorde al ejercicio.
SELECT * FROM Usuarios;

-- Obtengo los ID de los tipos de archivos que hay:
SELECT * FROM TiposArchivos;

-- Fix de formato, para fozar a usar el formato yyyy-mm-dd
SET DATEFORMAT ymd;

-- Lineas para borrar los datos, y volver a cargarlos:
DELETE FROM Archivos;
DBCC CHECKIDENT ('Archivos', RESEED, 0); -- Reinicia el IDENTITY de la tabla Archivos

-- Ahora inserto datos:
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (1, 'Informe Anual', 'pdf', 'Informe de resultados anuales', 1, 204800, '2021-03-15', '2021-03-16', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (1, 'Foto de perfil', 'jpg', 'Imagen para perfil en la plataforma', 2, 51200, '2022-01-10', '2022-01-10', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (1, 'Backup Sistema', 'zip', 'Copia de seguridad del sistema', 4, 104857600, '2023-05-01', '2023-05-01', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (2, 'Presentación Proyecto', 'pptx', 'Presentación del proyecto final', 8, 307200, '2020-07-22', '2020-07-22', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (2, 'Reporte Financiero', 'xls', 'Reporte del estado financiero', 7, 102400, '2022-12-05', '2022-12-06', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (2, 'Diagrama de Red', 'png', 'Diagrama de la red interna', 18, 81920, '2021-09-15', '2021-09-15', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (3, 'Manual de Usuario', 'pdf', 'Manual de uso del software', 1, 256000, '2021-11-10', '2021-11-11', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (3, 'Informe de Ventas', 'xls', 'Informe de ventas del trimestre', 7, 76800, '2023-01-20', '2023-01-21', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Documento Legal', 'docx', 'Contrato legal revisado', 6, 51200, '2020-03-01', '2020-03-02', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Plan de Marketing', 'pptx', 'Plan de marketing para el nuevo producto', 8, 153600, '2022-10-10', '2022-10-11', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Presupuesto 2023', 'xls', 'Presupuesto aprobado para 2023', 7, 128000, '2023-08-15', '2023-08-16', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Logo Empresa', 'png', 'Logo oficial de la empresa', 18, 102400, '2020-06-20', '2020-06-20', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (5, 'Audio Conferencia', 'mp3', 'Grabación de la conferencia anual', 15, 52428800, '2021-04-12', '2021-04-12', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (5, 'Video Promocional', 'mp4', 'Video promocional del nuevo producto', 16, 104857600, '2023-02-14', '2023-02-14', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (6, 'Guía de Estilo', 'docx', 'Guía de estilo para la empresa', 6, 40960, '2022-05-30', '2022-05-30', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (6, 'Esquema de Base de Datos', 'pdf', 'Esquema detallado de la base de datos', 1, 102400, '2023-07-21', '2023-07-21', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (7, 'Presentación Producto', 'pptx', 'Presentación de características del nuevo producto', 8, 204800, '2021-08-15', '2021-08-15', 0);

-- Compruebo que la inserción sea correcta
SELECT * FROM Archivos;
GO

INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (7, 'Análisis Competencia', 'docx', 'Análisis del mercado y competencia', 6, 61440, '2022-03-18', '2022-03-19', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (8, 'Memorándum Interno', 'docx', 'Memorándum para todo el personal', 6, 30720, '2023-11-10', '2023-11-10', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (8, 'Propuesta Comercial', 'pdf', 'Propuesta comercial para el cliente', 1, 153600, '2021-04-05', '2021-04-06', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (9, 'Plan Estratégico', 'xls', 'Plan estratégico para los próximos 5 años', 7, 256000, '2023-02-28', '2023-03-01', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (9, 'Informe de Sostenibilidad', 'pdf', 'Informe anual de sostenibilidad', 1, 204800, '2020-11-11', '2020-11-11', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (9, 'Resumen Ejecutivo', 'docx', 'Resumen ejecutivo del informe anual', 6, 40960, '2021-12-20', '2021-12-21', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (1, 'Backup Datos', 'zip', 'Copia de seguridad de los datos', 4, 209715200, '2024-01-01', '2024-01-02', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (2, 'Esquema del Proyecto', 'pdf', 'Esquema general del proyecto', 1, 102400, '2022-04-15', '2022-04-16', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (3, 'Video Corporativo', 'mp4', 'Video de presentación corporativa', 16, 157286400, '2023-06-05', '2023-06-05', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Documento de Propuesta', 'docx', 'Propuesta enviada al cliente', 6, 61440, '2021-09-01', '2021-09-01', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (5, 'Reporte de Uso', 'xls', 'Reporte de uso de recursos', 7, 122880, '2023-08-20', '2023-08-21', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (6, 'Imagen del Producto', 'jpg', 'Imagen del nuevo producto', 2, 51200, '2020-05-10', '2020-05-10', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (7, 'Estudio de Mercado', 'pdf', 'Estudio de mercado para la nueva campaña', 1, 153600, '2022-06-22', '2022-06-23', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (8, 'Modelo Financiero', 'xls', 'Modelo financiero para la nueva línea de negocio', 7, 204800, '2024-02-01', '2024-02-02', 0);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (9, 'Archivo de Código', 'zip', 'Código fuente del proyecto', 4, 104857600, '2023-03-30', '2023-03-31', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (2, 'Documento Eliminado', 'docx', 'Archivo que fue eliminado', 6, 40960, '2021-07-15', '2021-07-15', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (4, 'Imagen Vieja', 'png', 'Imagen que fue reemplazada', 18, 102400, '2022-09-10', '2022-09-10', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (6, 'Archivo Descontinuado', 'pdf', 'Archivo que ya no se usa', 1, 153600, '2020-12-25', '2020-12-26', 1);
INSERT INTO Archivos (IDUsuarioDueño, Nombre, Extension, Descripcion, IDTipoArchivo, Tamaño, FechaCreacion, FechaUltimaModificacion, Eliminado) VALUES (8, 'Versión Antigua', 'pptx', 'Versión anterior de la presentación', 8, 204800, '2023-05-15', '2023-05-16', 1);

-- Compruebo que la inserción sea correcta
SELECT * FROM Archivos;
GO

-- Insert de ArchivosCompartidos:

-- Obtengo primero los ID de usuarios para asignar
SELECT * FROM Usuarios;

-- Ahora obtengo los ID de los permisos
SELECT * FROM Permisos

-- Ahora inserto datos:
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (1, 6, 1, '2022-05-11');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (2, 7, 2, '2022-06-15');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (3, 8, 3, '2023-01-12');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (4, 9, 1, '2020-08-01');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (5, 5, 4, '2023-09-20');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (6, 6, 1, '2022-02-18');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (7, 7, 3, '2021-10-05');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (8, 8, 1, '2023-04-17');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (9, 9, 2, '2020-04-25');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (10, 1, 4, '2022-11-30');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (11, 2, 1, '2021-06-22');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (12, 3, 3, '2023-02-14');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (13, 4, 2, '2020-01-19');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (14, 6, 1, '2023-03-23');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (15, 7, 4, '2022-07-29');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (16, 7, 2, '2023-12-05');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (17, 8, 1, '2021-09-16');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (18, 9, 3, '2020-12-07');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (18, 1, 4, '2024-02-28');
INSERT INTO ArchivosCompartidos (IDArchivo, IDUsuario, IDPermiso, FechaCompartido) VALUES (18, 10, 1, '2023-05-10');

-- Compruebo que la inserción sea correcta
SELECT * FROM ArchivosCompartidos;
GO