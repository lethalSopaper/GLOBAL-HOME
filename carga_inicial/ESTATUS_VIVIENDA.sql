/*
Estados posibles:
- DISPONIBLE
- EN RENTA
- ALQUILADA
- EN VENTA
- VENDIDA
- INACTIVA
*/

insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (1, 'DISPONIBLE', 'Vivienda disponible para renta o venta o alquiler');
insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (2, 'EN RENTA', 'Vivienda en renta');
insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (3, 'ALQUILADA', 'Vivienda alquilada');
insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (4, 'EN VENTA', 'Vivienda en venta');
insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (5, 'VENDIDA', 'Vivienda vendida');
insert into ESTATUS_VIVIENDA (estatus_vivienda_id, clave, descripcion)
values (6, 'INACTIVA', 'Vivienda inactiva. No está disponible para renta, venta o alquiler y no tiene ocupantes.');