-- 10 mensajes sin respuesta
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-1', 'cuerpo_mensaje-1-vivienda_id-1', true, to_date('18-02-2023','dd-mm-yyyy'), 41, 1);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-2', 'cuerpo_mensaje-1-vivienda_id-2', true, to_date('04-02-2023','dd-mm-yyyy'), 42, 2);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-3', 'cuerpo_mensaje-1-vivienda_id-3', true, to_date('17-02-2023','dd-mm-yyyy'), 43, 3);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-4', 'cuerpo_mensaje-1-vivienda_id-4', true, to_date('08-02-2023','dd-mm-yyyy'), 44, 4);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-5', 'cuerpo_mensaje-1-vivienda_id-5', true, to_date('24-02-2023','dd-mm-yyyy'), 45, 5);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-6', 'cuerpo_mensaje-1-vivienda_id-6', false, to_date('14-02-2023','dd-mm-yyyy'), 46, 1);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-7', 'cuerpo_mensaje-1-vivienda_id-7', false, to_date('12-02-2023','dd-mm-yyyy'), 47, 2);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-8', 'cuerpo_mensaje-1-vivienda_id-8', false, to_date('13-02-2023','dd-mm-yyyy'), 48, 3);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-9', 'cuerpo_mensaje-1-vivienda_id-9', false, to_date('14-02-2023','dd-mm-yyyy'), 49, 4);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-10', 'cuerpo_mensaje-1-vivienda_id-10', false, to_date('02-02-2023','dd-mm-yyyy'), 50, 5);

-- 5 mensajes con respuesta
-- Respuestas:
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-11', 'cuerpo_mensaje-2-vivienda_id-11', true, to_date('03-04-2023','dd-mm-yyyy'), 15, 6);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-12', 'cuerpo_mensaje-2-vivienda_id-12', true, to_date('12-04-2023','dd-mm-yyyy'), 5, 7);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-13', 'cuerpo_mensaje-2-vivienda_id-13', true, to_date('07-04-2023','dd-mm-yyyy'), 37, 8);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-14', 'cuerpo_mensaje-2-vivienda_id-14', true, to_date('11-04-2023','dd-mm-yyyy'), 24, 9);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-15', 'cuerpo_mensaje-2-vivienda_id-15', true, to_date('27-04-2023','dd-mm-yyyy'), 37, 10);
-- Mensajes:
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-11', 'cuerpo_mensaje-1-vivienda_id-11', true, to_date('03-02-2023','dd-mm-yyyy'), 51, 6, 11);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-12', 'cuerpo_mensaje-1-vivienda_id-12', true, to_date('12-02-2023','dd-mm-yyyy'), 52, 7, 12);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-13', 'cuerpo_mensaje-1-vivienda_id-13', true, to_date('07-02-2023','dd-mm-yyyy'), 53, 8, 13);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-14', 'cuerpo_mensaje-1-vivienda_id-14', true, to_date('11-02-2023','dd-mm-yyyy'), 54, 9, 14);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-15', 'cuerpo_mensaje-1-vivienda_id-15', true, to_date('27-02-2023','dd-mm-yyyy'), 55, 10, 15);

-- 5 Mesaje con respuesta y respuesta
-- Respuesta 2:
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-3-vivienda_id-16', 'cuerpo_mensaje-3-vivienda_id-11', true, to_date('25-06-2023','dd-mm-yyyy'), 56, 16);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-3-vivienda_id-17', 'cuerpo_mensaje-3-vivienda_id-12', true, to_date('23-06-2023','dd-mm-yyyy'), 57, 17);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-3-vivienda_id-18', 'cuerpo_mensaje-3-vivienda_id-13', true, to_date('26-06-2023','dd-mm-yyyy'), 58, 18);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-3-vivienda_id-19', 'cuerpo_mensaje-3-vivienda_id-14', true, to_date('03-06-2023','dd-mm-yyyy'), 59, 19);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id) values (mensaje_seq.nextval, 'titulo-3-vivienda_id-20', 'cuerpo_mensaje-3-vivienda_id-15', true, to_date('23-06-2023','dd-mm-yyyy'), 60, 20);
-- Respuesta 1:
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-16', 'cuerpo_mensaje-2-vivienda_id-11', true, to_date('25-05-2023','dd-mm-yyyy'), 10, 16, 21);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-17', 'cuerpo_mensaje-2-vivienda_id-12', true, to_date('23-05-2023','dd-mm-yyyy'), 10, 17, 22);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-18', 'cuerpo_mensaje-2-vivienda_id-13', true, to_date('26-05-2023','dd-mm-yyyy'), 13, 18, 23);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-19', 'cuerpo_mensaje-2-vivienda_id-14', true, to_date('03-05-2023','dd-mm-yyyy'), 39, 19, 24);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-2-vivienda_id-20', 'cuerpo_mensaje-2-vivienda_id-15', true, to_date('23-05-2023','dd-mm-yyyy'), 30, 20, 25);
-- Mensajes:
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-16', 'cuerpo_mensaje-1-vivienda_id-11', true, to_date('25-04-2023','dd-mm-yyyy'), 56, 16, 26);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-17', 'cuerpo_mensaje-1-vivienda_id-12', true, to_date('23-04-2023','dd-mm-yyyy'), 57, 17, 27);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-18', 'cuerpo_mensaje-1-vivienda_id-13', true, to_date('26-04-2023','dd-mm-yyyy'), 58, 18, 28);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-19', 'cuerpo_mensaje-1-vivienda_id-14', true, to_date('03-04-2023','dd-mm-yyyy'), 59, 19, 29);
insert into MENSAJE (mensaje_id, titulo, cuerpo, leido, fecha_envio, usuario_id, vivienda_id, mensaje_respuesta_id) values (mensaje_seq.nextval, 'titulo-1-vivienda_id-20', 'cuerpo_mensaje-1-vivienda_id-15', true, to_date('23-04-2023','dd-mm-yyyy'), 60, 20, 30);