-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Este procedimiento busca imprimir un resumen de calificaciones y ganancias para los dueños de viviendas teniendo en cuenta todos lo tipos de viviendas que poseen.

create or replace procedure p_resumen_viviendas
as
    -- cursor para seleccionar todas las viviendas y dueños
    cursor cur_duenios is
        select v.usuario_duenio_id
        from vivienda v;
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
    -- variabele para almacenar la calificacón promedio de las viviendas de vacaciones
    v_calificacion_promedio number := 0;
    -- variable para almacenar las ganancias de alquileres
    v_gananacias_alquileres number := 0;
    -- Variables para almacenar las ganancias de rentas
    v_gananacias_rentas number := 0;
    -- variable para almacenar las ganancias de compras
    v_gananacias_compras number := 0;
    -- variable para almacenar las ganancias totales
    v_gananacias_totales number := 0;
    -- cursor para seleccionar todas las viviendas renta de un dueño
begin
    -- Para cada dueño de vivienda
    for duenio in cur_duenios loop
        v_gananancias_alquileres := 0;
        v_gananancias_rentas := 0;
        v_gananancias_compras := 0;
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
        -- Calificación promedio de las viviendas de vacaciones
        select avg(e.calificacion) into v_calificacion_promedio
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        join encuesta e on a.alquiler_id = e.alquiler_id
        where v.usuario_duenio_id = duenio.usuario_duenio_id;
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
        and es_venta = true
        where v.usuario_duenio_id = duenio.usuario_duenio_id;
        -- Ganancias de alquiler
        select sum(a.costo_total) into v_gananacias_alquileres
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        where v.usuario_duenio_id = duenio.usuario_duenio_id;
        -- Ganancias de renta
        p_calcular_ganancia_total_rentas(v_gananacias_rentas, duenio.usuario_duenio_id);
        -- Ganancias de compra
        select sum(p.importe) into v_gananacias_compras
        from vivienda v
        join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
        join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
        where v.usuario_duenio_id = duenio.usuario_duenio_id;
        -- Ganancias totales
        v_gananacias_totales := v_gananacias_alquileres + v_gananacias_rentas + v_gananacias_compras;
        -- Se imprime el resumen
        dbms_output.put_line('Dueño: ' || duenio.usuario_duenio_id);
        dbms_output.put_line('Cantidad de viviendas de vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
        dbms_output.put_line('Cantidad de viviendas de vacaciones: ' || v_cantidad_viviendas_vacaciones);
        dbms_output.put_line('Calificación promedio de los alquileres: ' || v_calificacion_promedio);
        dbms_output.put_line('Cantidad de viviendas de renta: ' || v_cantidad_viviendas_renta);
        dbms_output.put_line('Cantidad de viviendas de venta: ' || v_cantidad_viviendas_venta);
        -- Imprimir ganancias totales
        dbms_output.put_line('Ganancias totales: ' || v_gananacias_totales);
        dbms_output.put_line('---------------------------------------------------------------------');
    end loop;
exception
    when no_data_found then
        dbms_output.put_line('No se encontraron datos');
    when others then
        dbms_output.put_line('Error: ' || sqlerrm);
end;
/
show errors;