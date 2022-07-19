-- Parte 2: Creación de base de datos y tablas iniciales
-- Creamos la base de datos
CREATE DATABASE MUNDIAL_QATAR;
-- Creamos un schema
CREATE SCHEMA comercial;
-- Creamos dentro del schema comercial la tabla compra_boleta
CREATE TABLE comercial.compra_boleta(
    nacionalidad CHARACTER VARYING,
    pasaporte CHARACTER VARYING,
    nombre CHARACTER VARYING,
    edad INTEGER,
    precio_boleta DOUBLE PRECISION,
    fecha_partido TIMESTAMP,
    equipo_1 CHARACTER VARYING,
    equipo_2 CHARACTER VARYING,
    boleta BOOLEAN);

-- Agregamos la columna de fecha de compra de la boleta
ALTER TABLE comercial.compra_boleta ADD fecha_compra_boleta CHARACTER VARYING;

-- Cambiamos el tipo de dato de la columna fecha_compra_boleta por tipo de dato DATE
ALTER TABLE comercial.compra_boleta ALTER COLUMN fecha_compra_boleta TYPE DATE;

-- Insertamos 5 filas
INSERT INTO comercial.compra_boleta(
        nacionalidad,
        pasaporte,
        nombre,
        edad,
        precio_boleta,
        fecha_partido,
        equipo_1,
        equipo_2,
        boleta,
        fecha_compra_boleta
    ) VALUES(
             'peruano',
             '1185984',
             'Kenyi Hancco',
             28,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             True,
             '2022-11-18'
            );

INSERT INTO comercial.compra_boleta(
        nacionalidad,
        pasaporte,
        nombre,
        edad,
        precio_boleta,
        fecha_partido,
        equipo_1,
        equipo_2,
        boleta,
        fecha_compra_boleta
    ) VALUES(
             'peruano',
             '1187884',
             'Juanito Alcachoofa',
             21,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             false,
             '2022-11-18'
            ), (
             'colombiano',
             '1185784',
             'Juan Perez',
             25,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             True,
             '2022-11-18'
            ), (
             'mexicano',
             '1184884',
             'Pepe Juarez',
             55,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             True,
             '2022-11-18'
            ), (
             'chileno',
             '1189984',
             'Jorge Gonzales',
             33,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             True,
             '2022-11-18'
            ), (
             'peruano',
             '1285984',
             'Juan Tapia',
             35,
             618,
             '2022-11-21 13:00',
             'Qatar',
             'Ecuador',
             True,
             '2022-11-18'
            );
INSERT INTO comercial.compra_boleta(
        nacionalidad,
        pasaporte,
        nombre,
        edad,
        precio_boleta,
        fecha_partido,
        equipo_1,
        equipo_2,
        boleta,
        fecha_compra_boleta
    ) VALUES(
             'peruano',
             '1187884',
             'Juanito Alcachoofa',
             21,
             1618,
             '2022-11-21 13:00',
             'Inglaterra',
             'Iran',
             false,
             '2022-11-18'
            ), (
             'colombiano',
             '1185784',
             'Juan Perez',
             25,
             1218,
             '2022-11-21 13:00',
             'EEUU',
             'Gales',
             True,
             '2022-11-18'
            ), (
             'mexicano',
             '1184884',
             'Pepe Juarez',
             55,
             1218,
             '2022-11-21 13:00',
             'EEUU',
             'Gales',
             True,
             '2022-11-18'
            ), (
             'chileno',
             '1189984',
             'Jorge Gonzales',
             33,
             1618,
             '2022-11-21 13:00',
             'Inglaterra',
             'Iran',
             True,
             '2022-11-18'
            ), (
             'peruano',
             '1285984',
             'Juan Tapia',
             35,
             1618,
             '2022-11-21 13:00',
             'Inglaterra',
             'Iran',
             True,
             '2022-11-18'
            );
INSERT INTO comercial.compra_boleta(
        nacionalidad,
        pasaporte,
        nombre,
        edad,
        precio_boleta,
        fecha_partido,
        equipo_1,
        equipo_2,
        boleta,
        fecha_compra_boleta
    ) VALUES(
             'peruano',
             '1185984',
             'Kenyi Hancco',
             28,
             5618,
             '2022-11-21 13:00',
             'Inglaterra',
             'Iran',
             False,
             '2022-11-19'
            );


-- Hacemos una consulta para ver los registros insertados

SELECT * FROM comercial.compra_boleta;

-- Parte 3: Creación de consultas de datos principales
-- Vistas

-- Generamos la consulta para crear nuestra vista
SELECT * FROM comercial.compra_boleta
    WHERE equipo_1 IN ('Brasil', 'Argentina', 'Uruguay', 'Ecuador')
       OR equipo_2 IN ('Brasil', 'Argentina', 'Uruguay', 'Ecuador');

CREATE VIEW comercial.partidos_latam AS(
    SELECT * FROM comercial.compra_boleta
    WHERE equipo_1 IN ('Brasil', 'Argentina', 'Uruguay', 'Ecuador')
       OR equipo_2 IN ('Brasil', 'Argentina', 'Uruguay', 'Ecuador')
                                       );

-- Consultamos nuestra vista
SELECT * FROM comercial.partidos_latam;

-- Vista precio joven

SELECT * FROM comercial.compra_boleta
    WHERE edad < 30 AND precio_boleta > 1000;

CREATE VIEW comercial.precio_joven AS(
    SELECT * FROM comercial.compra_boleta
    WHERE edad < 30 AND precio_boleta > 1000
                                     );

-- Consultamos la vista creada

SELECT * FROM comercial.precio_joven;

-- Vista cantidad boletas partidas

SELECT equipo_1 || ' vs ' || equipo_2 AS Partido,
    count(boleta) AS Cantidad
    FROM comercial.compra_boleta
    GROUP BY Partido;

CREATE VIEW comercial.cantidad_boleta_partido AS(
    SELECT equipo_1 || ' vs ' || equipo_2 AS Partido,
        count(boleta) AS Cantidad_de_boletos
        FROM comercial.compra_boleta
        GROUP BY Partido
                                                );

-- Consultamos la vista creada

SELECT * FROM comercial.cantidad_boleta_partido;

-- Parte 4: Creación del segundo modelo de datos y sus respectivas vistas

-- Agregamos el identificador a la primera tabla
ALTER TABLE comercial.compra_boleta ADD COLUMN id_compra_boleto SERIAL NOT NULL;
ALTER TABLE comercial.compra_boleta ADD PRIMARY KEY (id_compra_boleto);

-- Creamos una siguiete tabla
CREATE TABLE comercial.intercambio(
    fecha_intercambio DATE,
    id_intercambio SERIAL NOT NULL ,
    id_venta_boleto INT,
    pasaporte CHARACTER VARYING,
    PRIMARY KEY (id_intercambio),
    CONSTRAINT fk_intercambio FOREIGN KEY(id_venta_boleto) REFERENCES comercial.compra_boleta(id_compra_boleto)
);

-- Agregamos filas a nuestra table
INSERT INTO comercial.intercambio(fecha_intercambio, id_venta_boleto, pasaporte)
    VALUES (
            '2022-07-19',
            7,
            1285789
           );
INSERT INTO comercial.intercambio(fecha_intercambio, id_venta_boleto, pasaporte)
    VALUES (
            '2022-07-19',
            12,
            1285789
           );
INSERT INTO comercial.intercambio(fecha_intercambio, id_venta_boleto, pasaporte)
    VALUES (
            '2022-07-19',
            2,
            1285789
           );
-- Consultamos
SELECT * FROM comercial.intercambio;

-- Creamos vistas

CREATE VIEW comercial.personas_final_transferida AS
    SELECT t1.pasaporte FROM comercial.intercambio t1
    RIGHT JOIN comercial.compra_boleta t2 on t2.id_compra_boleto = t1.id_venta_boleto
    WHERE t2.precio_boleta > 5000;

-- Consultamos la vista
SELECT * FROM comercial.personas_final_transferida;


-- Creamos la vista dinero_boletas_qatar_transferida
CREATE VIEW comercial.dinero_boletas_qatar_intercambio AS (
    SELECT sum(t2.precio_boleta) FROM comercial.intercambio t1
    LEFT JOIN comercial.compra_boleta t2 ON t2.id_compra_boleto = t1.id_venta_boleto
    WHERE t2.equipo_1 = 'Qatar' OR t2.equipo_2 = 'Qatar'
                                                          );

-- Consultamos la vista
SELECT * FROM comercial.dinero_boletas_qatar_intercambio;