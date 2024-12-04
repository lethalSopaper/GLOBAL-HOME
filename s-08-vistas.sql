-- Autor: Tepeal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 31/11/2024
-- Descripción: Creación de vistas para la base de datos

-- Vista para información básica de los usuarios y sus respectivas tarjetas (sin información sensible)

create or replace view v_usuario_tarjeta(
    u.usuario_id, nombre_usuario, email, tarjeta_id,
    num_tarjeta, mes_expiracion, anio_expiracion
) as 
select u.usuario_id, u.nombre_usuario, u.email,
    t.tarjeta_id, t.num_tarjeta, t.mes_expiracion, 
    t.anio_expiracion
from usuario u
left join tarjeta t on u.usuario_id = t.usuario_id;

-- Vista para resumir la informacion de todas las viviendas disponibles 

create or replace view v_vivienda_disponible(
    vivienda_id, direccion, descripcion,
    es_vacaciones, es_renta, es_venta
) as 
select v.vivienda_id, v.direccion, v.descripcion,
    v.es_vacaciones, v.es_renta, v.es_venta
from vivienda v
where v.estatus_vivienda_id = 1;

-- Vista para mostrar los servicios asociados a un vivienda
create or replace view v_servicio_vivienda(
    vivienda_id, direccion, descripcion, servicio_id, 
    nombre_servicio
) as
select v.vivienda_id, v.direccion, v.descripcion, 
    s.servicio_id, s.nombre_servicio
from vivienda v, vivienda_servicio vs, servicio s
where v.vivienda_id = vs.vivienda_id
and vs.servicio_id = s.servicio_id;

-- Vista para mostrar el historial de estatus de una vivienda

create or replace view v_historial_estatus_vivienda(
    vivienda_id, v.direccion, v.descripcion, 
    h.historico_estatus_vivienda_id, h.fecha_estatus,
    e.clave, e.descripcion
) as
select v.vivienda_id, v.direccion, v.descripcion,
    h.historico_estatus_vivienda_id, h.fecha_estatus,
    e.clave, e.descripcion
from vivienda v, historico_estatus_vivienda h, estatus_vivienda e
where v.vivienda_id = h.vivienda_id
and h.estatus_vivienda_id = e.estatus_vivienda_id;


-- Vista para mostrar los mensajes entre el usuario dueño y el usuario interesado en una vivienda

create or replace view v_mensaje(
    mensaje_id, titulo, fecha_envio, cuerpo,
    leido, nombre_usuario_interesado, email_interesado,
    nombre_usuario_duenio, email_duenio,
    vivienda_id, direccion, descripcion
) as
select m.mensaje_id, m.titulo, m.fecha_envio, m.cuerpo,
    m.leido, u.nombre_usuario, u.email, ud.nombre_usuario, ud.email,
    v.vivienda_id, v.direccion, v.descripcion
from usuario u, mensaje m, vivienda v, usuario ud
where u.usuario_id = m.usuario_id
and m.vivienda_id = v.vivienda_id
and v.usuario_duenio_id = ud.usuario_id;

-- Vista para mostrar los favoritos de un usuario

create or replace view v_favorito(
    usuario_id, nombre_usuario, email, 
    vivienda_id, direccion, descripcion
) as
select u.usuario_id, u.nombre_usuario, u.email,
    v.vivienda_id, v.direccion, v.descripcion
from usuario u, favorito f, vivienda v
where u.usuario_id = f.usuario_id
and f.vivienda_id = v.vivienda_id;

-- Vista para mostrar los alquileres de un usuario

create or replace view v_alquiler(
    alquiler_id, fecha_inicio, fecha_fin, 
    usuario_id, nombre_usuario, email,
    vivienda_id, direccion, descripcion
) as
select a.alquiler_id, a.fecha_inicio, a.fecha_fin,
    u.usuario_id, u.nombre_usuario, u.email,
    v.vivienda_id, v.direccion, v.descripcion
from alquiler a, usuario u, vivienda v
where a.usuario_id = u.usuario_id
and a.vivienda_id = v.vivienda_id;

-- permisos para acceder a las vistas

grant select on v_vivienda_disponible to tu_proy_invitado;
grant select on v_servicio_vivienda to tu_proy_invitado;
grant select on v_mensaje to tu_proy_invitado;
grant select on v_favorito to tu_proy_invitado;
grant select on v_alquiler to tu_proy_invitado;