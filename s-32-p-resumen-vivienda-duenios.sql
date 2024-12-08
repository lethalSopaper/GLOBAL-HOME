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
    -- variable para saber la cantidad de viviendas de vacaciones
    v_cantidad_viviendas_vacaciones number := 0;
    -- variable para saber la calificación promedio de las viviendas vacaciones
    v_calificacion_promedio number := 0;
    -- variable para saber la cantidad de viviendas de renta
    v_cantidad_viviendas_renta number := 0;
    -- variable para saber la cantidad de viviendas de venta
    v_cantidad_viviendas_venta number := 0;
begin
    -- Para cada dueño de vivienda
    for 
end;
/