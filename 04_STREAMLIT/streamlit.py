import streamlit as st
from connect_data_warehouse import query_job_listings  

def layout():
    df = query_job_listings()  
    st.title("Greater Educational job ads")
    st.write("This dashboard displays educational ads sourced from Arbetsförmedlingen's API.")
    
    if df is not None:
        st.subheader("Jobbannonser")
        st.dataframe(df)

        if 'WORKPLACE_CITY' in df.columns:
            city_counts = df['WORKPLACE_CITY'].value_counts()
            st.subheader("Jobbannonser per Ort")
            st.bar_chart(city_counts)
        else:
            st.error("Datan har ingen 'location'-kolumn för att visa antal jobbannonser per ort.")
    else:
        st.error("Ingen data hämtades från datalagret.")

if __name__ == "__main__":
    layout()
