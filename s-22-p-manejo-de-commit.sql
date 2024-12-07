-- Autor: Tepal Briseño Hansel Yael y Ugartechea González Luis Antonio
--Fecha: 05/12/2024
--Descripción: Manejo de commit
--Este procedimienot se realiza un commit en la base de datos, tenerle en cuanta antes de ejecutar.
create or replace procedure p_manejo_de_commit as

begin
    p_insercion_de_logs;
    DBMS_OUTPUT.PUT_LINE('Se ha realizado un commit');
    commit;
end;
/
show errors;