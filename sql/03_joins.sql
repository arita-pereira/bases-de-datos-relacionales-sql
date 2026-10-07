-- ============================================================
-- 03 · JOIN: combinar tablas
-- JOIN types: INNER, LEFT, RIGHT and FULL OUTER
-- ============================================================
-- Requiere haber ejecutado antes 01_crear_tablas.sql.
-- Recuerda: todos los JOIN combinan dos tablas. Lo que cambia es qué filas
-- se quedan fuera cuando no hay pareja al otro lado.

-- JOIN básico (INNER JOIN): solo filas con pareja en ambas tablas.
-- Resultado esperado: Juan (2 juguetes) y Ana. Marta NO aparece.
SELECT niños.nombre AS niño, juguetes.nombre AS juguete
FROM niños
JOIN juguetes
  ON juguetes.dueño_id = niños.id;

-- LEFT JOIN: todas las filas de la tabla izquierda, tengan pareja o no.
-- Resultado esperado: Juan, Ana y Marta (con juguete = NULL).
SELECT niños.nombre AS niño, juguetes.nombre AS juguete
FROM niños
LEFT JOIN juguetes
  ON juguetes.dueño_id = niños.id;

-- Regla práctica: si un JOIN normal te hace "perder" filas que esperabas
-- ver, casi siempre la solución es un LEFT JOIN.

-- Para ver RIGHT y FULL OUTER JOIN necesitamos un juguete sin dueño.
INSERT INTO juguetes (id, nombre, dueño_id) VALUES (4, 'Peonza', NULL);

-- RIGHT JOIN: todas las filas de la tabla derecha (juguetes).
-- Resultado esperado: los 4 juguetes, la Peonza con niño = NULL.
SELECT niños.nombre AS niño, juguetes.nombre AS juguete
FROM niños
RIGHT JOIN juguetes
  ON juguetes.dueño_id = niños.id;

-- Lo mismo con LEFT JOIN cambiando el orden de las tablas
-- (así se escribe casi siempre en la práctica).
SELECT niños.nombre AS niño, juguetes.nombre AS juguete
FROM juguetes
LEFT JOIN niños
  ON juguetes.dueño_id = niños.id;

-- FULL OUTER JOIN: todo de ambas tablas, coincida o no.
-- Resultado esperado: Marta (sin juguete) y Peonza (sin niño) a la vez.
SELECT niños.nombre AS niño, juguetes.nombre AS juguete
FROM niños
FULL OUTER JOIN juguetes
  ON juguetes.dueño_id = niños.id;

-- GROUP BY + HAVING: niños con más de un juguete.
-- Resultado esperado: Juan con 2.
SELECT niños.nombre, COUNT(*) AS total
FROM niños
JOIN juguetes
  ON juguetes.dueño_id = niños.id
GROUP BY niños.nombre
HAVING COUNT(*) > 1;
