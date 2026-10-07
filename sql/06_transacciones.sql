-- ============================================================
-- 06 · Transacciones ACID
-- ACID transactions: Atomicity, Consistency, Isolation, Durability
-- ============================================================
-- Este script es independiente: crea su propia tabla de cuentas.
-- Ejemplo: transferir 100 € de la cuenta A a la cuenta B.

CREATE TABLE cuentas (
  id    TEXT PRIMARY KEY,
  saldo INTEGER NOT NULL CHECK (saldo >= 0)   -- nunca saldo negativo
);
INSERT INTO cuentas VALUES ('A', 500);
INSERT INTO cuentas VALUES ('B', 200);

-- Transferencia correcta: los dos UPDATE ocurren juntos o ninguno.
BEGIN TRANSACTION;
  UPDATE cuentas SET saldo = saldo - 100 WHERE id = 'A';
  UPDATE cuentas SET saldo = saldo + 100 WHERE id = 'B';
COMMIT;                                       -- confirma: A = 400, B = 300

SELECT * FROM cuentas;

-- Transferencia que se deshace (Atomicity):
-- si algo sale mal a medias, ROLLBACK devuelve todo al estado anterior.
BEGIN TRANSACTION;
  UPDATE cuentas SET saldo = saldo - 100 WHERE id = 'A';
  -- Imagina que aquí falla el sistema o se detecta un error...
ROLLBACK;                                     -- deshace el primer UPDATE

SELECT * FROM cuentas;                        -- A sigue en 400, nadie pierde dinero

-- Consistency: la base de datos no permite pasar a un estado inválido.
-- Intentar sacar más dinero del que hay rompe el CHECK (saldo >= 0).
-- Error esperado: CHECK constraint failed: saldo >= 0
BEGIN TRANSACTION;
  UPDATE cuentas SET saldo = saldo - 1000 WHERE id = 'A';
ROLLBACK;

-- Isolation y Durability se observan con varias conexiones a la vez y
-- reiniciando el servidor, así que no se pueden demostrar en un solo script.
-- Isolation: dos transacciones simultáneas no se pisan entre sí.
-- Durability: una vez hecho COMMIT, el cambio sobrevive a una caída.
