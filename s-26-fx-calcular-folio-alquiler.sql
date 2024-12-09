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
    -- Validar que la fecha de alquiler no sea nula
    if p_fecha_alquiler is null then
        raise_application_error(-20011, 'La fecha de alquiler no puede ser nula');
    end if;
    -- Obtener los últimos dos dígitos del año
    select to_number(to_char(p_fecha_alquiler, 'y')) into v_ultimos_dos_digitos from dual;

    -- Obtener el día del año (en formato de 3 dígitos)
    select to_number(to_char(p_fecha_alquiler, 'ddd')) into v_dia_del_anio from dual;

    -- Obtener el consecutivo de alquileres en el día
    select folio_alquiler_seq.nextval into v_consecutivo from dual;

    -- Crear el folio con el día del año y el contador
    v_folio := v_ultimos_dos_digitos || lpad(v_dia_del_anio, 3, '0') || lpad(v_consecutivo, 4, '0');

    return v_folio;

end;
/
show errors;
