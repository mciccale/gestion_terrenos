-- Creamos la DB si no existe
SELECT 'CREATE DATABASE test_gestion_terrenos_db' 
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'test_gestion_terrenos_db')\gexec
-- Nos conectamos a la base de datos
\c test_gestion_terrenos_db;
-- Creamos la tabla terrenos
CREATE TABLE IF NOT EXISTS terrenos (
    id SERIAL PRIMARY KEY,
    ubicacion VARCHAR(255) NOT NULL,
    hectareas FLOAT NOT NULL,
    limites POINT[4] NOT NULL,
    UNIQUE (id)
);
-- Creamos la tabla arrendatarios
CREATE TABLE IF NOT EXISTS arrendatarios (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50)  NOT NULL,
    edad INT,
    sexo CHAR,
    fincas_alquiladas INT[],
    parcelas_alquiladas INT[],
    UNIQUE (dni)
);
-- Creamos la tabla fincas
CREATE TABLE IF NOT EXISTS fincas (
    terreno_id INT PRIMARY KEY,
    tipo_finca VARCHAR(25)  NOT NULL,
    alquilada BOOLEAN NOT NULL,
    fecha_inicio_alquiler DATE,
    periodo_arrendamiento INT,
    importe_alquiler FLOAT,
    dni_arrendatario VARCHAR(20),
    FOREIGN KEY (terreno_id) REFERENCES terrenos(id) ON DELETE CASCADE,
    FOREIGN KEY (dni_arrendatario) REFERENCES arrendatarios(dni) ON DELETE SET NULL,
    CHECK (tipo_finca IN ('avicola', 'ganadera'))
);
-- Creamos la tabla parcelas
CREATE TABLE IF NOT EXISTS parcelas (
    id SERIAL PRIMARY KEY,
    terreno_id INT,
    alquilada BOOLEAN,
    fecha_inicio_alquiler DATE,
    periodo_arrendamiento INT,
    importe_alquiler FLOAT,
    dni_arrendatario VARCHAR(20),
    ubicacion VARCHAR(255) NOT NULL,
    hectareas FLOAT NOT NULL,
    limites POINT[4] NOT NULL,
    UNIQUE (id),
    FOREIGN KEY (terreno_id) REFERENCES terrenos(id) ON DELETE CASCADE,
    FOREIGN KEY (dni_arrendatario) REFERENCES arrendatarios(dni) ON DELETE SET NULL
);
-- Creamos la tabla latifundios
CREATE TABLE IF NOT EXISTS latifundios (
    terreno_id INT,
    parcela_id INT,
    PRIMARY KEY (terreno_id, parcela_id),
    FOREIGN KEY (terreno_id) REFERENCES terrenos(id) ON DELETE CASCADE,
    FOREIGN KEY (parcela_id) REFERENCES parcelas(id) ON DELETE CASCADE
);
-- Creamos la tabla recibos
CREATE TABLE IF NOT EXISTS recibos (
    id SERIAL PRIMARY KEY,
    finca_id INT,
    parcela_id INT,
    fecha_emision DATE,
    tipo_alquiler VARCHAR(25),
    importe FLOAT,
    iva FLOAT,
    irpf FLOAT,
    pagado BOOLEAN,
    UNIQUE (id),
    FOREIGN KEY (finca_id) REFERENCES terrenos(id),
    FOREIGN KEY (parcela_id) REFERENCES parcelas(id)
);
