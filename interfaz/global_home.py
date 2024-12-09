import streamlit as st
import pandas as pd
import oracledb

# Function to connect to Oracle DB
def connect() -> oracledb.Connection:
    dsn = oracledb.makedsn("d1-bd-lug.fi.unam", 1521, service_name="htblugbd_s2.fi.unam")
    username = "tu_proy_admin"
    password = "1234"

    try:
        connection = oracledb.connect(user=username, password=password, dsn=dsn)
        st.success("Connected to Oracle Database")
        return connection
    except oracledb.Error as e:
        st.error(f"Connection failed: {e}")
        return None

# Function to execute a query and return results as a DataFrame
def run_query(query):
    conn = connect()
    if conn is None:
        return "Failed to connect to the database."
    
    try:
        cursor = conn.cursor()
        cursor.execute(query)
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
        
        # Convert LOBs to strings if necessary
        modified_rows = []
        for row in rows:
            modified_row = []
            for value in row:
                if isinstance(value, oracledb.LOB):
                    modified_row.append(value.read().decode('utf-8'))  # Adjust encoding as needed
                else:
                    modified_row.append(value)
            modified_rows.append(modified_row)

        df = pd.DataFrame(modified_rows, columns=columns)
        return df
    except Exception as e:
        return f"Error executing query: {e}"
    finally:
        if conn:
            conn.close()

def execute_resumen_viviendas(p_usuario_duenio_id):
    conn = connect()
    if conn is None:
        return "Failed to connect to the database."
    
    try:
        cursor = conn.cursor()
        # Use an anonymous PL/SQL block to execute the procedure
        plsql_block = f"""
        BEGIN
            p_resumen_viviendas({p_usuario_duenio_id});
        END;
        """
        cursor.execute(plsql_block)
        conn.commit()  # Commit any changes if necessary
        return "Procedure executed successfully. Check the output in the database logs."
    except Exception as e:
        return f"Error executing procedure: {e}"
    finally:
        if conn:
            conn.close()



# Streamlit app configuration
st.set_page_config(
    page_title="Global-Home",
    layout="wide",
)

# Main App
st.title("Global-Home")
st.sidebar.title("Navigation")
section = st.sidebar.radio("Go to", ["Home", "Viviendas disponibles", "Resumen de viviendas", "Consultas SQL"])

# Home Section
if section == "Home":
    st.header("Welcome to Global-Home")
    st.write("This is a Streamlit app to showcase the integration of Oracle Database with Streamlit.")
elif section == "Viviendas disponibles":
    st.header("Viviendas disponibles")
    
    result = run_query("SELECT * from v_vivienda_disponible")
    st.dataframe(result)  # Display results in a table
elif section == "Resumen de viviendas":
    st.header("Resumen de viviendas")

    # Input for user ID
    p_usuario_duenio_id = st.number_input("Ingresa el usuario dueño", min_value=1, step=1)

    if st.button("Execute Procedure", key="execute_proc"):
        if p_usuario_duenio_id:
            result = execute_resumen_viviendas(p_usuario_duenio_id)
            st.write(result)
            with open("/unam/bd/proyecto/GLOBAL-HOME/interfaz/ultimo_resumen.txt", "r") as file:
                st.text(file.read())
        else:
            st.warning("Please enter a valid user ID.")
elif section == "Consultas SQL":
    st.header("Consultas SQL")

    # Input box for SQL query
    query = st.text_area("Ingresa una consulta SQL")

    if st.button("Run Query", key="query_button"):
        if query.strip() == "":
            st.warning("Please enter a SQL query.")
        else:
            # Run the query and display results
            result = run_query(query)
            if isinstance(result, pd.DataFrame):
                if result.empty:
                    st.info("Query executed successfully, but no results returned.")
                else:
                    st.dataframe(result)  # Display results in a table
            else:
                st.error(f"Error: {result}")