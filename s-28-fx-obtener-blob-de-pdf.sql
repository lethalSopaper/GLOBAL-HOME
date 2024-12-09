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
    -- Validar que la ruta del archivo no sea nula
    if p_ruta_archivo is null then
        dbms_output.put_line('La ruta del archivo no puede ser nula');

        raise_application_error(-20001, 'La ruta del archivo no puede ser nula');
    end if;

    -- Intentar abrir el archivo
    begin
        v_archivo_bf := bfilename('PDF_CONTRATO', p_ruta_archivo);
        -- Verificar si el archivo existe antes de intentar abrirlo
        if dbms_lob.fileexists(v_archivo_bf) = 0 then
            raise_application_error(-20002, 'El archivo no existe en la ruta especificada: ' || p_ruta_archivo);
        end if;
        dbms_lob.fileopen(v_archivo_bf, dbms_lob.file_readonly);
        if dbms_lob.getlength(v_archivo_bf) = 0 then
            raise_application_error(-20002, 'El archivo está vacío: ' || p_ruta_archivo);
        end if;
    exception
        when others then
            -- Propagar el error original sin perder el código y el mensaje
            raise_application_error(-20002, 'No se pudo abrir el archivo: ' || p_ruta_archivo || ' Error: ' || sqlerrm);
    end;

    begin
        -- Crear un objeto BLOB temporal para almacenar el contenido del archivo
        dbms_lob.createtemporary(v_archivo_blob, true);

        -- Copiar el contenido del archivo BFILE al BLOB
        dbms_lob.loadfromfile(v_archivo_blob, v_archivo_bf, dbms_lob.getlength(v_archivo_bf));

        -- Cerrar el archivo BFILE
        dbms_lob.fileclose(v_archivo_bf);

    exception
        when others then
            -- Asegurarse de cerrar el archivo y liberar el BLOB en caso de error
            if dbms_lob.fileisopen(v_archivo_bf) = 1 then
                dbms_lob.fileclose(v_archivo_bf);
            end if;
            if dbms_lob.isopen(v_archivo_blob) = 1 then
                dbms_lob.freetemporary(v_archivo_blob);
            end if;
            -- Propagar la excepción original con su mensaje
            raise_application_error(-20099, 'Error en la función obtener_blob_de_pdf: ' || sqlerrm);
    end;
    -- Retornar el BLOB con el contenido del archivo
    return v_archivo_blob;


end;
/
show errors;