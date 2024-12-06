-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 05/12/2024
-- Descripción: Creación de tablas temporales para la carga de datos

-- Tabla temporal para leer los datos que se incertaran en el csv

create global temporary table operaciones_temp(
    operaciones_temp_id number(10,0) primary key,
    usuario varchar2(30),
    accion varchar2(20),
    tabla_afectada varchar2(30),
    detalle_accion varchar2(1000),
    fecha_evento timestamp default systimestamp,
    valor_anterior varchar2(1000),
    valor_nuevo varchar2(1000)
) on commit delete rows;