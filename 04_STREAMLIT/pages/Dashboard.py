import streamlit as st
import pandas as pd
import numpy as np
from geopy.geocoders import Nominatim
import time
from connect_data_warehouse import query_job_listings  

geolocator = Nominatim(user_agent="Dashboard")
def get_coordinates(city_name):
    time.sleep(1) 
    location = geolocator.geocode(city_name)
    if location:
        return location.latitude, location.longitude
    else:
        return None, None

def layout():

    # barlong fly out
    st.balloons() 
    df = query_job_listings()  
    st.title("Greater Educational Job Ads")
    st.write('''This dashboard displays educational ads sourced from Arbetsförmedlingen's API.:hibiscus:''')

    # Den visar totala vacanies
    st.header("Vacancies")  
    cols_0 = st.columns(4)
    with cols_0[0]:
        st.metric(label="Total", value=df["VACANCIES"].sum())  

    with cols_0[1]:
        st.metric(label="Stockholm", value=df.query("WORKPLACE_CITY == 'Stockholm'")['VACANCIES'].sum())  

    with cols_0[2]:
        st.metric(label="Göteborg", value=df.query("WORKPLACE_CITY == 'Göteborg'")['VACANCIES'].sum())  

    with cols_0[3]:
        st.metric(label="Malmö", value=df.query("WORKPLACE_CITY == 'Malmö'")['VACANCIES'].sum())  

    st.subheader("Employers with most vacancies")
    chart_data = query_job_listings(
        """
            SELECT 
                SUM(vacancies) as vacancies,
                employer_name as EMPLOYER_NAME
            FROM 
                mart_job_listings
            GROUP BY 
                employer_name
            ORDER BY vacancies DESC LIMIT 5;
        """
    )
    st.bar_chart(chart_data, x="EMPLOYER_NAME", y="VACANCIES")  

    with st.expander("See explanation"):  
        st.write("The chart above shows which region has the top 5 most vacancies for roles with higher education.")
        st.image("https://as2.ftcdn.net/v2/jpg/04/98/17/05/1000_F_498170577_QlUqnkLW7vb4Ho5XmjgVTL6J1bMfBw8a.jpg")
    
    st.title("Find an advertisement")
    selected_region = st.selectbox("Select a region:", df["WORKPLACE_CITY"].unique())
    
    # Här visar total jobb när användare väljer stad
    city_vacancies = df.query(f"WORKPLACE_CITY == '{selected_region}'")["VACANCIES"].sum()
    st.metric(label=f"Total jobs in {selected_region}", value=city_vacancies)

    lat, lon = get_coordinates(selected_region)  

    if lat and lon:
        st.map(pd.DataFrame([{"lat": lat, "lon": lon}]))  
    else:
        st.write("No location data available for the selected region.")

    cols_1 = st.columns(2)
    with cols_1[0]:
        
        selected_company = st.selectbox("Select an employer:", df.query(f"WORKPLACE_CITY == '{selected_region}'")["EMPLOYER_NAME"].unique())
    
    with cols_1[1]:
        
        selected_headline = st.selectbox("Select an advertisement:", df.query(f"EMPLOYER_NAME == '{selected_company}'")["HEADLINE"])

    ad_details_query = df.query(f"EMPLOYER_NAME == '{selected_company}' and HEADLINE == '{selected_headline}'")["DESCRIPTION_HTML_FORMATTED"]
    if not ad_details_query.empty:
        ad_details = ad_details_query.values[0]  
        st.header(selected_headline)
        st.markdown(ad_details, unsafe_allow_html=True)  
    else:
        st.write("No details available for the selected advertisement.")  

if __name__ == "__main__":
    layout()
