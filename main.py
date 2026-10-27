import os
import psycopg

url = os.getenv("DATABASE_URL")

try:
    with psycopg.connect(url) as connection:
        with connection.cursor() as cur:
            cur.execute(
                "INSERT INTO viajes (lugar, num_personas, gasto) VALUES (%s, %s, %s);",
                ("Oporto", 3, 1150.50)
            )
            connection.commit()

            cur.execute("SELECT * FROM viajes;")
            filas = cur.fetchall()

            for fila in filas:
                print(fila)
except Exception as e:
    print("Error:", e)
    raise
