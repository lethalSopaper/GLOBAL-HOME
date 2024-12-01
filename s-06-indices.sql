-- Autor: Tepal Briseño Hansel Yael y Ugartechea Gonzáles Luis Antonio
-- Fecha: 30/11/2024
-- Descripción: Creación de índices para las tablas de la base de datos

-- Indices para la tabla tarjeta

create index tarjeta_usuadio_id_ifx on tarjeta(usuario_id);

-- Indices para la tabla Mensaje

create index mensaje_usuario_id_ifx on mensaje(usuario_id);
create index mensaje_vivienda_id_ifx on mensaje(vivienda_id);
create index mensaje_mensaje_respuesta_id_ifx on mensaje(mensaje_respuesta_id);

-- Indices para la tabla Vivienda

create index vivienda_usuario_id_ifx on vivienda(usuario_duenio_id);
create index vivienda_estatus_vivienda_id_ifx on vivienda(estatus_vivienda_id);


