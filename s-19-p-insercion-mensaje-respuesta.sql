-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Este procedimiento se encarga de insertar un mensaje que es respuesta de otro y cambiar la fk para el mensaje al que se está respondiendo

create or replace procedure p_insercion_mensaje_respuesta(
    p_mensaje_respondido_id in mensaje.mensaje_id%type,
    p_mensaje_respuesta_id in mensaje.mensaje_id%type,
    p_titulo in mensaje.titulo%type,
    p_cuerpo in mensaje.cuerpo%type,
    -- p_leido in mensaje.leido%type,
    -- p_fehca_envio in mensaje.fecha_envio%type,
    p_usuario_id in mensaje.usuario_id%type,    
    p_vivienda_id in mensaje.vivienda_id%type
)as
begin
    -- Se inserta el mensaje de respuesta
    insert into mensaje(mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id)
    values(p_mensaje_respuesta_id, p_titulo, p_cuerpo, false, sysdate, p_usuario_id, p_vivienda_id);

    -- Se actualiza el mensaje al que se está respondiendo
    update mensaje set
    mensaje_respuesta_id = p_mensaje_respuesta_id
    where mensaje_id = p_mensaje_respondido_id;

exception
    when others then
        raise_application_error(-30001, 'Error al insertar el mensaje de respuesta');
end;
/
show errors;