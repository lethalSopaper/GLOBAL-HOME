-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 07/12/2024
-- Descripción: Creacion de casos de prueba para el trigger tr_validacion_alquiler

set serveroutput on;

declare
    v_estatus_vivienda_id_disponible number(10);
    v_estatus_vivienda_id_inactiva number(10);
    v_monto_total_1 number(11, 2);
    v_monto_total_2 number(11, 2);
begin
    -- inicializando variables
    select estatus_vivienda_id into v_estatus_vivienda_id_disponible
    from estatus_vivienda
    where clave = 'DISPONIBLE';
    -- isertar
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
                dbms_output.put_line('ERROR INESPERADO');
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
            102, to_date('2024-11-10', 'yyyy-mm-dd'), to_date('2024-12-07', 'yyyy-mm-dd'), 102, 36
        );
        dbms_output.put_line('Fallido: se inserto un alquiler con fecha de inicio mayor o igual a la fecha de fin');
    exception
        when others then
            if sqlcode = -20001 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con fecha de inicio mayor o igual a la fecha de fin');
            elsif sqlcode = -20008 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con un rango no valido');
            else
                dbms_output.put_line('El error es: ' || sqlerrm);
            end if;
    end;
    begin
        dbms_output.put_line('Caso 4: Insertar un alquiler con costo total insertado manualmente');
        insert into vivienda (
        vivienda_id, es_vacaciones, es_renta,
        es_venta, capacidad_maxima, fecha_estatus,
        latitud, longitud, direccion,
        descripcion, estatus_vivienda_id, usuario_duenio_id)
        values (103, true, false,
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'),
        '24.1477358', '120.6736482',
        '64 Cascade Point',
        'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            103, 10, 1000, 5000
        );
        -- Insertar un alquiler
        insert into alquiler (
            alquiler_id, fecha_inicio, fecha_fin,
            vivienda_vacaciones_id, usuario_id, costo_total
        ) values (
            103, to_date('2024-12-07', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'), 103, 36, 10000
        );
        dbms_output.put_line('Fallido: se inserto un alquiler con costo total insertado manualmente');
    exception
        when others then
            if sqlcode = -20002 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con costo total insertado manualmente');
            else
                dbms_output.put_line('ERROR INESPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 5: Insertar un alquiler con folio insertado manualmente');
        insert into vivienda (
        vivienda_id, es_vacaciones, es_renta,
        es_venta, capacidad_maxima, fecha_estatus,
        latitud, longitud, direccion,
        descripcion, estatus_vivienda_id, usuario_duenio_id)
        values (104, true, false,
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'),
        '24.1477358', '120.6736482',
        '64 Cascade Point',
        'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            104, 10, 1000, 5000
        );
        -- Insertar un alquiler
        insert into alquiler (
            alquiler_id, fecha_inicio, fecha_fin,
            vivienda_vacaciones_id, usuario_id, folio
        ) values (
            104, to_date('2024-12-07', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'), 104, 36, 'FOLIO123'
        );
        dbms_output.put_line('Fallido: se inserto un alquiler con folio insertado manualmente');
    exception
        when others then
            if sqlcode = -20002 then
                dbms_output.put_line('Exitoso: no se pudo insertar un alquiler con folio insertado manualmente');
            else
                dbms_output.put_line('ERROR INESPERADO');
            end if;
    end;
    -- Actualizar
    begin
        dbms_output.put_line('Caso 6: Validando que no se pueda actualizar la vivienda de un alquiler');
        update alquiler set
            vivienda_vacaciones_id = 101
        where alquiler_id = 100;
        dbms_output.put_line('Fallido: se actualizo la vivienda de un alquiler');
    exception
        when others then
            if sqlcode = -20003 then
                dbms_output.put_line('Exitoso: no se pudo actualizar la vivienda de un alquiler');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 7: Validando que no se pueda actualizar el usuario de un alquiler');
        update alquiler set
            usuario_id = 37
        where alquiler_id = 100;
        dbms_output.put_line('Fallido: se actualizo el usuario de un alquiler');
    exception
        when others then
            if sqlcode = -20004 then
                dbms_output.put_line('Exitoso: no se pudo actualizar el usuario de un alquiler');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 8: Validando que no el costo total no se pueda actualizar manualmente');
        update alquiler set
            costo_total = 10000
        where alquiler_id = 100;
        dbms_output.put_line('Fallido: se actualizo el costo total de un alquiler');
    exception
        when others then
            if sqlcode = -20005 then
                dbms_output.put_line('Exitoso: no se pudo actualizar el costo total de un alquiler');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 9: Validando que no el folio no se pueda actualizar manualmente');
        update alquiler set
            folio = 'FOLIO123'
        where alquiler_id = 100;
        dbms_output.put_line('Fallido: se actualizo el folio de un alquiler');
    exception
        when others then
            if sqlcode = -20006 then
                dbms_output.put_line('Exitoso: no se pudo actualizar el folio de un alquiler');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 10: Validando que en caso de que la fecha de inicio o fin cambie, la fecha de inicio sea menor a la fecha de fin');
        update alquiler set
            fecha_inicio = to_date('2024-12-06', 'yyyy-mm-dd')
        where alquiler_id = 100;
        dbms_output.put_line('Exito: la fecha de inicio es una fecha aceptable');
    exception
        when others then
            if sqlcode = -20001 then
                dbms_output.put_line('Fallido: la fecha de inicio no es una fecha aceptable');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if;
    end;

    begin
        dbms_output.put_line('Caso 11: Validando que en caso de que la fecha de inicio o fin cambie, el costo total se actualice');
        select costo_total into v_monto_total_1
        from alquiler
        where alquiler_id = 100;
        update alquiler set
            fecha_fin = to_date('2024-12-11', 'yyyy-mm-dd')
        where alquiler_id = 100;

        select costo_total into v_monto_total_2
        from alquiler
        where alquiler_id = 100;

        if v_monto_total_1 != v_monto_total_2 then
            dbms_output.put_line('Exitoso: el costo total se actualizo');
        else
            dbms_output.put_line('Fallido: el costo total no se actualizo');
        end if;
    exception
        when others then
            dbms_output.put_line('ERROR INESEPERADO');
    end;
    -- Eliminar
    begin
        dbms_output.put_line('Caso 12: Validando que no se pueda eliminar un alquiler');
        delete from alquiler
        where alquiler_id = 100;
        dbms_output.put_line('Fallido: se elimino un alquiler');
    exception
        when others then
            if sqlcode = -20007 then
                dbms_output.put_line('Exitoso: no se pudo eliminar un alquiler');
            else
                dbms_output.put_line('ERROR INESEPERADO');
            end if; 
    end;
end;
/
rollback;