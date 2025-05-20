-- Crear secuencias
CREATE SEQUENCE seq_usuario START 1;
CREATE SEQUENCE seq_vehiculo START 1;
CREATE SEQUENCE seq_espacio_parqueo START 1;
CREATE SEQUENCE seq_registro START 1;

-- Insertar tipos de usuario
INSERT INTO tipo_usuario (id_tipo_usuario, nombre_tipo_usuario) VALUES
                                                                    (1, 'Estudiante'),
                                                                    (2, 'Administrativo'),
                                                                    (3, 'Docente');

-- Insertar tipos de vehículo
INSERT INTO tipo_vehiculo (id_tipo_vehiculo, nombre_tipo_vehiculo) VALUES
                                                                       (1, 'Moto'),
                                                                       (2, 'Auto'),
                                                                       (3, 'Camioneta');

-- Insertar secciones de parqueo (1 a 8)
INSERT INTO seccion_parqueo (id_seccion, nombre_seccion, id_tipo_usuario) VALUES
                                                                              (1, 'Seccion 1', 1),
                                                                              (2, 'Seccion 2', 1),
                                                                              (3, 'Seccion 3', 2),
                                                                              (4, 'Seccion 4', 2),
                                                                              (5, 'Seccion 5', 3),
                                                                              (6, 'Seccion 6', 3),
                                                                              (7, 'Seccion 7', 1),
                                                                              (8, 'Seccion 8', 2);

-- Insertar 500 usuarios
DO $$
BEGIN
FOR i IN 1..500 LOOP
    INSERT INTO usuario (
      id_usuario, codigo_universitario, telefono_contacto, contrasena, id_tipo_usuario
    ) VALUES (
      nextval('seq_usuario'),
      100000 + i,
      70000000 + i,
      'pass' || i,
      (i % 3) + 1  -- Cicla entre 1 y 3
    );
END LOOP;
END $$;

-- Insertar 1000 vehículos
DO $$
BEGIN
FOR i IN 1..1000 LOOP
    INSERT INTO vehiculo (
      codigo_sticker, placa, id_tipo_vehiculo, id_usuario
    ) VALUES (
      nextval('seq_vehiculo'),
      'ABC' || LPAD(i::TEXT, 4, '0'),
      (i % 3) + 1,
      ((i - 1) % 500) + 1
    );
END LOOP;
END $$;

-- Insertar 200 espacios de parqueo (25 por sección)
DO $$
BEGIN
FOR i IN 1..200 LOOP
    INSERT INTO espacio_parqueo (
      id_espacio_parqueo, estado, id_seccion
    ) VALUES (
      nextval('seq_espacio_parqueo'),
      0,  -- Disponible
      ((i - 1) % 8) + 1
    );
END LOOP;
END $$;

-- Vincular tipo_vehiculo con espacios de parqueo (permite todos)
INSERT INTO tipo_vehiculo_seccion_parqueo (id_tipo_vehiculo, id_espacio_parqueo)
SELECT
    tv.id_tipo_vehiculo,
    ep.id_espacio_parqueo
FROM tipo_vehiculo tv, espacio_parqueo ep;

-- Insertar 10,000 registros en vehiculo_espacio_parqueo
DO $$
DECLARE
v_placa TEXT;
  v_espacio_id INTEGER;
  v_ingreso TIMESTAMP;
  v_salida TIMESTAMP;
BEGIN
FOR i IN 1..10000 LOOP
SELECT placa INTO v_placa FROM vehiculo ORDER BY random() LIMIT 1;
SELECT id_espacio_parqueo INTO v_espacio_id FROM espacio_parqueo ORDER BY random() LIMIT 1;

v_ingreso := NOW() - INTERVAL '30 days' * random();
    v_salida := v_ingreso + INTERVAL '1 hour' * (1 + random() * 5);

INSERT INTO vehiculo_espacio_parqueo (
    id_registro, fecha_hora_ingreso, fecha_hora_salida, placa, id_espacio_parqueo
) VALUES (
             nextval('seq_registro'),
             v_ingreso,
             v_salida,
             v_placa,
             v_espacio_id
         );
END LOOP;
END $$;
