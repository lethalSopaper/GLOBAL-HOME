-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
-- Fecha: 06/12/2024
-- Descripción: Pruebas unitarias para la función obtener_blob_de_pdf

set serveroutput on

declare
    v_blob_from_tmp blob;            -- Variable BLOB temporal para almacenar el contenido leído desde el archivo en disco.
    v_blob blob;                     -- Variable BLOB para almacenar el contenido del PDF obtenido de la base de datos.
    v_archivo varchar(100);          -- Variable de cadena de caracteres para el nombre del archivo.
    v_file_from_disk bfile;          -- Variable BFILE para referenciar el archivo en el sistema de archivos.
    v_length number;                 -- Variable para almacenar la longitud del archivo.
    v_offset integer := 1;           -- Offset inicial para leer el archivo (comienza en 1).
    v_buffer raw(2000);              -- Buffer para leer el contenido del archivo en bloques de tamaño 2000 bytes.
    v_chunk_size integer := 2000;    -- Tamaño del bloque para leer y escribir (2000 bytes).
begin

    -- Caso 1: Ruta de archivo válida
    begin
        dbms_output.put_line('Caso 1: Ruta de archivo válida');
        v_blob := obtener_blob_de_pdf('bd-08-htb-practica-14.pdf');
        dbms_output.put_line('Exito: Se obtuvo el BLOB del archivo');
    exception
        when others then
            dbms_output.put_line('Error: ' || sqlerrm);
    end;

    -- Caso 2: Ruta de archivo no existente
    begin
        dbms_output.put_line('Caso 2: Ruta de archivo no existente');
        v_blob := obtener_blob_de_pdf('archivo_no_existente.pdf');
        dbms_output.put_line('Error: Se esperaba una excepción');
    exception
        when others then
            if sqlcode = -20002 then
                dbms_output.put_line('Exito: Se generó la excepción esperada');
            else
                dbms_output.put_line('Error: ' || sqlerrm);
            end if;
    end;
    begin
        dbms_output.put_line('Caso 3: Ruta de archivo nula');
        v_blob := obtener_blob_de_pdf(null);
        dbms_output.put_line('Error: Se esperaba una excepción');
    exception
        when others then
            if sqlcode = -20001 then
                dbms_output.put_line('Exito: Se generó la excepción esperada');
            else
                dbms_output.put_line('Error: ' || sqlerrm);
            end if;
    end;
    begin
        dbms_output.put_line('Caso 4: Archivo PDF vacío');
        v_blob := obtener_blob_de_pdf('archivo_vacio.pdf');
        dbms_output.put_line('Error: Se esperaba una excepción');
    exception
        when others then
            if sqlcode = -20002 then
                dbms_output.put_line('Exito: Se generó la excepción esperada');
            else
                dbms_output.put_line('Error: ' || sqlerrm);
            end if;
    end;

    begin
        dbms_output.put_line('Caso 5: prueba de rendimiento con multiples archivos');
        for i in 1..5 loop
            v_archivo := 'archivo' || i || '.pdf';
            v_blob := obtener_blob_de_pdf(v_archivo);
            dbms_output.put_line('Exito: Se obtuvo el BLOB'|| i || ' del archivo ' || v_archivo);
        end loop;
    end;

    begin
        -- Este caso tiene la finalidad de probar la integridad de los datos
        dbms_output.put_line('Caso 7: prueba de integridad de datos');
         -- Asigna el BLOB del PDF obtenido de la base de datos a la variable `v_blob`.
        v_blob := obtener_blob_de_pdf('bd-08-htb-practica-14.pdf');    
        -- Crea un BLOB temporal `v_blob_from_tmp` que será utilizado para almacenar el contenido del archivo en disco.
            dbms_lob.createtemporary(v_blob_from_tmp, true);                
            -- Asigna la referencia al archivo en el sistema de archivos a `v_file_from_disk`.
            v_file_from_disk := bfilename('PDF_CONTRATO', 'bd-08-htb-practica-14.pdf');  
            -- Abre el archivo en modo solo lectura.
            dbms_lob.fileopen(v_file_from_disk, dbms_lob.file_readonly);                 
             -- Obtiene la longitud del archivo y la almacena en `v_length`. 
            v_length := dbms_lob.getlength(v_file_from_disk);                            
            -- Bucle para leer el archivo en bloques de 2000 bytes y escribir en el BLOB temporal.
            while v_offset <= v_length loop
             -- Lee un bloque de 2000 bytes desde el archivo en `v_buffer`.
                dbms_lob.read(v_file_from_disk, v_chunk_size, v_offset, v_buffer);       
                 -- Escribe el bloque leído en el BLOB temporal `v_blob_from_tmp`.
                dbms_lob.writeappend(v_blob_from_tmp, v_chunk_size, v_buffer);          
                  -- Incrementa el offset en el tamaño del bloque después de cada iteración. 
                v_offset := v_offset + v_chunk_size;                                    
            end loop;
              -- Cierra el archivo.
            dbms_lob.fileclose(v_file_from_disk);                                      

            -- Compara los BLOBs y verifica si son iguales.
            if dbms_lob.compare(v_blob, v_blob_from_tmp) = 0 then
                dbms_output.put_line('Exito: Los BLOBs son iguales');                   
            else
                dbms_output.put_line('Error: Los BLOBs no son iguales');                 
            end if;

            -- Manejo de excepciones para capturar cualquier error durante la ejecución.
            exception
                when others then
                    dbms_output.put_line('Error: ' || sqlerrm);                          
    end;
end;
/
