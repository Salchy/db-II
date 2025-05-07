-- Se crea la vista:
CREATE VIEW VW_DatosEmpleado AS
SELECT
	E.IDEmpleado,
	E.Apellido,
	E.Nombre,
	A.Descripcion AS NombreArea,
	DATEDIFF(YEAR, E.FechaIngreso, GETDATE()) - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, E.FechaIngreso, GETDATE()), E.FechaIngreso) > GETDATE() THEN 1 ELSE 0 END AS AntiguedadAnios,
	(
    	SELECT TOP 1 S.Sueldo
    	FROM Sueldos S
    	WHERE S.IDEmpleado = E.IDEmpleado
    	ORDER BY S.FechaPago DESC
	) AS UltimoSueldo
FROM
Empleados as E
INNER JOIN Areas A ON E.IDArea = A.IDArea;

-- Luego, a partir de ahora, se puede ejecutar esta vista, con el siguiente script:
SELECT * FROM VW_DatosEmpleado;

-- También podemos filtrar más, a partir de la consulta de la vista:
SELECT Apellido, Nombre, UltimoSueldo 
From VW_DatosEmpleado WHERE UltimoSueldo > 180000;

-- También podemos editar la vista: (ALTER VIEW)
ALTER VIEW VW_DatosEmpleado AS
SELECT
	e.IDEmpleado,
	e.Apellido,
	e.Nombre,
	a.Descripcion AS NombreArea
FROM
	Empleados e
INNER JOIN
	Areas a ON e.IDArea = a.IDArea;

-- Borrar una vista:
DROP VIEW VW_DatosEmpleado;