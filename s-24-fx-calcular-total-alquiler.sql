-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 06/12/2024
-- Descripción: Creación de una funcion que me permita calular el total de un alquiler

create or replace function calcular_total_alquiler(
    p_vivienda_id in number,
    p_fecha_inicio in date,
    p_fecha_fin in date
) return number is
    v_costo_total number(11,2);
    v_dias_alquiler number(10);
    v_costo_dia vivienda_vacaciones.costo_dia%type;
    v_costo_apartado vivienda_vacaciones.costo_apartado%type;
    v_max_dias vivienda_vacaciones.max_dias%type;
    v_validacion_vivienda number(10);
begin
    -- verificar si p_vivienda_id existe en la tabla vivienda_vacaciones
    select vivienda_vacaciones_id into v_validacion_vivienda
    from vivienda_vacaciones
    where vivienda_vacaciones_id = p_vivienda_id;

    select costo_dia, costo_apartado, max_dias into v_costo_dia, v_costo_apartado, v_max_dias
    from vivienda_vacaciones
    where vivienda_vacaciones_id = p_vivienda_id;
    -- truena en fechas negativas
    v_dias_alquiler := p_fecha_fin - p_fecha_inicio;

    if v_dias_alquiler > v_max_dias then
        raise_application_error(-20000, 'El número de días de alquiler excede el máximo permitido');
    end if;

    v_costo_total := v_costo_dia * v_dias_alquiler + v_costo_apartado;

    return v_costo_total;

exception
    when no_data_found then
        raise_application_error(-20001, 'No se encontró la vivienda');
    when others then
        raise_application_error(-20002, 'Error al calcular el total del alquiler');
end;
/
show errors;