-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Este procedimiento busca imprimir un resumen de calificaciones y ganancias para un dueño dueño de viviendas.

create or replace procedure p_resumen_viviendas(
    p_usuario_duenio_id in number
)
as
    -- variable para almacenar el usuario dueño
    v_usuario_duenio_id number;
    -- variable para saber la cantidad de viviendas totales
    v_viviendas_totales number;
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
    -- variable para almacenar las ganancias de alquileres
    v_ganancias_alquileres number := 0;
    -- Variables para almacenar las ganancias de rentas
    v_ganancias_rentas number := 0;
    -- variable para almacenar las ganancias de compras
    v_ganancias_compras number := 0;
    -- variable para almacenar las ganancias totales
    v_ganancias_totales number := 0;
    -- cursor para seleccionar todas las viviendas renta de un dueño
begin
    -- Verificar que el usuario dueño no sea nulo
    if p_usuario_duenio_id is null then
        raise_application_error(-20600, 'El usuario dueño no puede ser nulo');
    end if;
    -- Verificar que el usuario dueño exista
    select u.usuario_id, count(*) into v_usuario_duenio_id, v_viviendas_totales
    from vivienda v
    join usuario u on u.usuario_id = v.usuario_duenio_id
    where v.usuario_duenio_id = p_usuario_duenio_id
    group by u.usuario_id;
    dbms_output.put_line('---------------------------------------------------------------------');
    dbms_output.put_line('Dueño: ' || v_usuario_duenio_id);
    dbms_output.put_line('Cantidad de viviendas totales: ' || v_viviendas_totales);
    -- Cantidad de viviendas de vacaciones y renta
    select count(*) into v_cantidad_viviendas_vacaciones_renta
    from vivienda v
    where v.usuario_duenio_id = v_usuario_duenio_id
    and es_vacaciones = true
    and es_renta = true
    and es_venta = false;
    dbms_output.put_line('Cantidad de viviendas de vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
    -- Cantidad de viviendas de vacaciones
    select count(*) into v_cantidad_viviendas_vacaciones
    from vivienda v
    where v.usuario_duenio_id = v_usuario_duenio_id
    and es_vacaciones = true
    and es_renta = false
    and es_venta = false;
    dbms_output.put_line('Cantidad de viviendas de vacaciones: ' || v_cantidad_viviendas_vacaciones);
    -- Calificación promedio de las viviendas de vacaciones
    select trunc(avg(e.calificacion),2) into v_calificacion_promedio
    from vivienda v
    join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
    join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
    join encuesta e on a.alquiler_id = e.alquiler_id
    where v.usuario_duenio_id = v_usuario_duenio_id;
    dbms_output.put_line('Calificación promedio de los alquileres: ' || v_calificacion_promedio);
    -- Cantidad de viviendas de renta
    select count(*) into v_cantidad_viviendas_renta
    from vivienda v
    where v.usuario_duenio_id = v_usuario_duenio_id   
    and es_vacaciones = false
    and es_renta = true
    and es_venta = false;
    dbms_output.put_line('Cantidad de viviendas de renta: ' || v_cantidad_viviendas_renta);
    -- Cantidad de viviendas de venta
    select count(*) into v_cantidad_viviendas_venta
    from vivienda v
    where v.usuario_duenio_id = v_usuario_duenio_id
    and es_vacaciones = false
    and es_renta = false
    and es_venta = true;
    dbms_output.put_line('Cantidad de viviendas de venta: ' || v_cantidad_viviendas_venta);
    -- Ganancias de alquiler
    select sum(a.costo_total) into v_ganancias_alquileres
    from vivienda v
    join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
    join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
    where v.usuario_duenio_id = v_usuario_duenio_id;
    -- Si es nulo se asigna 0
    if v_ganancias_alquileres is null then
        v_ganancias_alquileres := 0;
    end if;
    dbms_output.put_line('Ganancias de alquileres: ' || v_ganancias_alquileres);
    -- Ganancias de renta
    p_calcular_ganancia_total_rentas(v_ganancias_rentas, v_usuario_duenio_id);
    dbms_output.put_line('Ganancias de rentas: ' || v_ganancias_rentas);
    -- Ganancias de compra
    select sum(p.importe) into v_ganancias_compras
    from vivienda v
    join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
    join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
    where v.usuario_duenio_id = v_usuario_duenio_id;
    -- Si es nulo se asigna 0
    if v_ganancias_compras is null then
        v_ganancias_compras := 0;
    end if;
    dbms_output.put_line('Ganancias de compras: ' || v_ganancias_compras);
    -- Ganancias totales
    v_ganancias_totales := v_ganancias_alquileres + v_ganancias_rentas + v_ganancias_compras;
    -- Se imprime el resumen
    dbms_output.put_line('Ganancias totales: ' || v_ganancias_totales);
    dbms_output.put_line('---------------------------------------------------------------------');
exception
    when no_data_found then
        raise_application_error(-20700, 'El usuario dueño no existe: ' || p_usuario_duenio_id);
    when others then
        if sqlcode = -20600 then
            raise_application_error(-20600, 'El usuario dueño no existe');
        else
            raise_application_error(-20999, 'Error: ' || sqlerrm);
        end if;
end;
/
show errors;