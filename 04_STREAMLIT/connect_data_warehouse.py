import os
from dotenv import load_dotenv
import streamlit as st
import pandas as pd
from snowflake.connector import connect  






def query_job_listings(query = "SELECT * FROM mart_job_listings"):
    load_dotenv()
    try:
        with connect(
            user=os.getenv("SNOWFLAKE_USER"),
            password=os.getenv("SNOWFLAKE_PASSWORD"),
            account=os.getenv("SNOWFLAKE_ACCOUNT"),
            warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
            database=os.getenv("SNOWFLAKE_DATABASE"),
            schema=os.getenv("SNOWFLAKE_SCHEMA"),
            role=os.getenv("SNOWFLAKE_ROLE"),
        ) as conn:
            df = pd.read_sql(query, conn)
        return df
    
    except Exception as e:
        st.error(f"Ett fel uppstod vid anslutningen till Snowflake: {e}")
        return None

print(query_job_listings())


# st.title("Jobbannonser Statistik - Arbetskollen")

# try:
    
#     df = query_job_listings(query)

#     if df is not None:
       
#         st.subheader("Jobbannonser")
#         st.dataframe(df)

        
#         st.subheader("Antal annonser per ort")
#         city_counts = df['location'].value_counts()
#         st.bar_chart(city_counts)
#     else:
#         st.error("Ingen data kunde hämtas.")

# except Exception as e:
#     st.error(f"Ett oväntat fel uppstod: {e}")

