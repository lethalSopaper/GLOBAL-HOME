-- Autor: Tepal Briseño Hansel Yael y Ugartechea Gonzáles Luis Antonio
-- Fecha: 30/11/2024
-- Descripción: Creación de secuencias para las tablas de la base de datos

-- Secuencia para la tabla usuario

create sequence usuario_seq 
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla Tarjeta

create sequence tarjeta_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla mensaje

create sequence mensaje_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla vivienda

create sequence vivienda_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla servicio

create sequence servicio_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla servicio_vivienda

create sequence servicio_vivienda_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla historico_estatus_vivienda

create sequence historico_estatus_vivienda_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla favorito

create sequence favorito_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla alquiler

create sequence alquiler_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla encuesta

create sequence encuesta_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

-- Secuencia para la tabla clabe

create sequence clabe_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

--Secuencia para la tabla Renta

create sequence renta_seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    cache 20
    order
;

