-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 28/11/2024
-- Descripción: Creación las tablas del modelo relacional

prompt Conectando con el usuario sys

connect sys/system1@htblugbd_s2 as sysdba 

prompt creato el rol_admin si es que existe
drop role if exists rol_admin;
prompt creando el rol_admin
create role rol_admin;
prompt otorgando permisos al rol_admin
grant create session to rol_admin;
grant create table to rol_admin;
grant create view to rol_admin;
grant create sequence to rol_admin;
grant create procedure to rol_admin;
grant create synonym to rol_admin;
grant create public synonym to rol_admin;

prompt creado el rol_invitado si es que existe
drop role if exists rol_invitado;
prompt creando el rol_invitado
create role rol_invitado;
prompt otorgando permisos al rol_invitado
grant create session to rol_invitado;


prompt eliminando al usuario tu_proy_admin si es que existe
drop user if exists tu_proy_admin cascade;
prompt creando al usuario tu_proy_admin 
create user tu_proy_admin identified by 1234 quota unlimited on users;
prompt asignando roles a tu_proy_admin
grant rol_admin to tu_proy_admin;

prompt eliminando al usuario tu_proy_invitado si es que existe
drop user if exists tu_proy_invitado cascade;
prompt creando al usuario tu_proy_invitado
create user tu_proy_invitado identified by 1234;
prompt asignando roles a tu_proy_invitado
grant rol_invitado to tu_proy_invitado;
