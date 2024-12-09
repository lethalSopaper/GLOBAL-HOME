set serveroutput on
declare
    v_usuario_duenio_id number;
    v_viviendas_totales number;
    v_cantidad_viviendas_vacaciones_renta number;
    v_cantidad_viviendas_vacaciones number;
    v_calificacion_promedio number;
    v_cantidad_viviendas_renta number;
    v_cantidad_viviendas_venta number;
    v_ganancias_alquileres number;
    v_ganancias_rentas number;
    v_ganancias_compras number;
    v_ganancias_totales number;
begin
    dbms_output.put_line('Inicio de verificaciones');
    dbms_output.put_line('---------------------------------------------------------------------');
    -- Verificaciones
    select usuario_id into v_usuario_duenio_id
    from usuario
    where usuario_id = 7;
    dbms_output.put_line('Verificación dueño: ' || 7);
    select count(*) into v_viviendas_totales
    from vivienda v
    join usuario u on u.usuario_id = v.usuario_duenio_id
    where v.usuario_duenio_id = 7
    group by u.usuario_id;
    dbms_output.put_line('Verificación viviendas totales: ' || v_viviendas_totales);
    select count(*) into v_cantidad_viviendas_vacaciones_renta
    from vivienda v
    where v.usuario_duenio_id = 7
    and es_vacaciones = true
    and es_renta = true
    and es_venta = false;
    dbms_output.put_line('Verificación viviendas vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
    select count(*) into v_cantidad_viviendas_vacaciones
    from vivienda v
    where v.usuario_duenio_id = 7
    and es_vacaciones = true
    and es_renta = false
    and es_venta = false;
    dbms_output.put_line('Verificación viviendas vacaciones: ' || v_cantidad_viviendas_vacaciones);
    select trunc(avg(e.calificacion),7) into v_calificacion_promedio
    from vivienda v
    join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
    join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
    join encuesta e on a.alquiler_id = e.alquiler_id
    where v.usuario_duenio_id = 7;
    dbms_output.put_line('Verificación calificación promedio: ' || v_calificacion_promedio);
    select count(*) into v_cantidad_viviendas_renta
    from vivienda v
    where v.usuario_duenio_id = 7
    and es_vacaciones = false
    and es_renta = true
    and es_venta = false;
    dbms_output.put_line('Verificación viviendas renta: ' || v_cantidad_viviendas_renta);
    select count(*) into v_cantidad_viviendas_venta
    from vivienda v
    where v.usuario_duenio_id = 7
    and es_vacaciones = false
    and es_renta = false
    and es_venta = true;
    dbms_output.put_line('Verificación viviendas venta: ' || v_cantidad_viviendas_venta);
    select sum(a.costo_total) into v_ganancias_alquileres
    from vivienda v
    join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
    join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
    where v.usuario_duenio_id = 7;
    -- Si es nulo se asigna 0
    if v_ganancias_alquileres is null then
        v_ganancias_alquileres := 0;
    end if;
    dbms_output.put_line('Verificación ganancias alquileres: ' || v_ganancias_alquileres);
    p_calcular_ganancia_total_rentas(v_ganancias_rentas, 7);
    dbms_output.put_line('Verificación ganancias rentas: ' || v_ganancias_rentas);
    select sum(p.importe) into v_ganancias_compras
    from vivienda v
    join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
    join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
    where v.usuario_duenio_id = 7;
    -- Si es nulo se asigna 0
    if v_ganancias_compras is null then
        v_ganancias_compras := 0;
    end if;
    dbms_output.put_line('Verificación ganancias compras: ' || v_ganancias_compras);
    v_ganancias_totales := v_ganancias_alquileres + v_ganancias_rentas + v_ganancias_compras;
    dbms_output.put_line('Verificación ganancias totales: ' || v_ganancias_totales);
    dbms_output.put_line('---------------------------------------------------------------------');
    dbms_output.put_line('Fin de verificaciones');
end;
/