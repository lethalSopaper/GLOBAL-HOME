-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 28/11/2024
-- Descripción: Creación las tablas del modelo relacional

prompt Conectando con el usuario sys

connect sys/system1@htblugbd_s2 as sysdba 

-- Creando roles
prompt eliminando el rol_admin si es que existe
drop role if exists rol_admin;
prompt creando el rol_admin
create role rol_admin;
prompt otorgando permisos al rol_admin
grant create session to rol_admin;
grant create table to rol_admin;
grant create view to rol_admin;
grant create sequence to rol_admin;
grant create procedure to rol_admin;
grant create trigger to rol_admin;
grant create synonym to rol_admin;
grant create public synonym to rol_admin;

prompt eliminando el rol_invitado si es que existe
drop role if exists rol_invitado;
prompt creando el rol_invitado
create role rol_invitado;
prompt otorgando permisos al rol_invitado
grant create session to rol_invitado;
grant create synonym to rol_invitado;

-- Creando usuarios
prompt eliminando al usuario tu_proy_admin si es que existe
drop user if exists tu_proy_admin cascade;
prompt creando al usuario tu_proy_admin 
create user tu_proy_admin identified by 1234 default tablespace users quota unlimited on users;
prompt asignando roles a tu_proy_admin
grant rol_admin to tu_proy_admin;

prompt eliminando al usuario tu_proy_invitado si es que existe
drop user if exists tu_proy_invitado cascade;
prompt creando al usuario tu_proy_invitado
create user tu_proy_invitado identified by 1234 default tablespace users;
prompt asignando roles a tu_proy_invitado
grant rol_invitado to tu_proy_invitado;

-- creando directorios

prompt creando el directorio para los contratos en pdf
begin
    execute immediate 'create directory pdf_contrato as ''/unam/bd/proyecto/GLOBAL-HOME/pdf/contratos''';
exception
    when others then
        if sqlcode != -955 then
            raise;
        end if;
end;
/
-- Conceder permisos al usuario
grant read, write on directory pdf_contrato to tu_proy_admin;

prompt creando el directorio para los avaluos de propiedad
begin
    execute immediate 'create directory pdf_avaluo as ''/unam/bd/proyecto/GLOBAL-HOME/pdf/avaluos_propiedad''';
exception
    when others then
        if sqlcode != -955 then
            raise;
        end if;
end;
/
-- Conceder permisos al usuario
grant read, write on directory pdf_avaluo to tu_proy_admin;
prompt creando el directorio para la interfaz
begin
    execute immediate 'create directory interfaz as ''/unam/bd/proyecto/GLOBAL-HOME/interfaz''';
exception
    when others then
        if sqlcode != -955 then
            raise;
        end if;
end;
/
-- Conceder permisos al usuario
grant read, write on directory interfaz to tu_proy_admin;