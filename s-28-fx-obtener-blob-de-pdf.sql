-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- fecha: 06/12/2024
-- Descripción: Funcion que lee el binario de un pdf y lo convierte a un objeto blob

/* Cuando se almacena un documento PDF (como en el caso de las escrituras de propiedad o contratos de renta), 
puedes necesitar una función para leer el archivo binario desde el disco y devolverlo como un objeto BLOB que pueda 
ser insertado en una tabla. */

create or replace function obtener_blob_de_pdf(
    p_ruta_archivo varchar
) return blob 
is
    v_archivo_bf bfile;
    v_archivo_blob blob;
begin
    -- Crear un objeto BFILE para leer el archivo
    v_archivo_bf := bfilename('pdf_contrato', p_ruta_archivo);
    
    -- Abrir el archivo
    dbms_lob.fileopen(v_archivo_bf, dbms_lob.file_readonly);
    
    -- Crear un objeto BLOB para almacenar el contenido del archivo
    dbms_lob.createtemporary(v_archivo_blob, true);
    
    -- Copiar el contenido del archivo BFILE al BLOB
    dbms_lob.loadfromfile(v_archivo_blob, v_archivo_bf, dbms_lob.getlength(v_archivo_bf));
    
    -- Cerrar el archivo
    dbms_lob.fileclose(v_archivo_bf);
    
    return v_archivo_blob;
end;
/