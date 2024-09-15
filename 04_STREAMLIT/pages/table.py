import streamlit as st
import pandas as pd
from connect_data_warehouse import query_job_listings  

def layout():
    df = query_job_listings()  
    st.title("Greater Educational job ads")
    st.write("This dashboard displays educational ads sourced from Arbetsförmedlingen's API.")
    
    if df is not None:
        st.subheader("Table of job ads for higher education")
        st.dataframe(df)
        
    else:
        st.error("Ingen data hämtades från datalagret.")

if __name__ == "__main__":
    layout()