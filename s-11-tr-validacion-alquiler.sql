-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 05/12/2024
-- Descripción: Creación de triggers para la tabla alquiler
/*
3
trigger alquiler

para insertar  el estatus de una vivienda tiene que estar en disponible, una vez validada, despues de hacer el insert
se tendra que cambiar el estauds de la vivienda a aluilada (es el id 3) y la fecha de estatus debe de ser la actual
de igual forma se tendra que insertar un nuevo registor en el historico del estatus de la vivienda con el estatus de alquilada
y la fecha de estatus debe de ser la actual, el id de la vivienda debe de ser el mismo que el de la vivienda que se esta alquilando. De igual forma se requiere calcular el costo_total del alquiler, el cual se calcula multiplicando el costo de la vivienda por el numero de dias que se va a alquilar más el costo de apartado, el numero de dias se calcula restando la fecha de fin de alquiler con la fecha de inicio de alquiler.

cuando se actualiza un alquiler se añade al csv log.

no se pueden eliminar alquileres
*/

create or replace trigger tr_validacion_alquiler
before insert or update or delete on alquiler
for each row
declare
    v_estatus_vivienda_id number(10);
    v_fecha_actual date := sysdate;
    v_fecha_evento timestamp;
    v_fecha_inicio_alquiler date;
    v_fecha_fin_alquiler date;
    --v_costo_total number(10,2);
    --v_dias_alquiler number(10);
    v_vivienda_alquilada_id number(10);
    --v_costo_dia vivienda_vacaciones.costo_dia%type;
    --v_costo_apartado vivienda_vacaciones.costo_apartado%type;
    --v_max_dias vivienda_vacaciones.max_dias%type;
begin
    case
        when inserting then
            -- Validar que la vivienda este disponible
            v_vivienda_alquilada_id := :new.vivienda_vacaciones_id;
            select v.estatus_vivienda_id into v_estatus_vivienda_id
            from vivienda v
            where v.vivienda_id = v_vivienda_alquilada_id;

            if v_estatus_vivienda_id != 1 then
                raise_application_error(-20000, 'La vivienda no esta disponible');
            end if;

            -- Actualizar estatus de la vivienda
            update vivienda set
                estatus_vivienda_id = 3,
                fecha_estatus = v_fecha_actual
            where vivienda_id = v_vivienda_alquilada_id;

            -- Insertar en historico_estatus_vivienda
            insert into historico_estatus_vivienda(
                historico_estatus_vivienda_id,
                fecha_estatus,
                estatus_vivienda_id,
                vivienda_id
            ) values(
                historico_estatus_vivienda_seq.nextval,
                v_fecha_actual,
                3,
                v_vivienda_alquilada_id
            );
            --Validar que el costo_total no sea insertado manualmente
            if :new.costo_total is not null then
                raise_application_error(-20001, 'No se puede insertar el costo total manualmente');
            end if;
            -- Calcular costo total
            v_fecha_inicio_alquiler := :new.fecha_inicio;
            v_fecha_fin_alquiler := :new.fecha_fin;

            :new.costo_total := calcular_total_alquiler(v_vivienda_alquilada_id, v_fecha_inicio_alquiler, v_fecha_fin_alquiler);
            -- Validar que el folio no sea insertado manualmente
            if :new.folio is not null then
                raise_application_error(-20001, 'No se puede insertar el folio manualmente');
            end if;
            -- Calcular folio
            :new.folio := calcular_folio_alquiler(v_fecha_inicio_alquiler);
            -- Insertar en operaciones_temp
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
                'ALQUILER',
                'Se inserto un alquiler',
                null,
                :new.alquiler_id
            );
        when updating then
            -- Validar que no se pueda cambiar la vivienda
            if :old.vivienda_vacaciones_id != :new.vivienda_vacaciones_id then
                raise_application_error(-20002, 'No se puede cambiar la vivienda');
            end if;
            -- Validar que no se pueda cambiar el cliente que alquila
            if :old.usuario_id != :new.usuario_id then
                raise_application_error(-20003, 'No se puede cambiar el cliente que alquila');
            end if;
            -- Validar si se modifica el costo_total
            if :old.costo_total != :new.costo_total then
                raise_application_error(-20004, 'No se puede modificar el costo total directamente');
            end if;
            -- Validar si se modifica el folio
            if :old.folio != :new.folio then
                raise_application_error(-20005, 'No se puede modificar el folio');
            end if;
            -- Obtener id de la vivienda alquilada
            v_vivienda_alquilada_id := :new.vivienda_vacaciones_id;
            -- Validar si se cambiaron las fechas de inicio o fin
            if :old.fecha_inicio != :new.fecha_inicio or :old.fecha_fin != :new.fecha_fin then
                -- Calcular nuevo costo total
                v_fecha_inicio_alquiler := :new.fecha_inicio;
                v_fecha_fin_alquiler := :new.fecha_fin;

                :new.costo_total := calcular_total_alquiler(v_vivienda_alquilada_id, v_fecha_inicio_alquiler, 
                    v_fecha_fin_alquiler);

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
                    'ALQUILER',
                    'Se actualizaron fechas de alquiler y costo_total',
                    'Fecha inicio: ' || :old.fecha_inicio || ', Fecha fin: ' || :old.fecha_fin,
                    'Fecha inicio: ' || :new.fecha_inicio || ', Fecha fin: ' || :new.fecha_fin
                );
            end if;
        when deleting then
            raise_application_error(-20006, 'No se pueden eliminar alquileres');

    end case;

end;
/
show errors;