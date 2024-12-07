-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 06/12/2024
-- Dscripcion: Este archivo contine las prubeas para el trigger de validacion de vivienda


set serveroutput on
declare
    v_estatus_vivienda_id_disponible number;
    v_estatus_vivienda_id_vendida number;
    v_estatus_vivienda_id_alquilada number;
    v_estatus_vivienda_id_inactiva number;
    v_estatus_vivienda_id_en_venta number;
    v_fecha_status date;
    v_vivienda_id number;
    v_costo_total number := 0;
begin
    -- Inicializando variables
    select estatus_vivienda_id into v_estatus_vivienda_id_disponible
    from estatus_vivienda
    where clave = 'DISPONIBLE';

    select estatus_vivienda_id into v_estatus_vivienda_id_vendida
    from estatus_vivienda
    where clave = 'VENDIDA';

    select estatus_vivienda_id into v_estatus_vivienda_id_inactiva
    from estatus_vivienda
    where clave = 'INACTIVA';

    select estatus_vivienda_id into v_estatus_vivienda_id_en_venta
    from estatus_vivienda
    where clave = 'EN VENTA';

    select estatus_vivienda_id into v_estatus_vivienda_id_alquilada
    from estatus_vivienda
    where clave = 'ALQUILADA';

    select sysdate into v_fecha_status from dual;

    --insertar
    begin
        dbms_output.put_line('Caso 1: Insertando una vivienda con estado disponible');
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
        dbms_output.put_line('Se inserto correctamente la vivienda');
    exception
        when others then
            dbms_output.put_line('Error al insertar la vivienda');
            raise;
    end;
    
    begin
        dbms_output.put_line('Caso 2: Insertando una vivienda con estado inactiva');
        insert into VIVIENDA (
            vivienda_id, es_vacaciones, es_renta, 
            es_venta, capacidad_maxima, fecha_estatus, 
            latitud, longitud, direccion, 
            descripcion, estatus_vivienda_id, usuario_duenio_id) 
            values (101, true, false, 
            false, 5, sysdate, 
            '24.1477358', '120.6736482', 
            '64 Cascade Point', 
            'Casa con vista al mar', v_estatus_vivienda_id_inactiva, 36);
        dbms_output.put_line('La viviedna se inserto correctamente cuando no deberia');
    exception
        when others then
            if sqlcode = -20001 then
                dbms_output.put_line('Error esperdado al insertar la vivienda');
            else
                dbms_output.put_line('Error inesperado al insertar la vivienda');
                raise;
            end if;
    end;

    --Actualizar
    begin
        dbms_output.put_line('Caso 3: Actualizando una vivienda Disponible a Inactiva');
        v_vivienda_id := 100;

        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_inactiva
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito');

    exception
        when others then
            dbms_output.put_line('Error inesperado al actualizar');
            raise;
    end;

    begin
        dbms_output.put_line('Caso 4: Actualizando una vivienda con cualquier estado a Inactiva');
        --Insertando una nueva vivienda
        insert into vivienda (
            vivienda_id, es_vacaciones, es_renta, 
            es_venta, capacidad_maxima, fecha_estatus, 
            latitud, longitud, direccion, 
            descripcion, estatus_vivienda_id, usuario_duenio_id) 
            values (102, true, false, 
            false, 5, sysdate, 
            '24.1477358', '120.6736482', 
            '64 Cascade Point', 
            'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);

        v_vivienda_id := 102;
        -- Actualizando la vivienda a alquilada
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_alquilada
        where vivienda_id = v_vivienda_id;

        --Actualizando la vivienda a inactiva
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_inactiva
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito cuando no deberia');
    exception
        when others then
            if sqlcode = -20002 then
                dbms_output.put_line('Error esperado al actualizar');
            else
                dbms_output.put_line('Error inesperado al actualizar');
                raise;
            end if;
    end;

    begin
        dbms_output.put_line('Caso 5: Actualizando una vivienda con estado disponible a vendida');
        --Insertando una nueva vivienda
        insert into vivienda (
            vivienda_id, es_vacaciones, es_renta, 
            es_venta, capacidad_maxima, fecha_estatus, 
            latitud, longitud, direccion, 
            descripcion, estatus_vivienda_id, usuario_duenio_id) 
            values (103, false, false, 
            true, 5, sysdate, 
            '24.1477358', '120.6736482', 
            '64 Cascade Point', 
            'Casa con vista al mar', v_estatus_vivienda_id_disponible, 36);
        insert into vivienda_venta(
            vivienda_venta_id, num_catastral,folio_escritura,
            avaluo_propiedad, precio_inicial
        ) values (
            103, '1234567890', '1234567890', 
            empty_blob(), 1000000.00
        );
        v_vivienda_id := 103;
        -- Actualizando la vivienda a inactiva
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_vendida
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito cuando no deberia');

    exception
        when others then
            if sqlcode = -20005 then
                dbms_output.put_line('Error esperado al actualizar');
            else
                dbms_output.put_line('Error inesperado al actualizar');
                raise;
            end if;
    end;

    begin
        dbms_output.put_line('Caso 6: Actualizando una vivienda con estado disponible a en venta, sin que este en compra');
        --Actualizando la vivienda 103 
        v_vivienda_id := 103;
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_en_venta
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito cuando no deberia');
    exception
        when others then
            if sqlcode = -20003 then
                dbms_output.put_line('Error esperado al actualizar');
            else
                dbms_output.put_line('Error inesperado al actualizar');
                raise;
            end if;
    end;

    begin
        dbms_output.put_line('Caso 7: Actualizando una vivienda con estado disponible a en venta, que este en compra');
        -- Insertando en compra
        insert into compra(
            vivienda_venta_id, clabe_interbancaria,
            precio_final, comision, usuario_id
        ) values (
            103, '1234567890', 1000000.00, 10000.00, 36
        );

        --Actualizando la vivienda 103
        v_vivienda_id := 103;
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_en_venta
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito');
    exception
        when others then
            dbms_output.put_line('Error inesperado al actualizar');
            raise;
    end;

    begin
        dbms_output.put_line('Caso 8: Actualizando una vivienda con pagos insuficientes a vendida');
        -- insertando un nuevo pago de la vivienda 103
        insert into pago(
            num_pago, vivienda_venta_id, fecha_pago,
            importe, recibo
        ) values (
            1, 103, sysdate, 500000.00, empty_blob()
        );
        --Actualizando la vivienda 103
        v_vivienda_id := 103;
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_vendida
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito cuando no deberia');
    exception
        when others then
            if sqlcode = -20004 then
                dbms_output.put_line('Error esperado al actualizar');
            else
                dbms_output.put_line('Error inesperado al actualizar');
                raise;
            end if;
    end;

    begin
        dbms_output.put_line('Caso 9: Actualizando una vivienda con pagos suficientes a vendida');
        -- insertando un nuevo pago de la vivienda 103
        insert into pago(
            num_pago, vivienda_venta_id, fecha_pago,
            importe, recibo
        ) values (
            2, 103, sysdate, 500000.00, empty_blob()
        );
        --Actualizando la vivienda 103
        v_vivienda_id := 103;
        update vivienda set 
            estatus_vivienda_id = v_estatus_vivienda_id_vendida
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda actualizada con exito');
    exception
        when others then
            dbms_output.put_line('Error inesperado al actualizar');
            raise;
    end;

    -- Eliminar
    begin
        dbms_output.put_line('Caso 10: Eliminando una vivienda');
        -- eliminando la vivienda 102
        v_vivienda_id := 102;
        delete from vivienda
        where vivienda_id = v_vivienda_id;

        dbms_output.put_line('Vivienda eliminada con exito cuando no deberia');
    exception
        when others then
            if sqlcode = -20006 then
                dbms_output.put_line('Error esperado al eliminar');
            else
                dbms_output.put_line('Error inesperado al eliminar');
                raise;
            end if;
    end;
end;
/
rollback;