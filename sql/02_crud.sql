-- ============================================================
-- 02 · CRUD en SQL puro
-- CRUD in plain SQL: Create, Read, Update, Delete
-- ============================================================
-- Requiere haber ejecutado antes 01_crear_tablas.sql.

-- C — CREATE: añadir filas con INSERT
INSERT INTO libros (título, autor, año)
VALUES ('Cien años de soledad', 'García Márquez', 1967);

INSERT INTO libros (título, autor, año)
VALUES ('La casa de los espíritus', 'Isabel Allende', 1982);

INSERT INTO libros (título, autor, año)
VALUES ('Paula', 'Isabel Allende', 1994);

INSERT INTO libros (título, autor, año)
VALUES ('Rayuela', 'Julio Cortázar', 1963);

-- R — READ: consultar con SELECT
SELECT * FROM libros;

SELECT título, autor, año
FROM libros
WHERE año > 1960
ORDER BY año;

-- U — UPDATE: modificar filas existentes
-- Regla de oro: primero comprueba el WHERE con un SELECT.
SELECT * FROM libros WHERE id = 1;

UPDATE libros
SET título = 'Cien años de soledad (Ed. revisada)'
WHERE id = 1;

SELECT * FROM libros WHERE id = 1;

-- D — DELETE: borrar filas
-- Mismo consejo: SELECT primero, DELETE después.
SELECT * FROM libros WHERE id = 4;

DELETE FROM libros
WHERE id = 4;

SELECT * FROM libros;

-- ⚠ Sin WHERE, UPDATE y DELETE afectan a TODA la tabla:
-- DELETE FROM libros;   -- esto borraría todos los libros. No lo ejecutes sin querer.
