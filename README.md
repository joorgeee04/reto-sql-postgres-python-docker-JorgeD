# Reto final SQL 3 — PostgreSQL + Python + Docker

Proyecto que pone en marcha una base de datos PostgreSQL con Docker Compose y una aplicación en Python, en otro contenedor, que inserta y consulta los datos de una tabla de **viajes**.

## Estructura

```text
mi_proyecto/
├── README.md
├── docker-compose.yml   # Servicios: db (PostgreSQL) y app (Python)
├── Dockerfile           # Imagen de la aplicación Python
├── .dockerignore
├── .gitignore
├── .env.example         # Plantilla de variables de entorno (sin secretos)
├── requirements.txt     # psycopg
├── main.py              # Inserta un viaje y muestra todos los registros
└── consultas.sql        # CREATE TABLE e INSERT iniciales
```

## Servicios

| Servicio | Imagen | Función |
|---|---|---|
| `db` | `postgres:17-alpine` | Base de datos. Publica el puerto `5433` del equipo hacia el `5432` del contenedor y guarda los datos en el volumen `postgresDB`. |
| `app` | Construida desde el `Dockerfile` | Se conecta a `db` mediante `DATABASE_URL`, inserta un registro y muestra el contenido de la tabla. |

## Tabla `viajes`

| Columna | Tipo | Restricciones |
|---|---|---|
| `id` | `INTEGER` | `PRIMARY KEY`, generado automáticamente (`IDENTITY`) |
| `lugar` | `VARCHAR(100)` | `NOT NULL` |
| `num_personas` | `INTEGER` | `CHECK (num_personas > 0)` |
| `gasto` | `NUMERIC(7,2)` | `CHECK (gasto >= 0)` |

## Cómo ejecutarlo

1. Crear el archivo `.env` a partir de la plantilla y cambiar la contraseña (debe coincidir en `POSTGRES_PASSWORD` y en `DATABASE_URL`):

   ```bash
   cp .env.example .env
   ```

2. Arrancar la base de datos:

   ```bash
   docker compose up -d db
   ```

3. Conectarse desde la extensión PostgreSQL de VS Code con `postgresql://postgres@127.0.0.1:5433/pruebadb` y ejecutar `consultas.sql` para crear la tabla e insertar los datos.

4. Ejecutar la aplicación:

   ```bash
   docker compose up --build app
   ```

## Resultado

```text
app-1  | (1, 'Budapest', 4, Decimal('1000.00'))
app-1  | (2, 'Lisboa', 8, Decimal('2498.00'))
app-1  | (3, 'Madrid', 2, Decimal('760.00'))
app-1  | (4, 'Oporto', 3, Decimal('1150.50'))
```

Los tres primeros registros se insertan desde VS Code (`consultas.sql`). El cuarto lo inserta `main.py` (extra opcional) con una consulta parametrizada (`%s`) y `commit()`. Cada ejecución de `app` añade un nuevo registro de Oporto.
