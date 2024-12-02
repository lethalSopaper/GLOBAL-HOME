-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 28/11/2024
-- Descripción: Creación las tablas del modelo relacional

prompt conectando con la pdb con el usuario tu_proy_admin
connect tu_proy_admin/1234@htblugbd_s2

--Tabla: Usuario

create table usuario(
    usuario_id number(10,0),
    email varchar2(128) not null,
    nombre_usuario varchar2(15) not null, 
    nombre varchar2(32) not null,
    apellido_paterno varchar2(32) not null,
    apellido_materno varchar2(32),
    contrasenia varchar2(15) not null,
    constraint usuario_pk primary key(usuario_id),
    constraint usuario_email_uk unique(email),
    constraint usuario_nombre_usuario_uk unique(nombre_usuario),
    constraint contrasenia_chk check(length(contrasenia) >= 8)
)

--Tabla: Tarjeta

create table tarjeta(
    tarjeta_id number(10,0),
    num_tarjeta number(16,0) not null,
    mes_expiracion number(2,0) not null,
    anio_expiracion number(4,0) not null,
    numero_seguridad number(3,0) not null, 
    usuario_id not null,
    constraint tarjeta_pk primary key(tarjeta_id),
    constraint tarjeta_num_tarjeta_uk unique(num_tarjeta),
    constraint tarjeta_usuario_id_fk foreign key(usuario_id) 
        references usuario(usuario_id),
    constraint tarjeta_mes_expiracion_chk check( mes_expiracion between 1 and 12)
)
--Tabla: Estatus_Vivienda

create table estatus_vivienda(
    estatus_vivienda_id number(10,0),
    clave varchar2(10) not null,
    descripcion varchar2(128),
    constraint estatus_vivienda_pk primary key(estatus_vivienda_id)
)
-- Tabla: Vivienda

create table vivienda (
    vivienda_id number (10,0),
    es_vacaciones boolean not null, 
    es_renta boolean not null,
    es_venta boolean not null,
    capacidad_maxima number(2,0) not null,
    fecha_estatus date not null,
    latitud varchar2(15) not null, 
    longitud varchar2(15) not null,
    direccion varchar2(128) not null, 
    estatus_vivienda_id not null,
    usuario_duenio_id not null,
    descripcion varchar2(2000),
    constraint vivienda_pk primary key(vivienda_id),
    constraint vivienda_estatus_vivienda_id_fk foreign key(estatus_vivienda_id) 
        references estatus_vivienda(estatus_vivienda_id),
    constraint vivienda_usuario_dueño_id_fk foreign key(usuario_duenio_id) 
        references usuario(usuario_id),
    constraint vivienda_jerarquia_chk check(
        (es_vacaciones = true and es_renta = true and es_venta = false) or
        (es_vacaciones = true and es_renta = false and es_venta = false) or
        (es_vacaciones = false and es_renta = true and es_venta = false) or
        (es_vacaciones = false and es_renta = false and es_venta = true)
    )
)

--Tabla: Imagen

create table imagen(
    num_imagen number(2,0),
    vivienda_id not null,
    imagen blob not null
    constraint imagen_vivienda_id_fk foreign key(vivienda_id) 
        references vivienda(vivienda_id),
    constraint imagen_pk primary key(vivienda_id,num_imagen)
)

--Tabla: Historico_Estatus_Vivienda

create table historico_estatus_vivienda(
    historico_estatus_vivienda_id number(10,0),
    fecha_estatus date not null,
    estatus_vivienda_id not null,
    vivienda_id not null,
    constraint historico_estatus_vivienda_pk primary key(historico_estatus_vivienda_id),
    constraint historico_estatus_vivienda_estatus_vivienda_id_fk foreign key(estatus_vivienda_id) 
        references estatus_vivienda(estatus_vivienda_id),
    constraint historico_estatus_vivienda_vivienda_id_fk foreign key(vivienda_id)
        references vivienda(vivienda_id)
)

--Tabla: Servicio

create table servicio(
    servicio_id number(10,0),
    nombre varchar2(32) not null,
    descripcion varchar2(200),
    icono blob not null,
    constraint servicio_pk primary key(servicio_id)
)

-- Tabla: Servicio_Vivienda

create table servicio_vivienda(
    servicio_vivienda_id number(10,0),
    vivienda_id not null,
    servicio_id not null,
    constraint servicio_vivienda_pk primary key(servicio_vivienda_id),
    constraint servicio_vivienda_vivienda_id_fk foreign key(vivienda_id) 
        references vivienda(vivienda_id),
    constraint servicio_vivienda_servicio_id_fk foreign key(servicio_id) 
        references servicio(servicio_id)
)

-- Tabla: mensaje

create table mensaje(
    mensaje_id number(10,0),
    titulo varchar2(40) not null,
    cuerpo varchar2(500) not null,
    leido boolean default on null false, 
    fecha_envio date default on null sysdate,
    antiguedad_mensaje generated always as (trunc(sysdate) - trunc(fecha_envio)) virtual,
    usuario_id not null,
    vivienda_id not null,
    mensaje_respuesta_id,
    constraint mensaje_pk primary key(mensaje_id),
    constraint mensaje_usuario_id_fk foreign key(usuario_id) 
        references usuario(usuario_id),
    constraint mensaje_vivienda_id_fk foreign key(vivienda_id)
        references vivienda(vivienda_id),
    constraint mensaje_mensaje_respuesta_id_fk foreign key(mensaje_respuesta_id)
        references mensaje(mensaje_id)
)

--Tabla: Vivienda_vacasiones

create table vivienda_vacaciones(
    vivienda_vacaciones_id,
    disponible boolean default on null true, 
    max_dias number(3,0) not null,
    costo_apartado (10,4) not null,
    costo_dia (10,4) not null,
    constraint vivienda_vacaciones_vienda_vacaciones_id_fk foreign key(vivienda_vacaciones_id) 
        references vivienda(vivienda_id),
    constraint vivienda_vacaciones_pk primary key(vivienda_vacaciones_id)
)

--Tabla: Vivienda_renta

create table vivienda_renta(
    vivienda_renta_id,
    dia_pago number(2,0) not null,
    renta_mensual (10,4) not null,
    constraint vivienda_renta_vivienda_renta_id_fk foreign key(vivienda_renta_id) 
        references vivienda(vivienda_id),
    constraint vivienda_renta_pk primary key(vivienda_renta_id)
)

--Tabla: Vivienda_venta

create table vivienda_venta(
    vivienta_venta_id,
    num_castral varchar2(16) not null,
    folio_escritura varchar2(18) not null,
    avaluo_propiedad blob not null,
    precio_inicial (11,2) not null,
    constraint vivienda_venta_vivienda_venta_id_fk foreign key(vivienda_venta_id) 
        references vivienda(vivienda_id),
    constraint vivienda_venta_pk primary key(vivienda_venta_id),
    constraint vivienda_venta_num_castral_uk unique(num_castral),
    constraint vivienda_venta_folio_escritura_uk unique(folio_escritura)
)

--Tabla: favorito

create table favorito(
    favorito_id number(10,0),   
    telefono number(10,0) not null,
    notificacion_enviada boolean default on null false, 
    usuario_id not null,
    vivienda_vacaciones_id not null,
    constraint favorito_pk primary key(favorito_id),
    constraint favorito_usuario_id_fk foreign key(usuario_id)
        references usuario(usuario_id),
    constraint favorito_vivienda_vacaciones_id_fk foreign key(vivienda_vacaciones_id)
        references vivienda_vacaciones(vivienda_vacaciones_id),
    constraint favorito_telefono_uk unique(telefono)
)

--Tabla: Alquiler 

create table alquiler(
    alquiler_id number(10,0),
    folio varchar2(8) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    duracion_alquiler generated always as (trunc(fecha_fin) - trunc(fecha_inicio)) virtual, 
    vivienda_vacaciones_id not null,
    usuario_id not null
    constraint alquiler_pk primary key(alquiler_id),
    constraint alquiler_vivienda_vacaciones_id_fk foreign key(vivienda_vacaciones_id)
        references vivienda_vacaciones(vivienda_vacaciones_id),
    constraint alquiler_usuario_id_fk foreign key(usuario_id)
        references usuario(usuario_id),
    constraint alquiler_folio_uk unique(folio)
)

--Tabla: Encuesta

create table encuesta(
    encuesta_id number(10,0),
    fecha_evaluacion date default on null sysdate,
    calificacion number(1,0) not null,
    descripcion varchar2(128),
    alquiler_id not null,
    usuario_id not null,
    constraint encuesta_pk primary key(encuesta_id),
    constraint encuesta_alquiler_id_fk foreign key(alquiler_id)
        references alquiler(alquiler_id),
    constraint encuesta_usuario_id_fk foreign key(usuario_id)
        references usuario(usuario_id),
    constraint encuasta_calificacion_chk check(
        calificacion between 1 and 5
    )
)

--Tabla: Clabe

create table clabe(
    clabe_id number(10,0),
    clabe numeric(18,0) not null,
    vivienda_renta_id not null,
    constraint clabe_pk primary key(clabe_id),
    constraint clabe_vivienda_renta_id_fk foreign key(vivienda_renta_id)
        references vivienda_renta(vivienda_renta_id),
    constraint clabe_clabe_uk unique(clabe)
)

--Tabla: Renta

create table renta(
    renta_id number(10,0),
    folio_contrato varchar2(8) not null,
    fecha_inicio date not null,
    contrato blob not null,
    vivienda_renta_id not null,
    usuario_id not null,
    constraint renta_pk primary key(renta_id),
    constraint renta_vivienda_renta_id_fk foreign key(vivienda_renta_id)
        references vivienda_renta(vivienda_renta_id),
    constraint renta_usuario_id_fk foreign key(usuario_id)
        references usuario(usuario_id),
    constraint renta_folio_contrato_uk unique(folio_contrato)
)

--Tabla: Compra

create table compra(
    vivienda_venta_id,
    clabe_interbancaria numeric(18,0) not null,
    precio_final (11,2) not null,
    comision (10,4) not null,
    usuario_id not null,
    constraint compra_vivienda_venta_id_fk foreign key(vivienda_venta_id)
        references vivienda_venta(vivienda_venta_id),
    constraint compra_usuario_id_fk foreign key(usuario_id),
    constraint compra_pk primary key(vivienda_venta_id)
)

--Tabla: Pago

create table pago(
    num_pago number(10,0),
    vivienda_venta_id,
    fecha_pago date default on null sysdate,
    importe number(8,2) not null,  
    recibo blob not null,   
    constraint pago_vivienda_venta_id_fk foreign key(vivienda_venta_id)
        references vivienda_venta(vivienda_venta_id),
    constraint pago_pk primary key(vivienda_venta_id, num_pago)
)
