-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 06/12/2024
-- Descripción: Consultas

/* El folio de alquiler es un identificador único que debe crearse automáticamente cuando se realiza un alquiler de una vivienda 
para vacaciones. Esta función generará el folio basado en el año que se realizo el alquiler(ultimos dos digitos), mes y el dia en el que se alquilo. */

create or replace function calcular_folio_alquiler(
    p_fecha_alquiler date
) return varchar2
is
    v_folio varchar2(8);
    v_ultimos_dos_digitos number(2);
    v_dia_del_anio number(3);
    v_consecutivo number(3);
begin
    -- Obtener los últimos dos dígitos del año
    select to_number(to_char(p_fecha_alquiler, 'yy')) into v_ultimos_dos_digitos from dual;

    -- Obtener el día del año (en formato de 3 dígitos)
    select to_number(to_char(p_fecha_alquiler, 'ddd')) into v_dia_del_anio from dual;

    -- Obtener el contador de alquileres del día específico
    select nvl(count(*), 0) + 1 into v_consecutivo
    from alquiler
    where to_char(fecha_inicio, 'yy') = to_char(p_fecha_alquiler, 'yy')
      and to_char(fecha_inicio, 'ddd') = to_char(p_fecha_alquiler, 'ddd');

    -- Crear el folio con el día del año y el contador
    v_folio := v_ultimos_dos_digitos || lpad(v_dia_del_anio, 3, '0') || lpad(v_consecutivo, 3, '0');

    return v_folio;
end;
/

