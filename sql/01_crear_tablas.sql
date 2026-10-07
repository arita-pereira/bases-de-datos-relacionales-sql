-- ============================================================
-- 01 · Crear tablas y datos de ejemplo
-- Create tables and sample data
-- ============================================================
-- Base de datos de ejemplo de la presentación: niños, juguetes y libros.
-- Probado en SQLite 3.39 o superior. En PostgreSQL y MySQL solo cambia
-- "INTEGER PRIMARY KEY" por "SERIAL PRIMARY KEY" / "INT AUTO_INCREMENT PRIMARY KEY".

-- En SQLite las claves foráneas hay que activarlas en cada sesión.
PRAGMA foreign_keys = ON;

-- Tabla niños: un "cajón" con una "tarjeta" por niño.
CREATE TABLE niños (
  id     INTEGER PRIMARY KEY,          -- clave primaria (primary key)
  nombre TEXT    NOT NULL UNIQUE       -- obligatorio y sin repetir
);

-- Tabla juguetes: cada juguete apunta a su dueño con una clave foránea.
CREATE TABLE juguetes (
  id       INTEGER PRIMARY KEY,
  nombre   TEXT    NOT NULL,
  dueño_id INTEGER,                    -- clave foránea (foreign key)
  FOREIGN KEY (dueño_id) REFERENCES niños (id)
);

-- Tabla libros: se usa en los ejemplos de CRUD.
CREATE TABLE libros (
  id     INTEGER PRIMARY KEY,
  título TEXT    NOT NULL,
  autor  TEXT    NOT NULL,
  año    INTEGER CHECK (año > 0)       -- el año nunca puede ser negativo
);

-- Datos de ejemplo (los mismos que aparecen en las diapositivas).
INSERT INTO niños (id, nombre) VALUES (1, 'Juan');
INSERT INTO niños (id, nombre) VALUES (2, 'Ana');
INSERT INTO niños (id, nombre) VALUES (3, 'Marta');   -- Marta aún no tiene juguetes

INSERT INTO juguetes (id, nombre, dueño_id) VALUES (1, 'Osito peluche', 1);
INSERT INTO juguetes (id, nombre, dueño_id) VALUES (2, 'Coche rojo', 2);
INSERT INTO juguetes (id, nombre, dueño_id) VALUES (3, 'Balón', 1);

-- Comprobación: debería mostrar 3 niños y 3 juguetes.
SELECT * FROM niños;
SELECT * FROM juguetes;
