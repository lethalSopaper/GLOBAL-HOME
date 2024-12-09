-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 05/12/2024
-- Descripción: Archivo main para crear objetos

whenever sqlerror exit sql.sqlcode rollback

prompt llamando al script s-01-usuarios.sql

start s-01-usuarios.sql

prompt llamando al script s-02-entidades.sql

start s-02-entidades.sql

prompt llamando al script s-03-tablas-temporales.sql

start s-03-tablas-temporales.sql

prompt llamando al script s-04-tablas-externas.sql

start s-04-tablas-externas.sql

prompt llamando al script s-05-secuencias.sql

start s-05-secuencias.sql

prompt llamando al script s-06-indices.sql

start s-06-indices.sql

prompt llamando al script s-07-sinonimos.sql

start s-07-sinonimos.sql

prompt llamando al script s-08-vistas.sql

start s-08-vistas.sql

--Carga inicial
prompt llamando al script s-09-carga-inicial.sql

start s-09-carga-inicial.sql

prompt llamando al script s-24-fx-calcular-total-alquiler.sql

start s-24-fx-calcular-total-alquiler.sql

prompt llamando al script s-26-fx-calcular-folio-alquiler.sql

start s-26-fx-calcular-folio-alquiler.sql

prompt llamando al script s-28-fx-obtener-blob-de-pdf.sql

start s-28-fx-obtener-blob-de-pdf.sql

prompt llamando al script s-11-tr-validacion-vivienda.sql

start s-11-tr-validacion-vivienda.sql

prompt llamando al scrip s-13-tr-validacion-alquiler.sql

start s-13-tr-validacion-alquiler.sql

prompt llamando al script s-15-p-insercion-de-logs.s

start s-15-p-insercion-de-logs.sql

prompt s-18-insercion-mensaje-respuesta.sql

start s-18-p-insercion-mensaje-respuesta.sql

prompt llamando al script s-20-p-calcular-ganancia-total-rentas.sql

start s-20-p-calcular-ganancia-total-rentas.sql

prompt llamando al script s-22-p-resumen-vivienda-duenios.sql

start s-22-p-resumen-vivienda-duenios.sql