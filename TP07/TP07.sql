-- Trabajo Practico: Procedimientos Almacenados:

-- 1: Realizar un procedimiento almacenado llamado sp_Agregar_Estudiante que permita registrar un estudiante en el sistema. El procedimiento debe recibir como parámetro Legajo, Nombre, Apellido y Email.
CREATE PROCEDURE sp_Agregar_Estudiante (
	@Legajo VARCHAR(10),
	@Nombre VARCHAR(100),
	@Apellido VARCHAR(100),
	@Email VARCHAR(150)
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Estudiantes (Legajo, Nombre, Apellido, Email) VALUES (@Legajo, @Nombre, @Apellido, @Email);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
	END CATCH
END

-- 2: Realizar un procedimiento almacenado llamado sp_Agregar_Materia que permita registrar una materia en el sistema. El procedimiento debe recibir como parámetro el Nombre, el Nivel, Carrera y CodigoMateria.
CREATE PROCEDURE sp_Agregar_Materia (
	@Nombre VARCHAR(100),
	@Nivel TINYINT,
	@Carrera VARCHAR(150),
	@CodigoMateria VARCHAR(4)
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Materias (Nombre, Nivel, Carrera, CodigoMateria) VALUES (@Nombre, @Nivel, @Carrera, @CodigoMateria);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
	END CATCH
END

-- 3: Realizar un procedimiento almacenado llamado sp_Agregar_EstudianteMateria que permita registrar el postulamiento de un estudiante como tutor o alumno a una materia en el sistema.
-- El procedimiento debe recibir como parámetro el IDEstudiante, el IDMateria y Rol (Tutor o Alumno).
CREATE PROCEDURE sp_Agregar_EstudianteMateria(
	@IDEstudiante INT,
	@IDMateria INT,
	@Rol VARCHAR(10)
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO EstudiantesMaterias (IDEstudiante, IDMateria, Rol) VALUES (@IDEstudiante, @IDMateria, @Rol);
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
	END CATCH
END

-- 4: Realizar un procedimiento almacenado llamado sp_Agregar_Tutoria que permita registrar una tutoría en el sistema. El procedimiento debe recibir como parámetro el IDEstudianteTutor,
-- el IDEstudianteAlumno, el IDMateria, Fecha y Duración. 
-- ID
-- El procedimiento deberá:
-- Descontar los créditos al estudiante con rol de alumno de acuerdo con la duración de la tutoría.
-- NOTA: Los estudiantes no pueden tener más de 5 créditos negativos. 
CREATE PROCEDURE sp_Agregar_Tutoria (
	@IDEstudianteTutor INT,
	@IDEstudianteAlumno INT,
	@IDMateria INT,
	@Fecha DATE,
	@Duracion TINYINT,
)
AS
BEGIN
	BEGIN TRY
		-- Comienza la transacción
        BEGIN TRANSACTION

			INSERT INTO Tutorias (IDEstudianteTutor, IDEstudianteAlumno, IDMateria, Fecha, Duracion) VALUES (@IDEstudianteTutor, @IDEstudianteAlumno, @IDMateria, @Fecha, @Duracion);

			

		COMMIT TRANSACTION
	END
END

-- 5: Realizar un procedimiento almacenado llamado sp_Confirmar_Tutoria que registre la confirmación por parte del Tutor o Alumno. El procedimiento debe recibir: el IDTutoria y el Rol de quien confirma.
-- El procedimiento deberá:
-- Si tiene ambas confirmaciones, se le deben sumar los créditos al tutor de acuerdo con la duración de la tutoría.
-- Actualizar el estado de esta a “Realizada”.


-- 6: Realizar un procedimiento almacenado llamado sp_Obtener_Tutorias que reciba un IDEstudiante y un Rol ('Tutor' o 'Alumno'). El procedimiento debe devolver un listado con las tutorías brindadas
-- o recibidas (según el rol enviado) indicando el nombre y apellido del estudiante tutor, nombre y apellido del estudiante alumno, fecha, nombre de la materia y cantidad de horas de la tutoría.