-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 07/12/2024
--Descripción: Pruebas para procedimiento que calcula la renta total de una vivienda

set serveroutput on;
declare
    v_ganancia_total_rentas number;
begin

    -- Caso 1: Se calcula la ganancia total de rentas para un usuario que no tiene rentas
    begin
        dbms_output.put_line('Caso 1: Se calcula la ganancia total de rentas para un usuario que no tiene rentas');
        p_calcular_ganancia_total_rentas(v_ganancia_total_rentas, 1);
        dbms_output.put_line('Ganancia total rentas para usuario 1: ' || v_ganancia_total_rentas);
        if v_ganancia_total_rentas != 0 then
            dbms_output.put_line('Error: Se esperaba 0 como ganancia total de rentas para el usuario 1');
        end if;
    exception
        when others then
            if sqlcode = -20100 then
                dbms_output.put_line('No se encontraron rentas para el usuario 1');
            else
                dbms_output.put_line('ERROR: al calcular la ganancia total de rentas para el usuario 1: ' || sqlerrm);
            end if;

    end;
    -- Caso 2: Para un usuario que tiene rentas activas
    begin
        dbms_output.put_line('Caso 2: Para un usuario que tiene solo rentas activas');
        p_calcular_ganancia_total_rentas(v_ganancia_total_rentas, 20);
        dbms_output.put_line('Ganancia total rentas para usuario 20: ' || v_ganancia_total_rentas);
        if v_ganancia_total_rentas = 0 then
            dbms_output.put_line('Error: Se esperaba 0 como ganancia total de rentas para el usuario 2');
        end if;
    exception
        when others then
            if sqlcode = -20100 then
                dbms_output.put_line('No se encontraron rentas para el usuario 20');
            else
                dbms_output.put_line('ERROR: al calcular la ganancia total de rentas para el usuario 20: ' || sqlerrm);
            end if;
    end;

    -- Caso 3: Usuario con solo rentas anteriores
    begin
        dbms_output.put_line('Caso 3: Usuario con solo rentas anteriores');
        p_calcular_ganancia_total_rentas(v_ganancia_total_rentas, 37);
        dbms_output.put_line('Ganancia total rentas para usuario 37: ' || v_ganancia_total_rentas);
        if v_ganancia_total_rentas = 0 then
            dbms_output.put_line('Error: Se esperaba 0 como ganancia total de rentas para el usuario 3');
        end if;
    exception
        when others then
            if sqlcode = -20100 then
                dbms_output.put_line('No se encontraron rentas para el usuario 37');
            else
                dbms_output.put_line('ERROR: al calcular la ganancia total de rentas para el usuario 37: ' || sqlerrm);
            end if;
    end;

    -- Caso 4: Usuario con rentas anteriores y activas
    begin
        dbms_output.put_line('Caso 4: Usuario con rentas anteriores y activas');
        p_calcular_ganancia_total_rentas(v_ganancia_total_rentas, 40);
        dbms_output.put_line('Ganancia total rentas para usuario 40: ' || v_ganancia_total_rentas);
        if v_ganancia_total_rentas = 0 then
            dbms_output.put_line('Error: Se esperaba 0 como ganancia total de rentas para el usuario 4');
        end if;
    exception
        when others then
            if sqlcode = -20100 then
                dbms_output.put_line('No se encontraron rentas para el usuario 40');
            else
                dbms_output.put_line('ERROR: al calcular la ganancia total de rentas para el usuario 40: ' || sqlerrm);
            end if;
    end;

    -- Caso 5: Usuario inexistente
    begin
        dbms_output.put_line('Caso 5: Usuario inexistente');
        p_calcular_ganancia_total_rentas(v_ganancia_total_rentas, 999);
        dbms_output.put_line('Ganancia total rentas para usuario 999 (ERROR): ' || v_ganancia_total_rentas);
    exception
        when others then
            if sqlcode = -20400 then
                dbms_output.put_line('Error esperado al calcular la ganancia total de rentas' || chr(10) || sqlerrm);
            else
                dbms_output.put_line('ERROR: al calcular la ganancia total de rentas para el usuario 999: ' || sqlerrm);
            end if;
    end;
end;
/