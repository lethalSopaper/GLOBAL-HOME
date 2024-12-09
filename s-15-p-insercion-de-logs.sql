-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 04/12/2024
-- Descripcion: Creacion de un procedimiento que inserte logs en el archivo logs_ext.csv

create or replace procedure p_insercion_de_logs as
    v_file utl_file.file_type;

    cursor c_operaciones is
        select *
        from operaciones_temp;
    
    v_operacion operaciones_temp%rowtype;

begin

    v_file := utl_file.fopen('LOGS_DIR', 'logs_ext.csv', 'a');
    for v_operacion in c_operaciones loop
        utl_file.put_line(v_file,
        v_operacion.operaciones_temp_id || ',' ||
        v_operacion.usuario || ',' ||
        v_operacion.accion || ',' ||
        v_operacion.tabla_afectada || ',' ||
        v_operacion.detalle_accion || ',' ||
        to_char(v_operacion.fecha_evento, 'DD/MM/YYYY HH24:MM:SS') || ',' ||
        nvl(v_operacion.valor_anterior,'NULL')|| ',' || 
        nvl(v_operacion.valor_nuevo, 'NULL'));
    end loop;

    utl_file.fclose(v_file);

    exception
        when others then
            if utl_file.is_open(v_file) then
                utl_file.fclose(v_file);
            end if;
            raise;
end;
/
show errors;