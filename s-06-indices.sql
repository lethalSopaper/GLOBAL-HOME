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
create index mensaje_fecha_envio_ifx on mensaje(to_char(fecha_envio, 'yyyy-mm'));

-- Indices para la tabla Vivienda

create index vivienda_usuario_id_ix on vivienda(usuario_duenio_id);
create index vivienda_estatus_vivienda_id_ix on vivienda(estatus_vivienda_id);

-- Indices para la tabla vivienda_venta

--create unique index vivienda_venta_num_catastral_uk on vivienda_venta(num_catastral); indice implicito por la constraint vivienda_venta_num_catastral_uk
--create unique index vivienda_venta_folio_escritura_uk on vivienda_venta(folio_escritura); indice implicito por la constraint vivienda_venta_folio_escritura_uk

-- Indices para la tabla Usuario

create index usuario_email_ifx on usuario(lower(email));
create index usuario_nombre_usuario_ifx on usuario(lower(nombre_usuario));
-- create unique index usuario_email_uk on usuario(email); indice implicito por la constraint usuario_email_uk
-- create unique index usuario_nombre_usuario_uk on usuario(nombre_usuario); indice implicito por la constraint usuario_nombre_usuario_uk

-- Indices para la tabla Servicio_vivienda

create index servicio_vivienda_vivienda_id_ix on servicio_vivienda(vivienda_id);
create index servicio_vivienda_servicio_id_ix on servicio_vivienda(servicio_id);

-- Indices para la tabla historico_estauts_vivienda

create index historico_estatus_vivienda_estatus_vivienda_id_ix on historico_estatus_vivienda(estatus_vivienda_id);
create index historico_estatus_vivienda_vivienda_id_ix on historico_estatus_vivienda(vivienda_id);

-- Indices para la tabla favorito

create index favorito_usuario_id_ix on favorito(usuario_id);
create index favorito_vivienda_vacaciones_id_ix on favorito(vivienda_vacaciones_id);
-- create unique index favorito_telefono_uk on favorito(telefono); indice implicito por la constraint favorito_telefono_uk

-- Indices para la tabla Alquiler

create index alquiler_usuario_id_ix on alquiler(usuario_id);
create index alquiler_vivienda_vacaciones_id_ix on alquiler(vivienda_vacaciones_id);
create index alquiler_fecha_inicio_anio_ifx on alquiler(to_char(fecha_inicio, 'yyyy'));
create index alquiler_fecha_inicio_mes_ifx on alquiler(to_char(fecha_inicio, 'mm'));
create index alquiler_folio_ifx on alquiler(upper(folio));
-- create index unique alquiler_folio_uk on alquiler(folio); indice implicito por la constraint alquiler_folio_uk

-- Indices para la tabla Encuesta

create index encuesta_alquiler_id_ix on encuesta(alquiler_id);
create index encuesta_usuario_id_ix on encuesta(usuario_id);

-- Indices para la tabla Clabe

create index clabe_vivienda_renta_id_ix on clabe(vivienda_renta_id);
-- create unique index clabe_clabe_uk on clabe(clabe); indice implicito por la constraint clabe_clabe_uk

-- Indices para la tabla Renta

create index renta_usuario_id_ix on renta(usuario_id);
create index renta_vivienda_renta_id_ix on renta(vivienda_renta_id);
create index renta_folio_contrato_ifx on renta(upper(folio_contrato));
create index renta_fecha_inicio_anio_ifx on renta(to_char(fecha_inicio, 'yyyy'));
create index renta_fecha_inicio_mes_ifx on renta(to_char(fecha_inicio, 'mm'));
-- create unique index renta_folio_contrato_uk on renta(folio_contrato); indice implicito por la constraint renta_folio_contrato_uk

-- Indices para la tabla Compra

create index compra_usuario_id_ix on compra(usuario_id);
