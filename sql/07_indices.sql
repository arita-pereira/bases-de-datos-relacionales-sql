-- ============================================================
-- 07 · Índices y optimización
-- Indexes: the shortcut to find data faster
-- ============================================================
-- Este script es independiente: crea una tabla con 50.000 filas.
-- Usa EXPLAIN QUERY PLAN, que es específico de SQLite.
-- En PostgreSQL o MySQL el equivalente es EXPLAIN (o EXPLAIN ANALYZE).

CREATE TABLE libros_grande (
  id     INTEGER PRIMARY KEY,
  título TEXT NOT NULL,
  autor  TEXT NOT NULL
);

-- Rellenar con 50.000 filas (20 autores distintos, repetidos).
WITH RECURSIVE n(i) AS (
  SELECT 1 UNION ALL SELECT i + 1 FROM n WHERE i < 50000
)
INSERT INTO libros_grande (id, título, autor)
SELECT i, 'Libro ' || i, 'Autor ' || (i % 20)
FROM n;

-- SIN índice: la base de datos revisa fila por fila (full table scan).
-- Busca en la salida del plan la palabra SCAN.
EXPLAIN QUERY PLAN
SELECT * FROM libros_grande WHERE autor = 'Autor 7';

-- Creamos el índice (se hace una sola vez).
CREATE INDEX idx_autor ON libros_grande (autor);

-- CON índice: la misma consulta salta directo a las filas relevantes.
-- Ahora el plan dice SEARCH ... USING INDEX idx_autor.
EXPLAIN QUERY PLAN
SELECT * FROM libros_grande WHERE autor = 'Autor 7';

-- El precio a pagar: el índice ocupa espacio y ralentiza un poco las
-- escrituras (INSERT, UPDATE), porque hay que mantenerlo al día.
-- Por eso se indexa con criterio, no todas las columnas.
