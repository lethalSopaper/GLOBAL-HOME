-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Es script son la pruebas para el procedimiento p_insercion_mensaje_respuesta

set serveroutput on
declare
    v_mensaje_50 mensaje%rowtype;
    v_mensaje_51 mensaje%rowtype;
    v_mensaje_60 mensaje%rowtype;
    v_mensaje_61 mensaje%rowtype;
    v_mensaje_62 mensaje%rowtype;
begin
    -- Se inserta un mensaje de prueba al que vamos a contestar
    insert into mensaje(mensaje_id, titulo, cuerpo, usuario_id, vivienda_id)
    values(50, 'titutlo_de_prueba_id_50', 'cuerpo_de_prueba_id_50',150, 1);
    begin
        dbms_output.put_line('Prueba 1: Mensaje de respuesta para el mensaje con id 50');
        p_insercion_mensaje_respuesta(50,
            51,
            'titulo_de_prueba_respuesta_id_51',
            'cuerpo_de_prueba_respuesta_id_51',
            149,
            1);
        -- Mostrar el mensjae con id 50
        select * into v_mensaje_50 from mensaje where mensaje_id = 50;
        -- Mostrar el mensaje con id 51
        select * into v_mensaje_51 from mensaje where mensaje_id = 51;
        -- Para mostrar los mensajes
        dbms_output.put_line('Mensaje respondido: ' || v_mensaje_50.mensaje_id || ' ' || v_mensaje_50.titulo || ' ' || v_mensaje_50.cuerpo || ' ' || v_mensaje_50.usuario_id || ' ' || v_mensaje_50.vivienda_id || ' ' || v_mensaje_50.mensaje_respuesta_id);
        dbms_output.put_line('Mensaje respuesta: ' || v_mensaje_51.mensaje_id || ' ' || v_mensaje_51.titulo || ' ' || v_mensaje_51.cuerpo || ' ' || v_mensaje_51.usuario_id || ' ' || v_mensaje_51.vivienda_id);
        dbms_output.put_line('Mensaje de respuesta insertado correctamente!');
    exception
        when others then
            rollback;
            dbms_output.put_line('Error al insertar el mensaje de respuesta');
    end;

    -- Se inserta un mensaje de prueba al que vamos a contestar
    insert into mensaje(mensaje_id, titulo, cuerpo, usuario_id, vivienda_id)
    values(60, 'titutlo_de_prueba_id_51', 'cuerpo_de_prueba_id_51',150, 1);
    begin
        dbms_output.put_line('Prueba 2: Mensaje de respuesta para el mensaje con id 60');
        p_insercion_mensaje_respuesta(60,
            61,
            'titulo_de_prueba_respuesta_id_61',
            'cuerpo_de_prueba_respuesta_id_61',
            149,
            1);
        p_insercion_mensaje_respuesta(61,
            62,
            'titulo_de_prueba_respuesta_id_62',
            'cuerpo_de_prueba_respuesta_id_62',
            149,
            1);
        -- Mostrar el mensjae con id 60
        select * into v_mensaje_60 from mensaje where mensaje_id = 60;
        -- Mostrar el mensaje con id 61
        select * into v_mensaje_61 from mensaje where mensaje_id = 61;
        -- Mostrar el mensaje con id 62
        select * into v_mensaje_62 from mensaje where mensaje_id = 62;
        -- Para mostrar los mensajes
        dbms_output.put_line('Mensaje respondido: ' || v_mensaje_60.mensaje_id || ' ' || v_mensaje_60.titulo || ' ' || v_mensaje_60.cuerpo || ' ' || v_mensaje_60.usuario_id || ' ' || v_mensaje_60.vivienda_id || ' ' || v_mensaje_60.mensaje_respuesta_id);
        dbms_output.put_line('Mensaje respuesta 1: ' || v_mensaje_61.mensaje_id || ' ' || v_mensaje_61.titulo || ' ' || v_mensaje_61.cuerpo || ' ' || v_mensaje_61.usuario_id || ' ' || v_mensaje_61.vivienda_id || ' ' || v_mensaje_61.mensaje_respuesta_id);
        dbms_output.put_line('Mensaje respuesta 2: ' || v_mensaje_62.mensaje_id || ' ' || v_mensaje_62.titulo || ' ' || v_mensaje_62.cuerpo || ' ' || v_mensaje_62.usuario_id || ' ' || v_mensaje_62.vivienda_id);
        dbms_output.put_line('Mensajes de respuesta insertado correctamente!');
    exception
        when others then
            rollback;
            dbms_output.put_line('Error al insertar el mensaje de respuesta');
    end;
    rollback;
end;
/