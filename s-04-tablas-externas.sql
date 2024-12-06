-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Lis Antonio
-- Fecha: 04/11/2024
-- Descripción: Creación de tablas externas para la carga de datos

-- Eliminar la tabla logs_ext si ya existe
begin
    execute immediate 'drop table logs_ext';
exception 
    when others then null;
    if sqlcode != -942 then
        raise;
    end if;
end;
/

-- Crear la tabla externa para los logs de actividades
create table logs_ext (
    evento_id number(10,0),
    usuario varchar2(30),
    accion varchar2(20),
    tabla_afectada varchar2(30),
    detalle_accion varchar2(1000),
    fecha_evento timestamp,
    valor_anterior varchar2(1000), -- solo actualizaciones o eliminaciones
    valor_nuevo varchar2(1000) -- solo actualizaciones o inserciones
)
organization external (
    type oracle_loader
    default directory logs_dir
    access parameters (
        records delimited by newline
        badfile 'logs_ext_bad.log' 
        logfile 'logs_ext.log' 
        fields terminated by ',' 
        lrtrim 
        missing field values are null 
        (
            evento_id,
            usuario,
            accion,
            tabla_afectada,
            detalle_accion,
            fecha_evento char date_format timestamp mask "dd/mm/yyyy hh24:mi:ss",
            valor_anterior,
            valor_nuevo
        )
    )
    location ('logs_ext.csv')
)
reject limit unlimited; 