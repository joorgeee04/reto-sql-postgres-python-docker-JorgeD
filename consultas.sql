CREATE TABLE viajes (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lugar        VARCHAR(100)  NOT NULL,
    num_personas INTEGER       CHECK (num_personas > 0),
    gasto        NUMERIC(7,2) CHECK (gasto >= 0)
);

INSERT INTO viajes (lugar, num_personas, gasto) VALUES
    ('Budapest', 4, 1000),
    ('Lisboa', 8, 2498),
    ('Madrid', 2, 760);


SELECT * FROM viajes;


