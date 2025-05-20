
/******************************************************************************
   NAME:
   PURPOSE:   Script que para crear usuario y base de datos en Postgres

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        15/05/2025   Camila Vargas       1. Creación de Base de Datos
******************************************************************************/

CREATE USER parqueo_owner WITH
LOGIN  -- Indica que este usuario(rol) puede autenticarse
NOSUPERUSER -- Indica que este usuario no es un superusuario
INHERIT -- Indica que este rol herede los privilegios de los roles a los que pertenece.
NOREPLICATION; --Indica que este usuario no puede iniciar el proceso de replicación ni activar el modo de copia de seguridad

/***
  Esta sentencia permite cambiar o definir contraseña a un usuario
 */
ALTER USER parqueo_owner WITH PASSWORD '123456';
/**
  Sentencia para crear una base de datos y asigna a un usuario como dueño
 */
CREATE DATABASE parqueo WITH OWNER parqueo_owner;
/**
  Sentencia a asignar todos los privilegios de una base de datos a un usuario
 */
GRANT ALL PRIVILEGES ON DATABASE parqueo TO parqueo_owner;

/**********************************************************************************************************************/
/**

  Sentencia para eliminar una base de datos
 */
-- drop database parqueo;

