-- Crear la base de datos (opcional)
-- CREATE DATABASE parqueo_universitario;
-- \c parqueo_universitario -- Conectarse a la base si estás en consola

-- Tabla: tipo_usuario
CREATE TABLE tipo_usuario (
    id_tipo_usuario INTEGER PRIMARY KEY,
    nombre_tipo_usuario VARCHAR(50)
);

-- Tabla: usuario
CREATE TABLE usuario (
    id_usuario INTEGER PRIMARY KEY,
    codigo_universitario INTEGER,
    telefono_contacto INTEGER,
    contrasena VARCHAR(50),
    id_tipo_usuario INTEGER REFERENCES tipo_usuario(id_tipo_usuario)
);

-- Tabla: tipo_vehiculo
CREATE TABLE tipo_vehiculo (
    id_tipo_vehiculo INTEGER PRIMARY KEY,
    nombre_tipo_vehiculo VARCHAR(20)
);

-- Tabla: vehiculo
CREATE TABLE vehiculo (
    codigo_sticker INTEGER PRIMARY KEY,
    placa VARCHAR(7) UNIQUE,
    id_tipo_vehiculo INTEGER REFERENCES tipo_vehiculo(id_tipo_vehiculo),
    id_usuario INTEGER REFERENCES usuario(id_usuario)
);

-- Tabla: seccion_parqueo
CREATE TABLE seccion_parqueo (
    id_seccion INTEGER PRIMARY KEY,
    nombre_seccion VARCHAR(50),
    id_tipo_usuario INTEGER REFERENCES tipo_usuario(id_tipo_usuario)
);

-- Tabla: espacio_parqueo
CREATE TABLE espacio_parqueo (
    id_espacio_parqueo INTEGER PRIMARY KEY,
    estado INTEGER,
    id_seccion INTEGER REFERENCES seccion_parqueo(id_seccion)
);

-- Tabla: vehiculo_espacio_parqueo
CREATE TABLE vehiculo_espacio_parqueo (
    id_registro INTEGER PRIMARY KEY,
    fecha_hora_ingreso TIMESTAMP,
    fecha_hora_salida TIMESTAMP,
    placa VARCHAR(7) REFERENCES vehiculo(placa),
    id_espacio_parqueo INTEGER REFERENCES espacio_parqueo(id_espacio_parqueo)
);

-- Tabla: tipo_vehiculo_seccion_parqueo
CREATE TABLE tipo_vehiculo_seccion_parqueo (
    id_tipo_vehiculo INTEGER,
    id_espacio_parqueo INTEGER,
    PRIMARY KEY (id_tipo_vehiculo, id_espacio_parqueo),
    FOREIGN KEY (id_tipo_vehiculo) REFERENCES tipo_vehiculo(id_tipo_vehiculo),
    FOREIGN KEY (id_espacio_parqueo) REFERENCES espacio_parqueo(id_espacio_parqueo)
);
