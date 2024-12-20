select vr.vivienda_renta_id, v.usuario_duenio_id, vr.renta_mensual, vr.dia_pago, r.fecha_inicio, r.fecha_fin
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is not null;

select vr.vivienda_renta_id, v.usuario_duenio_id, vr.renta_mensual, vr.dia_pago, r.fecha_inicio, r.fecha_fin,
    trunc(months_between(r.fecha_fin, r.fecha_inicio)) as months,
    (trunc(months_between(r.fecha_fin, r.fecha_inicio)) * vr.renta_mensual) as total_rent,
    sum(trunc(months_between(r.fecha_fin, r.fecha_inicio)) * vr.renta_mensual) over () as total_rent1
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is not null;

select vr.vivienda_renta_id, v.usuario_duenio_id, vr.renta_mensual, vr.dia_pago, r.fecha_inicio, r.fecha_fin,
    trunc(months_between(sysdate, r.fecha_inicio)) as months,
    (trunc(months_between(sysdate, r.fecha_inicio)) * vr.renta_mensual) as total_rent,
    sum(trunc(months_between(sysdate, r.fecha_inicio)) * vr.renta_mensual) over () as total_rent1
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is null;

select sum(trunc(months_between(r.fecha_fin, r.fecha_inicio)) * vr.renta_mensual) as total_renta
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is not null;

select sum(trunc(months_between(sysdate, r.fecha_inicio)) * vr.renta_mensual) as total_renta
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is null;

select sum(a.costo_total)
from vivienda v
join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
where v.usuario_duenio_id = 40;

select v.usuario_duenio_id, count(*) as total_alquileres
from vivienda v
join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
group by v.usuario_duenio_id
order by total_alquileres desc;

select count(*) as total_pagos, v.usuario_duenio_id
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
group by v.usuario_duenio_id
order by total_pagos desc;

select sum(p.importe) as total_pagos
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
where v.usuario_duenio_id = 8;

select p.num_pago, p.vivienda_venta_id, sum(p.importe) as total_pagos
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
where v.usuario_duenio_id = 8
group by p.num_pago, p.vivienda_venta_id;

select v.usuario_duenio_id, count(*) as total_viviendas_venta
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
group by v.usuario_duenio_id
order by total_viviendas_venta desc;

select mensaje_id, fecha_envio, leido
from mensaje;

select mensaje_id as "Mensajes sin respuesta"
from mensaje
where mensaje_respuesta_id is null;

select usuario_duenio_id, count(*) as total_rentas
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
group by usuario_duenio_id
order by total_rentas desc;

-- util para pruebas
-- alquileres
select v.usuario_duenio_id, count(*) as total_alquileres
from vivienda v
join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
where v.usuario_duenio_id = 40
group by v.usuario_duenio_id;
-- Ganancias de alquiler
select sum(a.costo_total)
from vivienda v
join vivienda_vacaciones vv on v.vivienda_id = vv.vivienda_vacaciones_id
join alquiler a on vv.vivienda_vacaciones_id = a.vivienda_vacaciones_id
where v.usuario_duenio_id = 40;
-- rentas
select usuario_duenio_id, count(*) as total_rentas
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where usuario_duenio_id = 40
group by usuario_duenio_id;
-- compras
select usuario_duenio_id, count(*) as total_pagos, sum(p.importe) as total_pagos
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
join compra c on vv.vivienda_venta_id = c.vivienda_venta_id
join pago p on c.vivienda_venta_id = p.vivienda_venta_id
where usuario_duenio_id = 40
group by usuario_duenio_id;
-- Ganancias de compra
select sum(p.importe)
from vivienda v
join vivienda_venta vv on v.vivienda_id = vv.vivienda_venta_id
join pago p on vv.vivienda_venta_id = p.vivienda_venta_id
where v.usuario_duenio_id = 40;
-- Usuarios duenios
select usuario_duenio_id
from vivienda
order by usuario_duenio_id;
------------------

select sum(trunc(months_between(r.fecha_fin, r.fecha_inicio)) * vr.renta_mensual)
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is not null;

select sum(trunc(months_between(sysdate, r.fecha_inicio)) * vr.renta_mensual)
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
where v.usuario_duenio_id = 40
and r.fecha_fin is null;

select usuario_duenio_id, count(*) as total_rentas
from vivienda v
join vivienda_renta vr on v.vivienda_id = vr.vivienda_renta_id
join renta r on vr.vivienda_renta_id = r.vivienda_renta_id
group by usuario_duenio_id
order by total_rentas desc;

select u.usuario_id, count(*)
from vivienda v
join usuario u on u.usuario_id = v.usuario_duenio_id
where v.usuario_duenio_id = 40
group by u.usuario_id;