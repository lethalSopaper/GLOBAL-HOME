-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Pruebas para procedimiento que resume las ganancias de un usuario dueño de viviendas

set serveroutput on;
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
    -- Caso 1: Resumen de ganancias para un usuario nulo
    begin
        dbms_output.put_line('Caso 1: Resumen de ganancias para un usuario nulo');
        p_resumen_viviendas(null);
        dbms_output.put_line('Se generó resumen de ganancias (ERROR)');
    exception
        when others then
            if sqlcode = -20600 then
                dbms_output.put_line('El usuario dueño no puede ser nulo (OK)');
            elsif sqlcode = -20700 then
                dbms_output.put_line('El usuario dueño no existe (ERROR)');
            else
                dbms_output.put_line('ERROR: al generar resumen de ganancias para un usuario nulo' || sqlerrm);
            end if;
    end;
    -- Caso 2: Resumen de ganancias para un usuario que no existe
    begin
        dbms_output.put_line('Caso 2: Resumen de ganancias para un usuario que no existe');
        p_resumen_viviendas(1000);
        dbms_output.put_line('Se generó resumen de ganancias (ERROR)');
    exception
        when others then
            if sqlcode = -20600 then
                dbms_output.put_line('El usuario dueño no puede ser nulo (ERROR)');
            elsif sqlcode = -20700 then
                dbms_output.put_line('El usuario dueño no existe (OK)');
            else
                dbms_output.put_line('ERROR: al generar resumen de ganancias para un usuario que no existe' || sqlerrm);
            end if;
    end;
    -- Caso 3: Resumen de ganancias para un usuario con viviendas
    begin
        dbms_output.put_line('Caso 3: Resumen de ganancias para el usuario id 40');
        dbms_output.put_line('Inicio de verificaciones');
        dbms_output.put_line('---------------------------------------------------------------------');
        -- Verificaciones
        select usuario_id into v_usuario_duenio_id
        from usuario
        where usuario_id = 40;
        dbms_output.put_line('Verificación dueño: ' || v_usuario_duenio_id);
        select count(*) into v_viviendas_totales
        from vivienda v
        join usuario u on u.usuario_id = v.usuario_duenio_id
        where v.usuario_duenio_id = 40
        group by u.usuario_id;
        dbms_output.put_line('Verificación viviendas totales: ' || v_viviendas_totales);
        select count(*) into v_cantidad_viviendas_vacaciones_renta
        from vivienda v
        where v.usuario_duenio_id = 40
        and es_vacaciones = true
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
        select count(*) into v_cantidad_viviendas_vacaciones
        from vivienda v
        where v.usuario_duenio_id = 40
        and es_vacaciones = true
        and es_renta = false
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones: ' || v_cantidad_viviendas_vacaciones);
        select trunc(avg(e.calificacion),2) into v_calificacion_promedio
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        join encuesta e on a.alquiler_id = e.alquiler_id
        where v.usuario_duenio_id = 40;
        if v_ganancias_alquileres is null then
            v_ganancias_alquileres := 0;
        end if;
        dbms_output.put_line('Verificación calificación promedio: ' || v_calificacion_promedio);
        select count(*) into v_cantidad_viviendas_renta
        from vivienda v
        where v.usuario_duenio_id = 40
        and es_vacaciones = false
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas renta: ' || v_cantidad_viviendas_renta);
        select count(*) into v_cantidad_viviendas_venta
        from vivienda v
        where v.usuario_duenio_id = 40
        and es_vacaciones = false
        and es_renta = false
        and es_venta = true;
        dbms_output.put_line('Verificación viviendas venta: ' || v_cantidad_viviendas_venta);
        select sum(a.costo_total) into v_ganancias_alquileres
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        where v.usuario_duenio_id = 40;
        dbms_output.put_line('Verificación ganancias alquileres: ' || v_ganancias_alquileres);
        p_calcular_ganancia_total_rentas(v_ganancias_rentas, 40);
        dbms_output.put_line('Verificación ganancias rentas: ' || v_ganancias_rentas);
        select sum(p.importe) into v_ganancias_compras
        from vivienda v
        join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
        join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
        where v.usuario_duenio_id = 40;
        dbms_output.put_line('Verificación ganancias compras: ' || v_ganancias_compras);
        v_ganancias_totales := v_ganancias_alquileres + v_ganancias_rentas + v_ganancias_compras;
        dbms_output.put_line('Verificación ganancias totales: ' || v_ganancias_totales);
        dbms_output.put_line('---------------------------------------------------------------------');
        dbms_output.put_line('Fin de verificaciones');
        dbms_output.put_line('Inicio de resumen de ganancias');
        p_resumen_viviendas(40);
        dbms_output.put_line('Fin de resumen de ganancias');
        dbms_output.put_line('Se generó resumen de ganancias (OK)');
    exception
        when no_data_found then
            dbms_output.put_line('Estan mal las consultas');
        when others then
            if sqlcode = -20600 then
                dbms_output.put_line('El usuario dueño no puede ser nulo (ERROR)');
            elsif sqlcode = -20700 then
                dbms_output.put_line('El usuario dueño no existe (ERROR)');
            else
                dbms_output.put_line('ERROR: al generar resumen de ganancias para un usuario con viviendas' || sqlerrm);
            end if;
    end;
    -- Caso 4: Resumen de ganancias para un usuario con vivienda pero sin ganancias
    begin
        dbms_output.put_line('Caso 4: Resumen de ganancias para el usuario id 1');
        dbms_output.put_line('Inicio de verificaciones');
        dbms_output.put_line('---------------------------------------------------------------------');
        -- Verificaciones
        select usuario_id into v_usuario_duenio_id
        from usuario
        where usuario_id = 1;
        dbms_output.put_line('Verificación dueño: ' || 1);
        select count(*) into v_viviendas_totales
        from vivienda v
        join usuario u on u.usuario_id = v.usuario_duenio_id
        where v.usuario_duenio_id = 1
        group by u.usuario_id;
        dbms_output.put_line('Verificación viviendas totales: ' || v_viviendas_totales);
        select count(*) into v_cantidad_viviendas_vacaciones_renta
        from vivienda v
        where v.usuario_duenio_id = 1
        and es_vacaciones = true
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
        select count(*) into v_cantidad_viviendas_vacaciones
        from vivienda v
        where v.usuario_duenio_id = 1
        and es_vacaciones = true
        and es_renta = false
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones: ' || v_cantidad_viviendas_vacaciones);
        select trunc(avg(e.calificacion),2) into v_calificacion_promedio
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        join encuesta e on a.alquiler_id = e.alquiler_id
        where v.usuario_duenio_id = 1;
        if v_ganancias_alquileres is null then
            v_ganancias_alquileres := 0;
        end if;
        dbms_output.put_line('Verificación calificación promedio: ' || v_calificacion_promedio);
        select count(*) into v_cantidad_viviendas_renta
        from vivienda v
        where v.usuario_duenio_id = 1
        and es_vacaciones = false
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas renta: ' || v_cantidad_viviendas_renta);
        select count(*) into v_cantidad_viviendas_venta
        from vivienda v
        where v.usuario_duenio_id = 1
        and es_vacaciones = false
        and es_renta = false
        and es_venta = true;
        dbms_output.put_line('Verificación viviendas venta: ' || v_cantidad_viviendas_venta);
        select sum(a.costo_total) into v_ganancias_alquileres
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        where v.usuario_duenio_id = 1;
        -- Si es nulo se asigna 0
        if v_ganancias_alquileres is null then
            v_ganancias_alquileres := 0;
        end if;
        dbms_output.put_line('Verificación ganancias alquileres: ' || v_ganancias_alquileres);
        p_calcular_ganancia_total_rentas(v_ganancias_rentas, 1);
        dbms_output.put_line('Verificación ganancias rentas: ' || v_ganancias_rentas);
        select sum(p.importe) into v_ganancias_compras
        from vivienda v
        join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
        join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
        where v.usuario_duenio_id = 1;
        -- Si es nulo se asigna 0
        if v_ganancias_compras is null then
            v_ganancias_compras := 0;
        end if;
        dbms_output.put_line('Verificación ganancias compras: ' || v_ganancias_compras);
        v_ganancias_totales := v_ganancias_alquileres + v_ganancias_rentas + v_ganancias_compras;
        dbms_output.put_line('Verificación ganancias totales: ' || v_ganancias_totales);
        dbms_output.put_line('---------------------------------------------------------------------');
        dbms_output.put_line('Fin de verificaciones');
        dbms_output.put_line('Inicio de resumen de ganancias');
        p_resumen_viviendas(1);
        dbms_output.put_line('Fin de resumen de ganancias');
        dbms_output.put_line('Se generó resumen de ganancias (OK)');
    exception
        when no_data_found then
            dbms_output.put_line('Estan mal las consultas');
        when others then
            if sqlcode = -20600 then
                dbms_output.put_line('El usuario dueño no puede ser nulo (ERROR)');
            elsif sqlcode = -20700 then
                dbms_output.put_line('El usuario dueño no existe (ERROR)');
            else
                dbms_output.put_line('ERROR: al generar resumen de ganancias para un usuario con viviendas' || sqlerrm);
            end if;
    end;
    -- Caso 5: Resumen de ganancias para un usuario con únicamente un tipo de vivienda
    begin
        dbms_output.put_line('Caso 5: Resumen de ganancias para el usuario id 4');
        dbms_output.put_line('Inicio de verificaciones');
        dbms_output.put_line('---------------------------------------------------------------------');
        -- Verificaciones
        select usuario_id into v_usuario_duenio_id
        from usuario
        where usuario_id = 4;
        dbms_output.put_line('Verificación dueño: ' || 4);
        select count(*) into v_viviendas_totales
        from vivienda v
        join usuario u on u.usuario_id = v.usuario_duenio_id
        where v.usuario_duenio_id = 4
        group by u.usuario_id;
        dbms_output.put_line('Verificación viviendas totales: ' || v_viviendas_totales);
        select count(*) into v_cantidad_viviendas_vacaciones_renta
        from vivienda v
        where v.usuario_duenio_id = 4
        and es_vacaciones = true
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones y renta: ' || v_cantidad_viviendas_vacaciones_renta);
        select count(*) into v_cantidad_viviendas_vacaciones
        from vivienda v
        where v.usuario_duenio_id = 4
        and es_vacaciones = true
        and es_renta = false
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas vacaciones: ' || v_cantidad_viviendas_vacaciones);
        select trunc(avg(e.calificacion),4) into v_calificacion_promedio
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        join encuesta e on a.alquiler_id = e.alquiler_id
        where v.usuario_duenio_id = 4;
        if v_ganancias_alquileres is null then
            v_ganancias_alquileres := 0;
        end if;
        dbms_output.put_line('Verificación calificación promedio: ' || v_calificacion_promedio);
        select count(*) into v_cantidad_viviendas_renta
        from vivienda v
        where v.usuario_duenio_id = 4
        and es_vacaciones = false
        and es_renta = true
        and es_venta = false;
        dbms_output.put_line('Verificación viviendas renta: ' || v_cantidad_viviendas_renta);
        select count(*) into v_cantidad_viviendas_venta
        from vivienda v
        where v.usuario_duenio_id = 4
        and es_vacaciones = false
        and es_renta = false
        and es_venta = true;
        dbms_output.put_line('Verificación viviendas venta: ' || v_cantidad_viviendas_venta);
        select sum(a.costo_total) into v_ganancias_alquileres
        from vivienda v
        join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
        join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
        where v.usuario_duenio_id = 4;
        -- Si es nulo se asigna 0
        if v_ganancias_alquileres is null then
            v_ganancias_alquileres := 0;
        end if;
        dbms_output.put_line('Verificación ganancias alquileres: ' || v_ganancias_alquileres);
        p_calcular_ganancia_total_rentas(v_ganancias_rentas, 4);
        dbms_output.put_line('Verificación ganancias rentas: ' || v_ganancias_rentas);
        select sum(p.importe) into v_ganancias_compras
        from vivienda v
        join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
        join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
        where v.usuario_duenio_id = 4;
        -- Si es nulo se asigna 0
        if v_ganancias_compras is null then
            v_ganancias_compras := 0;
        end if;
        dbms_output.put_line('Verificación ganancias compras: ' || v_ganancias_compras);
        v_ganancias_totales := v_ganancias_alquileres + v_ganancias_rentas + v_ganancias_compras;
        dbms_output.put_line('Verificación ganancias totales: ' || v_ganancias_totales);
        dbms_output.put_line('---------------------------------------------------------------------');
        dbms_output.put_line('Fin de verificaciones');
        dbms_output.put_line('Inicio de resumen de ganancias');
        p_resumen_viviendas(4);
        dbms_output.put_line('Fin de resumen de ganancias');
        dbms_output.put_line('Se generó resumen de ganancias (OK)');
    exception
        when no_data_found then
            dbms_output.put_line('Estan mal las consultas');
        when others then
            if sqlcode = -20600 then
                dbms_output.put_line('El usuario dueño no puede ser nulo (ERROR)');
            elsif sqlcode = -20700 then
                dbms_output.put_line('El usuario dueño no existe (ERROR)');
            else
                dbms_output.put_line('ERROR: al generar resumen de ganancias para un usuario con viviendas' || sqlerrm);
            end if;
    end;
end;
/