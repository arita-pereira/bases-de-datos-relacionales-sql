-- ============================================================
-- 05 · Integridad referencial: reglas que no se rompen
-- Integrity constraints: NOT NULL, UNIQUE, FOREIGN KEY, CHECK
-- ============================================================
-- Requiere haber ejecutado antes 01_crear_tablas.sql.
-- Cada sentencia de este script DEBE FALLAR. Ejecútalas de una en una
-- y lee el mensaje de error: es la base de datos protegiendo los datos.

PRAGMA foreign_keys = ON;

-- NOT NULL: un campo obligatorio no puede quedar vacío.
-- Error esperado: NOT NULL constraint failed: niños.nombre
INSERT INTO niños (id, nombre) VALUES (10, NULL);

-- UNIQUE: un valor no se puede repetir en esa columna.
-- Error esperado: UNIQUE constraint failed: niños.nombre
INSERT INTO niños (id, nombre) VALUES (11, 'Juan');

-- FOREIGN KEY: una fila no puede apuntar a algo que no existe.
-- Error esperado: FOREIGN KEY constraint failed
INSERT INTO juguetes (id, nombre, dueño_id) VALUES (20, 'Cometa', 999);

-- CHECK: el valor debe cumplir una condición.
-- Error esperado: CHECK constraint failed: año > 0
INSERT INTO libros (título, autor, año) VALUES ('Libro imposible', 'Nadie', -5);

-- FOREIGN KEY también protege al borrar: no puedes borrar a un niño
-- que todavía tiene juguetes asignados.
-- Error esperado: FOREIGN KEY constraint failed
DELETE FROM niños WHERE id = 1;
