# Bases de Datos Relacionales con SQL

Píldora técnica sobre bases de datos relacionales, presentada en **IA School Barcelona · P1**.
Autora: **Rita Pereira**.

Este repositorio reúne el código SQL de la presentación. Todos los scripts se pueden ejecutar y modificar para practicar lo que se explica en las diapositivas: CRUD, diseño de tablas, integridad, transacciones, JOIN e índices.

> 🇬🇧 **In English:** hands-on SQL scripts that go with a talk on relational databases. You can run every file, break it on purpose and see the error messages. A short English summary and a glossary are at the end of this page.

---

## Qué hay en el repositorio

| Carpeta / archivo | Contenido |
| --- | --- |
| `sql/01_crear_tablas.sql` | Crea las tablas `niños`, `juguetes` y `libros` con claves primarias, claves foráneas y restricciones. Inserta los datos de ejemplo. |
| `sql/02_crud.sql` | CRUD en SQL puro: `INSERT`, `SELECT`, `UPDATE` y `DELETE`, con la regla de probar siempre el `WHERE` con un `SELECT`. |
| `sql/03_joins.sql` | `INNER`, `LEFT`, `RIGHT` y `FULL OUTER JOIN`, con el resultado esperado de cada uno, más `GROUP BY` y `HAVING`. |
| `sql/04_normalizacion.sql` | Primera, segunda y tercera forma normal: el diseño incorrecto y el corregido, uno al lado del otro. |
| `sql/05_integridad.sql` | `NOT NULL`, `UNIQUE`, `FOREIGN KEY` y `CHECK`. Todas las sentencias fallan a propósito para ver el error. |
| `sql/06_transacciones.sql` | Transacciones ACID con una transferencia entre cuentas: `COMMIT`, `ROLLBACK` y una restricción que protege el saldo. |
| `sql/07_indices.sql` | Una tabla de 50.000 filas, una consulta sin índice y la misma con índice, comparando el plan de ejecución. |
| `docs/` | Diapositivas de la presentación (`.pptx` y `.pdf`). |
| `kahoot/` | Las 16 preguntas del Kahoot con la respuesta correcta y el tiempo sugerido. |

## Cómo ejecutarlo

Los scripts están probados con **SQLite 3.39 o superior**, que no necesita instalar ningún servidor. Tienes tres formas de usarlos:

**1. Con Python** (no hay que instalar nada, `sqlite3` viene incluido):

```python
import sqlite3

con = sqlite3.connect(":memory:")   # base de datos temporal en memoria
con.executescript(open("sql/01_crear_tablas.sql", encoding="utf-8").read())
con.executescript(open("sql/02_crud.sql", encoding="utf-8").read())

print(con.execute("SELECT * FROM libros").fetchall())
```

**2. Con la línea de comandos de SQLite:**

```bash
sqlite3 practica.db < sql/01_crear_tablas.sql
sqlite3 practica.db < sql/02_crud.sql
```

**3. Con una herramienta gráfica**, como DB Browser for SQLite: abre una base de datos nueva, pega el contenido de un script en la pestaña de ejecutar SQL y ejecútalo.

### Orden recomendado

Los scripts `01`, `02`, `03` y `05` comparten las tablas del primero, así que **ejecuta siempre `01_crear_tablas.sql` antes**. Los scripts `04`, `06` y `07` son independientes y crean sus propias tablas.

El script `05` está pensado para ejecutarse **sentencia a sentencia**: cada una falla a propósito y el error es la lección. Si lo lanzas entero con `executescript`, se detendrá en la primera.

### Otras bases de datos

La mayor parte del SQL es estándar y funciona igual en PostgreSQL o MySQL. Lo que cambia:

- `INTEGER PRIMARY KEY` pasa a `SERIAL PRIMARY KEY` (PostgreSQL) o `INT AUTO_INCREMENT PRIMARY KEY` (MySQL).
- `PRAGMA foreign_keys = ON;` solo existe en SQLite; en las otras las claves foráneas ya están activas.
- `EXPLAIN QUERY PLAN` de SQLite se escribe `EXPLAIN` o `EXPLAIN ANALYZE` en PostgreSQL y MySQL.
- Los nombres con tilde o ñ (`niños`, `dueño_id`, `año`) funcionan en las tres bases de datos. Si tu herramienta da problemas, usa nombres sin tilde (`ninos`, `duenio_id`, `anio`).

## Ruta de aprendizaje

1. **Tablas y llaves** (`01`): una tabla es un cajón, cada fila una tarjeta, cada columna una etiqueta. La clave primaria identifica cada fila y la clave foránea la conecta con otra tabla.
2. **CRUD** (`02`): las cuatro operaciones básicas en SQL puro.
3. **Normalización** (`04`): decidir qué información va en cada tabla para no repetir datos.
4. **Integridad** (`05`): reglas que la base de datos aplica siempre, sin excepción.
5. **Transacciones ACID** (`06`): varias operaciones que ocurren juntas o no ocurren.
6. **JOIN** (`03`): combinar tablas y entender qué filas se conservan en cada tipo.
7. **Índices** (`07`): encontrar datos rápido en tablas grandes.

## Material complementario

- Diapositivas: [`docs/Bases_de_Datos_Relacionales_SQL.pdf`](docs/Bases_de_Datos_Relacionales_SQL.pdf) y [`.pptx`](docs/Bases_de_Datos_Relacionales_SQL.pptx)
- Preguntas del Kahoot: [`kahoot/Kahoot_Bases_de_Datos_Relacionales.xlsx`](kahoot/Kahoot_Bases_de_Datos_Relacionales.xlsx)

---

## In English

**What is this?** The SQL code behind a talk on relational databases. Each script is runnable and mirrors a section of the slides.

**What you will practise:**

- **CRUD:** `INSERT`, `SELECT`, `UPDATE`, `DELETE`.
- **Design:** first, second and third normal form (1NF, 2NF, 3NF).
- **Integrity:** `NOT NULL`, `UNIQUE`, `FOREIGN KEY`, `CHECK`.
- **Transactions:** ACID, with a bank transfer example.
- **Joins:** `INNER`, `LEFT`, `RIGHT` and `FULL OUTER JOIN`, and when to use each one.
- **Indexes:** why a query gets faster, and what it costs you.

**Quick start:** run `sql/01_crear_tablas.sql` first, then any other script. See the *Cómo ejecutarlo* section above for the Python, command line and GUI options.

### Glossary / Glosario

| English | Español |
| --- | --- |
| table | tabla |
| row / record | fila / registro |
| column | columna |
| primary key | clave primaria |
| foreign key | clave foránea |
| join | unión de tablas |
| index | índice |
| transaction | transacción |
| normalization | normalización |
| constraint | restricción |
| Atomicity, Consistency, Isolation, Durability | Atomicidad, Consistencia, Aislamiento, Durabilidad |
