-- Autor: Tepal Briseño Hansel Yael y Ugartechea Gonzáles Luis Antonio
-- Fecha: 30/11/2024
-- Descripción: Creación de índices para las tablas de la base de datos

-- Indices para la tabla tarjeta

create index tarjeta_usuadio_id_ix on tarjeta(usuario_id);
--create unique tarjeta_num_tarjeta_uk on tarjeta(num_tarjeta); indice implicito por la constraint tarjeta_num_tarjeta_uk

-- Indices para la tabla Mensaje

create index mensaje_usuario_id_ix on mensaje(usuario_id);
create index mensaje_vivienda_id_ix on mensaje(vivienda_id);
create index mensaje_mensaje_respuesta_id_ix on mensaje(mensaje_respuesta_id);

-- Indices para la tabla Vivienda

create index vivienda_usuario_id_ix on vivienda(usuario_duenio_id);
create index vivienda_estatus_vivienda_id_ix on vivienda(estatus_vivienda_id);


-- Indices para la tabla Usuario

-- Indices para la tabla Alquiler

create index alquiles_fecha_inicio_ifx on alquiler(to_char(fecha_inicio, 'yyyy'));

