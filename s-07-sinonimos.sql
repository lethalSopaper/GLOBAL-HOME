-- Autor: Tepal Briseño Hansel Yael y Ugartechea Gonzales Luis Antonio
-- Fecha: 31/11/2024
-- Descripción: Creación de sinonimos para las tablas de la base de datos

-- creado sinonimos publicos para tu_proy_admin

create or replace public synonym historico_estatus_vivienda for tu_proy_admin.historico_estatus_vivienda;
create or replace public synonym vivienda for tu_proy_admin.vivienda;
create or replace public synonym servicio for tu_proy_admin.servicio;
create or replace public synonym servicio_vivienda for tu_proy_admin.servicio_vivienda;
create or replace public synonym estatus_vivienda for tu_proy_admin.estatus_vivienda;

-- permisos para acceder a las tablas

grant select on tu_proy_admin.historico_estatus_vivienda to tu_proy_invitado;
grant select on tu_proy_admin.vivienda_renta to tu_proy_invitado;
grant select on tu_proy_admin.clabe to tu_proy_invitado;
grant select on tu_proy_admin.vivienda_vacaciones to tu_proy_invitado;
grant select on tu_proy_admin.vivienda_venta to tu_proy_invitado;
grant select on tu_proy_admin.vivienda to tu_proy_inivtado;
grant select on tu_proy_admin.servicio to tu_proy_invitado;
grant select on tu_proy_admin.servicio_vivienda to tu_proy_invitado;
grant select on tu_proy_admin.estatus_vivienda to tu_proy_invitado;

prompt conectando con el usuario tu_proy_invitado para crear sus sinonimos
connect tu_proy_invitado/1234@htblugbd_s2

-- sinonimos publicos para tu_proy_invitado

create or replace synonym clabe for tu_proy_admin.clabe;
create or replace synonym vivienda_renta for tu_proy_admin.vivienda_renta;
create or replace synonym vivienda_vacaciones for tu_proy_admin.vivienda_vacaciones;
create or replace synonym vivienda_venta for tu_proy_admin.vivienda_venta;

propmpt conectando con el usuario tu_proy_admin para crear sinonimos privados

connect tu_proy_admin/1234@htblugbd_s2

declare
type tabla_type is table of varchar2(30);
v_tabla tabla_type := tabla_type('usuario', 'tarjeta', 'vivienda', 'servicio', 
    'mensaje', 'estatus_vivienda', 'imagen','servicio_vivienda', 'historico_estatus_vivienda',
    'vivienda_renta', 'vivienda_vacaciones', 'vivienda_venta', 'clabe', 'favorito', 
    'alquiler', 'encuesta', 'renta', 'compra', 'pago');
v_iniciales varchar2(2) := 'TU';
begin
    for i in 1.. v_tabla.count loop
        execute immediate 'create or replace synonym '||v_iniciales||'_'||v_tabla(i)||' for tu_proy_admin.'||v_tabla(i);
    end loop;
end;
/





