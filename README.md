# Reto final SQL 3 - PostgreSQL + Python + Docker

En este proyecto he levantado una base de datos PostgreSQL con Docker Compose y he creado una app en Python que se conecta a ella desde otro contenedor.

## Tabla

He creado una tabla `viajes` con estos campos:

- `id`: clave primaria, se genera sola.
- `lugar`: texto, obligatorio.
- `num_personas`: número entero mayor que 0.
- `gasto`: dinero gastado. Uso `NUMERIC(7,2)` en vez de `FLOAT` para que los decimales sean exactos.

El `CREATE TABLE` y los `INSERT` están en `consultas.sql`.

## Contenedores

- `db`: la base de datos PostgreSQL. Desde mi ordenador me conecto por el puerto 5433.
- `app`: ejecuta `main.py`, que inserta un viaje nuevo y muestra todos los registros de la tabla.

## Cómo ejecutarlo

1. Copiar `.env.example` a `.env` y poner una contraseña.
2. Arrancar la base de datos: `docker compose up -d db`
3. Conectarse desde VS Code a `postgresql://postgres@127.0.0.1:5433/pruebadb` y ejecutar `consultas.sql`.
4. Ejecutar la app: `docker compose up --build app`

## Resultado

```
app-1  | (1, 'Budapest', 4, Decimal('1000.00'))
app-1  | (2, 'Lisboa', 8, Decimal('2498.00'))
app-1  | (3, 'Madrid', 2, Decimal('760.00'))
app-1  | (4, 'Oporto', 3, Decimal('1150.50'))
```
