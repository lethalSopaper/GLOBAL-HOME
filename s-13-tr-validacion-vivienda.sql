-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- fecha: 06/12/2024
-- Descripción: Validación de vivienda
/* trigger vivienda

para vivienda solo se pueden insertar viviendas disponibles.

cuando se actualiza el estauts a vendida validar que el pago se completo
y cambiar la fecha.
para actualizar a inactiva el estatus anterior deberia de ser disponible.
no se pueden eliminar viviendas */

create or replace trigger tr_validacion_vivienda
before insert or update or delete on vivienda
for each row
declare
    v_estatus_vivienda_disponible number(10);
    v_estatus_vivienda_inactiva number(10);
    v_estatus_vivienda_vendida number(10);
    v_estatus_vivienda_en_venta number(10);
    v_sum_pagos number(11,2);
    v_total_pagos compra.precio_final%type;
begin

    if inserting then
        select e.estatus_vivienda_id into v_estatus_vivienda_disponible
        from estatus_vivienda e
        where e.clave = 'DISPONIBLE';

        if :new.estatus_vivienda_id != v_estatus_vivienda_disponible then
            raise_application_error(-20001, 'La vivienda no esta disponible');
        end if;

        --insertando en historico_estatus_vivienda
        insert into historico_estatus_vivienda(
            historico_estatus_vivienda_id,
            fecha_estatus,
            estatus_vivienda_id,
            vivienda_id
        ) values(
            historico_estatus_vivienda_seq.nextval,
            sysdate,
            :new.estatus_vivienda_id, -- disponible
            :new.vivienda_id
        );

        -- insertando en tabla temporal
        insert into operaciones_temp(
            operaciones_temp_id,
            usuario,
            accion,
            tabla_afectada,
            detalle_accion,
            valor_anterior,
            valor_nuevo
        ) values(
            operaciones_temp_seq.nextval,
            SYS_CONTEXT('USERENV', 'SESSION_USER'),
            'INSERT',
            'VIVIENDA',
            'Se inserto una vivienda',
            null,
            :new.vivienda_id
        );
    elsif updating then
        select e.estatus_vivienda_id into v_estatus_vivienda_inactiva
        from estatus_vivienda e
        where e.clave = 'INACTIVA';

        select e.estatus_vivienda_id into v_estatus_vivienda_vendida
        from estatus_vivienda e
        where e.clave = 'VENDIDA';

        select e.estatus_vivienda_id into v_estatus_vivienda_en_venta
        from estatus_vivienda e
        where e.clave = 'EN VENTA';
        -- validadno que se intente cambiar a inactiva
        if :new.estatus_vivienda_id = v_estatus_vivienda_inactiva then
            --validando que el estatus anterior sea disponible
            if :old.estatus_vivienda_id != v_estatus_vivienda_disponible then
                raise_application_error(-20002, 'El estatus anterior debe ser disponible');
            end if;
            --actualizando la fecha_estatus
            :new.fecha_estatus := sysdate;
            --insertando en historico_estatus_vivienda
            insert into historico_estatus_vivienda(
                historico_estatus_vivienda_id,
                fecha_estatus,
                estatus_vivienda_id,
                vivienda_id
            ) values(
                historico_estatus_vivienda_seq.nextval,
                sysdate,
                :new.estatus_vivienda_id, -- inactiva
                :new.vivienda_id
            );
        end if;
        -- validadndo que se intente cambiar a vendida
        if :new.estatus_vivienda_id = v_estatus_vivienda_vendida THEN
            --validando que el estatus anterior sea en venta
            if :old.estatus_vivienda_id = v_estatus_vivienda_en_venta then
                select sum(p.importe) into v_sum_pagos
                from vivienda v
                join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
                join compra c on vv.vivienda_venta_id = c.vivienda_venta_id
                join pago p on c.vivienda_venta_id = p.vivienda_venta_id
                where v.vivienda_id = :new.vivienda_id;

                select c.precio_final into v_total_pagos
                from vivienda v
                join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
                join compra c on vv.vivienda_venta_id = c.vivienda_venta_id
                where v.vivienda_id = :new.vivienda_id;

                if v_sum_pagos < v_total_pagos then
                    raise_application_error(-20003, 'El pago no se ha completado');
                end if;
                --actualizando la fecha_estatus
                :new.fecha_estatus := sysdate;
                --insertando en historico_estatus_vivienda
                insert into historico_estatus_vivienda(
                    historico_estatus_vivienda_id,
                    fecha_estatus,
                    estatus_vivienda_id,
                    vivienda_id
                ) values(
                    historico_estatus_vivienda_seq.nextval,
                    sysdate,
                    :new.estatus_vivienda_id, -- vendida
                    :new.vivienda_id
                );
            else
                raise_application_error(-20004, 'El estatus anterior debe ser en venta');
            end if;
        end if;
        -- insertando en la tabla temporal en cada caso de que se actualice un valor
        if :old.estatus_vivienda_id != :new.estatus_vivienda_id then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo el estatus de la vivienda',
                :old.estatus_vivienda_id,
                :new.estatus_vivienda_id
            );
        end if;
        -- insertando en la tabla temporal si se actualiza el tipo de vivienda
        if (:old.es_vacaciones != :new.es_vacaciones) or 
            (:old.es_renta != :new.es_renta) or (:new.es_venta != :old.es_venta) then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo el tipo de vivienda',
                :old.es_vacaciones || ' ' || :old.es_renta || ' ' || :old.es_venta,
                :new.es_vacaciones || ' ' || :new.es_renta || ' ' || :new.es_venta
            );
        end if;
        -- insertando en la tabla temporal si se actualiza la latitud, longitud o direccion
        if (:old.latitud != :new.latitud) or (:old.longitud != :new.longitud) or (:old.direccion != :new.direccion) then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo la ubicacion de la vivienda',
                :old.latitud || ' ' || :old.longitud || ' ' || :old.direccion,
                :new.latitud || ' ' || :new.longitud || ' ' || :new.direccion
            );
        end if;
        -- insertando en la tabla temporal si se actualiza la descripcion de la vivienda
        if :old.descripcion != :new.descripcion then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo la descripcion de la vivienda',
                :old.descripcion,
                :new.descripcion
            );
        end if;
        -- insertando en la tabla temporal si se actualiza el usuario duenio de la vivienda
        if :old.usuario_duenio_id != :new.usuario_duenio_id then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo el duenio de la vivienda',
                :old.usuario_duenio_id,
                :new.usuario_duenio_id
            );
        end if;
        -- insertando en la tabla temporal si se cambio la capacidad maxima de la vivienda
        if :old.capacidad_maxima != :new.capacidad_maxima then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo la capacidad maxima de la vivienda',
                :old.capacidad_maxima,
                :new.capacidad_maxima
            );
        end if;
        -- insertando en la tabla temporal si se cambio la fecha_estatus de la vivienda
        if :old.fecha_estatus != :new.fecha_estatus then
            insert into operaciones_temp(
                operaciones_temp_id,
                usuario,
                accion,
                tabla_afectada,
                detalle_accion,
                valor_anterior,
                valor_nuevo
            ) values(
                operaciones_temp_seq.nextval,
                SYS_CONTEXT('USERENV', 'SESSION_USER'),
                'UPDATE',
                'VIVIENDA',
                'Se actualizo la fecha de estatus de la vivienda',
                :old.fecha_estatus,
                :new.fecha_estatus
            );
        end if;
    elsif deleting then
        raise_application_error(-20005, 'No se pueden eliminar viviendas, en dado caso se puede cambiar el estatus a inactiva');
    end if;
end;
/
show errors;