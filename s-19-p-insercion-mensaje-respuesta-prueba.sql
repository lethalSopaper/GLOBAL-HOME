-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Es script son la pruebas para el procedimiento p_insercion_mensaje_respuesta

set serveroutput on
declare
    v_mensaje_70 mensaje%rowtype;
    v_mensaje_71 mensaje%rowtype;
    v_mensaje_72 mensaje%rowtype;
begin
    -- Se inserta un mensaje de prueba al que vamos a contestar
    insert into mensaje(mensaje_id, titulo, cuerpo, usuario_id, vivienda_id)
    values(50, 'titutlo_de_prueba_id_50', 'cuerpo_de_prueba_id_50',150, 1);
    -- Caso 1: Se responde dos veces al mensaje con id 50
    begin
        dbms_output.put_line('Caso 1: Se responde dos veces al mensaje con id 50');
        p_insercion_mensaje_respuesta(50,
            51,
            'titulo_de_prueba_respuesta_id_51',
            'cuerpo_de_prueba_respuesta_id_51',
            149,
            1);
        p_insercion_mensaje_respuesta(50,
            52,
            'titulo_de_prueba_respuesta_id_52',
            'cuerpo_de_prueba_respuesta_id_52',
            149,
            1);
        dbms_output.put_line('Mensajes de respuesta insertado correctamente (ERROR)');
        rollback;
    exception
        when others then
            if sqlcode = -20100 then
                rollback;
                dbms_output.put_line('Error esperado al insertar mensaje!' || chr(10) || sqlerrm);
            elsif sqlcode = -20200 then
                rollback;
                dbms_output.put_line('No existe el mensaje al que se está respondiendo (ERROR)' || chr(10) || sqlerrm);
            elsif sqlcode = -20300 then
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta (ERROR)' || chr(10) || sqlerrm);
            else
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta_1 (ERROR)' || chr(10) || sqlerrm);
            end if;
        rollback;
    end;
    -- Caso 2: Se responde a un mensaje que no existe
    begin
        dbms_output.put_line('Caso 2: Se responde a un mensaje que no existe');
        p_insercion_mensaje_respuesta(60,
            61,
            'titulo_de_prueba_respuesta_id_61',
            'cuerpo_de_prueba_respuesta_id_61',
            149,
            1);
        dbms_output.put_line('Mensajes de respuesta insertado correctamente (ERROR)');
    exception
        when others then
            if sqlcode = -20100 then
                rollback;
                dbms_output.put_line('Se está respondiendo a un mensaje que ya existe (ERROR)' || chr(10) || sqlerrm);
            elsif sqlcode = -20200 then
                rollback;
                dbms_output.put_line('Error esperado al insertar mensaje!' || chr(10) || sqlerrm);
            elsif sqlcode = -20300 then
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta (ERROR)' || chr(10) || sqlerrm);
            else
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta_1 (ERROR)' || chr(10) || sqlerrm);
            end if;
        rollback;
    end;
    -- Se inserta un mensaje de prueba al que vamos a contestar
    insert into mensaje(mensaje_id, titulo, cuerpo, usuario_id, vivienda_id)
    values(70, 'titutlo_de_prueba_id_61', 'cuerpo_de_prueba_id_61',150, 1);
    -- Caso 3; Se reponde a un mensjae de manera adecuada
    begin
        dbms_output.put_line('Caso 3; Se reponde a un mensjae de manera adecuada');
        p_insercion_mensaje_respuesta(70,
            71,
            'titulo_de_prueba_respuesta_id_71',
            'cuerpo_de_prueba_respuesta_id_71',
            149,
            1);
        p_insercion_mensaje_respuesta(71,
            72,
            'titulo_de_prueba_respuesta_id_72',
            'cuerpo_de_prueba_respuesta_id_72',
            149,
            1);
        dbms_output.put_line('Mensajes de respuesta insertado correctamente !');
        -- Se imprimer el contenido de cada mensaje
        select * into v_mensaje_70 from mensaje where mensaje_id = 70;
        select * into v_mensaje_71 from mensaje where mensaje_id = 71;
        select * into v_mensaje_72 from mensaje where mensaje_id = 72;
        dbms_output.put_line('Mensaje 70: ' || v_mensaje_70.mensaje_id || ' ' || v_mensaje_70.titulo || ' ' || v_mensaje_70.cuerpo || ' ' || v_mensaje_70.usuario_id || ' ' || v_mensaje_70.vivienda_id || ' ' || v_mensaje_70.mensaje_respuesta_id);
        dbms_output.put_line('Mensaje 71: ' || v_mensaje_71.mensaje_id || ' ' || v_mensaje_71.titulo || ' ' || v_mensaje_71.cuerpo || ' ' || v_mensaje_71.usuario_id || ' ' || v_mensaje_71.vivienda_id || ' ' || v_mensaje_71.mensaje_respuesta_id);
        dbms_output.put_line('Mensaje 72: ' || v_mensaje_72.mensaje_id || ' ' || v_mensaje_72.titulo || ' ' || v_mensaje_72.cuerpo || ' ' || v_mensaje_72.usuario_id || ' ' || v_mensaje_72.vivienda_id);
    exception
        when others then
            if sqlcode = -20100 then
                rollback;
                dbms_output.put_line('Se está respondiendo a un mensaje que ya existe (ERROR)' || chr(10) || sqlerrm);
            elsif sqlcode = -20200 then
                rollback;
                dbms_output.put_line('No existe el mensaje al que se está respondiendo (ERROR)' || chr(10) || sqlerrm);
            elsif sqlcode = -20300 then
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta (ERROR)' || chr(10) || sqlerrm);
            else
                rollback;
                dbms_output.put_line('Error al insertar el mensaje de respuesta_1 (ERROR)' || chr(10) || sqlerrm);
            end if;
        rollback;
    end;
    rollback;
end;
/