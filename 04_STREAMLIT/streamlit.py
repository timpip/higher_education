import streamlit as st
from connect_data_warehouse import query_job_listings  

def layout():
    df = query_job_listings()  
    st.title("Higher Education job ads")
    st.write("Denna dashboard visar jobbannonser för data engineering från Arbetsförmedlingens API")
    
    if df is not None:
        st.subheader("Jobbannonser")
        st.dataframe(df)

        if 'location' in df.columns:
            city_counts = df['location'].value_counts()
            st.subheader("Jobbannonser per Ort")
            st.bar_chart(city_counts)
        else:
            st.error("Datan har ingen 'location'-kolumn för att visa antal jobbannonser per ort.")
    else:
        st.error("Ingen data hämtades från datalagret.")

if __name__ == "__main__":
    layout()
