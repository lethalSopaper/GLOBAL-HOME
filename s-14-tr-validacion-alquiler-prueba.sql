-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 07/12/2024
-- Descripción: Creacion de casos de prueba para el trigger tr_validacion_alquiler

set serveroutput on;

declare
    v_estatus_vivienda_id_disponible number(10);
    v_estatus_vivienda_id_inactiva number(10);
begin
    -- inicializando variables
    select estatus_vivienda_id into v_estatus_vivienda_id_disponible
    from estatus_vivienda
    where clave = 'DISPONIBLE';

    begin
        dbms_output.put_line('Caso 1: Insertar un alquiler con una vivienda disponible');
        -- Insertar una vivienda
        insert into vivienda (
        vivienda_id, es_vacaciones, es_renta, 
        es_venta, capacidad_maxima, fecha_estatus, 
        latitud, longitud, direccion, 
        descripcion, estatus_vivienda_id, usuario_duenio_id) 
        values (100, true, false, 
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'), 
        '24.1477358', '120.6736482', 
        '64 Cascade Point', 
        'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            100, 10, 1000, 5000
        );
        -- Insertar un alquiler
        insert into alquiler (
            alquiler_id, fecha_inicio, fecha_fin, 
            vivienda_vacaciones_id, usuario_id
        ) values (
            100, to_date('2024-12-07', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'), 100, 36
        );
        dbms_output.put_line('Exitoso: se inserto un alquiler con una vivienda disponible');
    exception
        when others then
            dbms_output.put_line('Fallido: no se pudo insertar un alquiler con una vivienda disponible');
    end;

    begin
        dbms_output.put_line('Caso 2: Insertar un alquiler con una vivienda no disponible');
        insert into vivienda (
        vivienda_id, es_vacaciones, es_renta,
        es_venta, capacidad_maxima, fecha_estatus,
        latitud, longitud, direccion,
        descripcion, estatus_vivienda_id, usuario_duenio_id)
        values (101, true, false,
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'),
        '24.1477358', '120.6736482',
        '64 Cascade Point',
        'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            101, 10, 1000, 5000
        );
        -- Actualizar estatus de la vivienda
        update vivienda set
            estatus_vivienda_id = 3,
            fecha_estatus = to_date('2024-12-06', 'yyyy-mm-dd')
        where vivienda_id = 101;
        -- Insertar un alquiler
        insert into alquiler (
            alquiler_id, fecha_inicio, fecha_fin,
            vivienda_vacaciones_id, usuario_id
        ) values (
            101, to_date('2024-12-07', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'), 101, 36
        );
        dbms_output.put_line('Fallido: se inserto un alquiler con una vivienda no disponible');
    exception
        when others then
            if sqlcode = -20000 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con una vivienda no disponible');
            else
                dbms_output.put_line('Fallido: no se pudo insertar un alquiler con una vivienda no disponible');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 3: Insertar un alquiler con fecha de inicio mayor o igual a la fecha de fin');
        insert into vivienda (
        vivienda_id, es_vacaciones, es_renta,
        es_venta, capacidad_maxima, fecha_estatus,
        latitud, longitud, direccion,
        descripcion, estatus_vivienda_id, usuario_duenio_id)
        values (102, true, false,
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'),
        '24.1477358', '120.6736482',
        '64 Cascade Point',
        'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            102, 10, 1000, 5000
        );
        -- Insertar un alquiler
        insert into alquiler (
            alquiler_id, fecha_inicio, fecha_fin,
            vivienda_vacaciones_id, usuario_id
        ) values (
            102, to_date('2024-12-10', 'yyyy-mm-dd'), to_date('2024-12-07', 'yyyy-mm-dd'), 102, 36
        );
        dbms_output.put_line('Fallido: se inserto un alquiler con fecha de inicio mayor o igual a la fecha de fin');
    exception
        when others then
            if sqlcode = -20001 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con fecha de inicio mayor o igual a la fecha de fin');
            else
                dbms_output.put_line('Fallido: no se pudo insertar un alquiler con fecha de inicio mayor o igual a la fecha de fin');
            end if;
    end;

end;
/
rollback;