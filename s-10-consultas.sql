-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- fecha: 05/12/2024
-- Descripción: Consultas 
 
/* ● Este archivo contendrá 5 o más consultas. El criterio es libre. Se debe emplear el uso
de los siguientes elementos.
○ joins (inner join, natural join, outer join) (X)
○ funciones de agregación (group by y having) (X)
○ álgebra relacional (operadores set: union, intersect, minus). (X)
○ Subconsultas (X)
○ Consulta que involucre el uso de un sinónimo (X)
○ Consulta que involucre el uso de una vista (X)
○ Consulta que involucre una tabla temporal
○ Consulta que involucre a una tabla externa.
● No es necesario crear una consulta por cada elemento. En una misma consulta
pueden incluirse varios de los elementos anteriores. */

/* Consulta 1: 
La empresa necesita saber el identificador de la vivienda, clave del estatus, el número catastral, 
precio inicial y el identificador del usuario dueño de las viviendas de venta estan
disponibles y de las que están en proceso de compra mostrar el precio final,
la comision y el usuario interesado en comprarla.
Se deben oobtener 10 registros
*/

select v.vivienda_id, e.clave, vv.num_catastral,
    vv.precio_inicial, v.usuario_duenio_id, 
    c.precio_final, c.comision, c.usuario_id as comprador
from usuario u
join vivienda v on u.usuario_id = v.usuario_duenio_id
join estatus_vivienda e on v.estatus_vivienda_id = e.estatus_vivienda_id
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
left join compra c on vv.vivienda_venta_id = c.vivienda_venta_id
where e.clave = 'DISPONIBLE' or e.clave = 'EN VENTA';

/*
CONSULTA 2:
Los administradores de global home han decidido que a los 3 dueños de las viviedas vacacioneles
mas populares se les dara un bono de 5000 pesos, para ellos se necesita saber su nombre, su email
el identificador y la dirección de la vivienda y la cantidad de veces que han alquilado esa vivienda.
Se deben obtener 20 registros
*/

select u.nombre, u.email, v.vivienda_id, v.direccion, count(*) as veces_alquilada
from usuario u
join vivienda v on u.usuario_id = v.usuario_duenio_id
join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
group by u.nombre, u.email, v.vivienda_id, v.direccion
order by veces_alquilada desc;

/*
CONSULTA 3:
Se requiere saber, el identificador de la vivienda, el tipo de vivienda, la cantidad de servicios
que ofrecen y las que sean mayores al promedio de servicios se les otorgará una recompensa.
Se deben obtener 31 registros
*/

select vsv.vivienda_id, vsv.es_vacaciones, vsv.es_renta, vsv.es_venta,
count(*) as cantidad_servicios, 
(select avg(cantidad_servicios) from 
    (select count(*) as cantidad_servicios 
     from v_servicio_vivienda 
     group by vivienda_id)) as promedio_servicios
from v_servicio_vivienda vsv
group by vsv.vivienda_id, vsv.es_vacaciones, vsv.es_renta, vsv.es_venta
having count(*) > promedio_servicios;

/*
CONSULTA 4:
Se decidio que los usuarios que han rentado, alquilado y comprado una vivienda se les otorgara una
insignia de oro y un descuento del 10% en su próxima actividad, se necesita saber el identificador
del usuario, su nombre, apellido paterno, apellido materno (de existir) y el email para contactarlo.
Con operaciones set: union, intersect, minus.
Se deben obtener 3 registros
*/

select u.usuario_id, u.nombre, u.apellido_paterno, u.apellido_materno, u.email
from TU_usuario u
join alquiler a on u.usuario_id = a.usuario_id
intersect
select u.usuario_id, u.nombre, u.apellido_paterno, u.apellido_materno, u.email
from TU_usuario u
join renta r on u.usuario_id = r.usuario_id
intersect
select u.usuario_id, u.nombre, u.apellido_paterno, u.apellido_materno, u.email
from TU_usuario u
join compra c on u.usuario_id = c.usuario_id
order by usuario_id;

/* CONSULTA 5:
(de la tabla externa logs_ext)
Se desea saber para la todas las modificaciones de la tabla alquiler, la fecha del evento, el usuario, el detalle de la acción, el valor anterior y el valor nuevo.
Se deben obtener 6 registros
*/

select fecha_evento, usuario, accion, valor_anterior, valor_nuevo
from logs_ext
where tabla_afectada = 'ALQUILER'
and accion = 'UPDATE';