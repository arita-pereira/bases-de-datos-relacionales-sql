-- ============================================================
-- 04 · Normalización: 1FN, 2FN y 3FN con ejemplos
-- Normalization: first, second and third normal form
-- ============================================================
-- Este script es independiente: crea sus propias tablas.
-- Cada bloque muestra primero el diseño que ROMPE la forma normal
-- y después el diseño corregido.

PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------
-- 1FN: cada celda guarda un solo valor
-- ------------------------------------------------------------
-- ✗ Antes: dos teléfonos en una misma celda.
CREATE TABLE clientes_mal (
  id        INTEGER PRIMARY KEY,
  nombre    TEXT,
  teléfonos TEXT                        -- '600111222, 600333444'
);
INSERT INTO clientes_mal VALUES (1, 'Juan', '600111222, 600333444');

-- ✓ Después: una fila por teléfono, en una tabla aparte.
CREATE TABLE clientes (
  id     INTEGER PRIMARY KEY,
  nombre TEXT NOT NULL
);
CREATE TABLE teléfonos (
  id         INTEGER PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  número     TEXT    NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);
INSERT INTO clientes VALUES (1, 'Juan');
INSERT INTO teléfonos VALUES (1, 1, '600111222');
INSERT INTO teléfonos VALUES (2, 1, '600333444');

-- ------------------------------------------------------------
-- 2FN: cada columna depende de TODA la clave primaria
-- ------------------------------------------------------------
-- ✗ Antes: nombre_producto depende solo de producto_id,
--   no de la clave completa (pedido_id + producto_id).
CREATE TABLE pedidos_productos_mal (
  pedido_id       INTEGER,
  producto_id     INTEGER,
  nombre_producto TEXT,
  cantidad        INTEGER,
  PRIMARY KEY (pedido_id, producto_id)
);
INSERT INTO pedidos_productos_mal VALUES (101, 5, 'Cuaderno A5', 2);
INSERT INTO pedidos_productos_mal VALUES (101, 8, 'Bolígrafo azul', 1);
INSERT INTO pedidos_productos_mal VALUES (102, 5, 'Cuaderno A5', 3);  -- nombre repetido

-- ✓ Después: tabla puente con clave compuesta + tabla productos.
CREATE TABLE productos (
  id              INTEGER PRIMARY KEY,
  nombre_producto TEXT NOT NULL
);
CREATE TABLE pedidos_productos (
  pedido_id   INTEGER,
  producto_id INTEGER,
  cantidad    INTEGER NOT NULL,
  PRIMARY KEY (pedido_id, producto_id),
  FOREIGN KEY (producto_id) REFERENCES productos (id)
);
INSERT INTO productos VALUES (5, 'Cuaderno A5');
INSERT INTO productos VALUES (8, 'Bolígrafo azul');
INSERT INTO pedidos_productos VALUES (101, 5, 2);
INSERT INTO pedidos_productos VALUES (101, 8, 1);
INSERT INTO pedidos_productos VALUES (102, 5, 3);

-- Si cambia el nombre de un producto, ahora se actualiza en UN solo sitio.
UPDATE productos SET nombre_producto = 'Cuaderno A5 cuadriculado' WHERE id = 5;

-- Para ver el nombre junto a cada pedido, usamos un JOIN.
SELECT pp.pedido_id, p.nombre_producto, pp.cantidad
FROM pedidos_productos pp
JOIN productos p ON p.id = pp.producto_id;

-- ------------------------------------------------------------
-- 3FN: ninguna columna depende de otra que no sea la clave
-- ------------------------------------------------------------
-- ✗ Antes: nombre_departamento depende de departamento_id,
--   no del empleado (dependencia transitiva).
CREATE TABLE empleados_mal (
  id                  INTEGER PRIMARY KEY,
  nombre              TEXT,
  departamento_id     INTEGER,
  nombre_departamento TEXT
);
INSERT INTO empleados_mal VALUES (1, 'Juan', 10, 'Ventas');
INSERT INTO empleados_mal VALUES (2, 'Ana', 10, 'Ventas');
INSERT INTO empleados_mal VALUES (3, 'Marta', 20, 'Soporte');

-- ✓ Después: el nombre del departamento vive en su propia tabla.
CREATE TABLE departamentos (
  id                  INTEGER PRIMARY KEY,
  nombre_departamento TEXT NOT NULL
);
CREATE TABLE empleados (
  id              INTEGER PRIMARY KEY,
  nombre          TEXT NOT NULL,
  departamento_id INTEGER,
  FOREIGN KEY (departamento_id) REFERENCES departamentos (id)
);
INSERT INTO departamentos VALUES (10, 'Ventas');
INSERT INTO departamentos VALUES (20, 'Soporte');
INSERT INTO empleados VALUES (1, 'Juan', 10);
INSERT INTO empleados VALUES (2, 'Ana', 10);
INSERT INTO empleados VALUES (3, 'Marta', 20);

-- Si "Ventas" cambia de nombre, se toca UNA fila, no varias.
UPDATE departamentos SET nombre_departamento = 'Comercial' WHERE id = 10;

SELECT e.nombre, d.nombre_departamento
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id;
