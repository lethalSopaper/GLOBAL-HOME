-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 08/12/2024
-- Descripción: Pruebas unitarias para la función calcular_total_alquiler

--Datos de prueba
 insert into vivienda (
        vivienda_id, es_vacaciones, es_renta, 
        es_venta, capacidad_maxima, fecha_estatus, 
        latitud, longitud, direccion, 
        descripcion, estatus_vivienda_id, usuario_duenio_id) 
        values (100, true, false, 
        false, 5, to_date('2024-12-06', 'yyyy-mm-dd'), 
        '24.1477358', '120.6736482', 
        '64 Cascade Point', 
        'Casa con vista al mar', 1, 36);
        -- Insertar una vivienda de vacaciones
        insert into vivienda_vacaciones (
            vivienda_vacaciones_id, max_dias, costo_dia, costo_apartado
        ) values(
            100, 10, 1000, 5000
        );
set serveroutput on

declare 
    v_total number(11,2);
begin
    begin
        dbms_output.put_line('Caso de prueba 1: Calcular el total de un alquiler con un número de días de alquiler menor al máximo permitido');
        v_total := calcular_total_alquiler(100, to_date('2024-12-06', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'));
        dbms_output.put_line('Exitoso: el total del alquiler es: ' || v_total);
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    begin
        dbms_output.put_line('Caso de prueba 2: Calcular el total de un alquiler con un número de días de alquiler mayor al máximo permitido');
        v_total := calcular_total_alquiler(100, to_date('2024-12-06', 'yyyy-mm-dd'), to_date('2024-12-20', 'yyyy-mm-dd'));
        dbms_output.put_line('Fallido: el total del alquiler es: ' || v_total);
    exception
        when others then
            if sqlcode = -20008 then
                dbms_output.put_line('Exitoso: ' || sqlerrm);
            else
                dbms_output.put_line('Fallido: ' || sqlerrm);
            end if;
    end;

    begin
        dbms_output.put_line('Caso de prueba 3: Calcular el total de un alquiler con una fecha de fin menor a la fecha de inicio');
        v_total := calcular_total_alquiler(100, to_date('2024-12-06', 'yyyy-mm-dd'), to_date('2024-12-05', 'yyyy-mm-dd'));
        dbms_output.put_line('Fallido: el total del alquiler es: ' || v_total);
    exception
        when others then
            if sqlcode = -20010 then
                dbms_output.put_line('Exitoso: ' || sqlerrm);
            else
                dbms_output.put_line('Fallido: ' || sqlerrm);
            end if;
    end;

    begin
        dbms_output.put_line('Caso de prueba 4: Calcular el total de un alquiler con una vivienda que no existe');
        v_total := calcular_total_alquiler(101, to_date('2024-12-06', 'yyyy-mm-dd'), to_date('2024-12-10', 'yyyy-mm-dd'));
        dbms_output.put_line('Fallido: el total del alquiler es: ' || v_total);
    exception
        when others then
            if sqlcode = -20009 then
                dbms_output.put_line('Exitoso: ' || sqlerrm);
            else
                dbms_output.put_line('Fallido: ' || sqlerrm);
            end if;
    end;
end;
/
rollback;