-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 06/12/2024
-- Descripción: Puebas unitarias para la función calcular_folio_alquiler

-- Datos de prueba
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
    v_folio varchar2(8);
begin
    begin
        dbms_output.put_line('Caso 1: Calcular el folio de un alquiler');
        v_folio := calcular_folio_alquiler(to_date('2024-12-06', 'yyyy-mm-dd'));
        dbms_output.put_line('Exitoso: el folio del alquiler es: ' || v_folio);
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    begin
        dbms_output.put_line('Caso 2: Calcular el folio de un alquiler con una fecha nula');
        v_folio := calcular_folio_alquiler(null);
        dbms_output.put_line('Fallido: el folio del alquiler es: ' || v_folio);
    exception
        when others then
            if sqlcode = -20011 then
                dbms_output.put_line('Exitoso: ' || sqlerrm);
            else
                dbms_output.put_line('Fallido: ' || sqlerrm);
            end if;
    end;

    begin
        dbms_output.put_line('Caso 3: Calcular el folio de un alquiler en año bisiesto');
        v_folio := calcular_folio_alquiler(to_date('2024-02-29', 'yyyy-mm-dd'));
        dbms_output.put_line('Exitoso: el folio del alquiler es: ' || v_folio);
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    begin
        dbms_output.put_line('Caso 4: Calcular el folio de un alquiler el 31 de diciembre');
        v_folio := calcular_folio_alquiler(to_date('2024-12-31', 'yyyy-mm-dd'));
        dbms_output.put_line('Exitoso: el folio del alquiler es: ' || v_folio);
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    begin
        dbms_output.put_line('Caso 5: Calcular el folio de un alquiler el 1 de enero');
        v_folio := calcular_folio_alquiler(to_date('2024-01-01', 'yyyy-mm-dd'));
        dbms_output.put_line('Exitoso: el folio del alquiler es: ' || v_folio);
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    begin
        dbms_output.put_line('Caso 6: Calcular varios folios de alquiler en el mismo día');
        for i in 1..5 loop
            v_folio := calcular_folio_alquiler(to_date('2024-12-06', 'yyyy-mm-dd'));
            dbms_output.put_line('Exitoso: el folio del alquiler es: ' || v_folio);
        end loop;
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

end;
/
rollback;