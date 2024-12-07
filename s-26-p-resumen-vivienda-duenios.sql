-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Este procedimiento busca imprimir un resumen de calificaciones y ganancias para los dueños de viviendas teniendo en cuenta todos lo tipos de viviendas que poseen.

create or replace procedure p_resumen_vivienda_duenios
as
    -- cursor para seleccionar todas las viviendas y dueños
    cursor cur_duenios is
        select v.usuario_duenio_id
        from vivienda v;
    -- -- cursor para seleccionar todas las viviendas de un dueño
    -- cursor cur_viviendas is
    --     select v.vivienda_id, v.es_vacaciones, v.es_renta, v.es_venta,
    --     ev.clave as clave_estatus, v.usuario_duenio_id, a.costo_total
    --     from vivienda v
    --     join estatus_vivienda ev on v.estatus_vivienda_id = ev.estatus_vivienda_id;
    -- -- variable para almacenar un registro de vivienda
    -- v_vivienda cur_viviendas%rowtype;
    -- variable para saber la cantidad de viviendas de vacaciones-renta
    v_cantidad_viviendas_vacaciones_renta number := 0;
    -- variable para saber la cantidad de viviendas de vacaciones
    v_cantidad_viviendas_vacaciones number := 0;
    -- variable para saber la calificación promedio de las viviendas vacaciones
    v_calificacion_promedio number := 0;
    -- variable para saber la cantidad de viviendas de renta
    v_cantidad_viviendas_renta number := 0;
    -- variable para saber la cantidad de viviendas de venta
    v_cantidad_viviendas_venta number := 0;
begin
    -- loop para recorrer cada dueño de vivienda
    for duenio in cur_duenios loop
        -- Cantidad de viviendas de vacaciones y renta
        select count(*) into v_cantidad_viviendas_vacaciones_renta
        from vivienda
        where v.usuario_duenio_id = duenio.usuario_duenio_id
        and es_vacaciones = true
        and es_renta = true
        and es_venta = false;
        -- Cantidad de viviendas de vacaciones
        select count(*) into v_cantidad_viviendas_vacaciones
        from vivienda
        where v.usuario_duenio_id = duenio.usuario_duenio_id
        and es_vacaciones = true
        and es_renta = false
        and es_venta = false;
        -- Cantidad de viviendas de renta
        select count(*) into v_cantidad_viviendas_renta
        from vivienda
        where v.usuario_duenio_id = duenio.usuario_duenio_id    
        and es_vacaciones = false
        and es_renta = true
        and es_venta = false;
        -- Cantidad de viviendas de venta
        select count(*) into v_cantidad_viviendas_venta
        from vivienda
        where v.usuario_duenio_id = duenio.usuario_duenio_id
        and es_vacaciones = false
        and es_renta = false
        and es_venta = true;
        
    end loop;
end;
/