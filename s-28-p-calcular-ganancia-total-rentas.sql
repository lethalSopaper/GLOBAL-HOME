-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Procedimiento que calcula la renta total de una vivienda

create or replace procedure p_calcular_ganancia_total_rentas(
    p_ganancia_total_rentas out number,
    p_usuario_duenio_id in number
) as
    v_ganancia_total_rentas_anteriores number := 0;
    v_ganancia_total_rentas_activas number := 0;
    v_ganancia_total_rentas number := 0;
begin
    -- Se calcula el total de las rentas anteriores
    select sum(trunc(months_between(r.fecha_fin, r.fecha_inicio)) * vr.renta_mensual)
    into v_ganancia_total_rentas_anteriores
    from vivienda v
    join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
    join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
    where v.usuario_duenio_id = p_usuario_duenio_id
    and r.fecha_fin is not null;

    -- Se calcula el total de las rentas activas
    select sum(trunc(months_between(sysdate, r.fecha_inicio)) * vr.renta_mensual)
    into v_ganancia_total_rentas_activas
    from vivienda v
    join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
    join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
    where v.usuario_duenio_id = p_usuario_duenio_id
    and r.fecha_fin is null;

    -- Se calcula el total de las rentas
    v_ganancia_total_rentas := v_ganancia_total_rentas_anteriores + v_ganancia_total_rentas_activas;
    p_ganancia_total_rentas := v_ganancia_total_rentas;
end;
/
show errors;