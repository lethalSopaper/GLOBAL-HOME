-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 08/12/2024
-- Descripción: Pruebas que validan el funcionamiento del procedimiento p_insercion_de_logs

set serveroutput on

declare
    v_file utl_file.file_type;
    v_operacion operaciones_temp%rowtype;
    v_contador number;
begin
    begin
        dbms_output.put_line('Caso 1: Insertando registros en la tabla operaciones_temp');
        insert into operaciones_temp(
            operaciones_temp_id,
            usuario,
            accion,
            tabla_afectada,
            detalle_accion,
            valor_anterior,
            valor_nuevo
        ) values(
            40,
            'Hansel',
            'INSERT',
            'USUARIOS',
            'Se inserto un nuevo usuario',
            null,
            'valor_nuevo'
        );
        insert into operaciones_temp(
            operaciones_temp_id,
            usuario,
            accion,
            tabla_afectada,
            detalle_accion,
            valor_anterior,
            valor_nuevo
        ) values(
            41,
            'Luis',
            'UPDATE',
            'USUARIOS',
            'Se actualizo un usuario',
            'valor_anterior',
            'valor_nuevo'
        );
        insert into operaciones_temp(
            operaciones_temp_id,
            usuario,
            accion,
            tabla_afectada,
            detalle_accion,
            valor_anterior,
            valor_nuevo
        ) values(
            42,
            'Hansel',
            'DELETE',
            'USUARIOS',
            'Se elimino un usuario',
            'valor_anterior',
            null
        );
        p_insercion_de_logs;
        dbms_output.put_line('Registros insertados correctamente');
    exception
        when others then
            dbms_output.put_line('Error al insertar registros: ' || sqlerrm);

    end;

end;
/
rollback;