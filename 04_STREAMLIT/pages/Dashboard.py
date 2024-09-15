import streamlit as st
import pandas as pd
import numpy as np
from connect_data_warehouse import query_job_listings  
import pandasql as ps

def layout():

    @st.fragment
    def release_the_balloons():
        st.balloons()
    release_the_balloons()
    
    df = query_job_listings()  
    st.title("Greater Educational job ads")
    st.write('''This dashboard displays educational ads sourced from Arbetsförmedlingen's API.:hibiscus:''')
    

    st.header("Vacancies")  
    cols_0 = st.columns(4)
    with cols_0[0]:
        st.metric(label= "Total", value=df["VACANCIES"].sum())

    with cols_0[1]:
        st.metric(label= "Stockholm",
        value=df.query("WORKPLACE_CITY == 'Stockholm'")['VACANCIES'].sum())


    with cols_0[2]:
        st.metric(label= "Göteborg",
        value=df.query("WORKPLACE_CITY == 'Göteborg'")['VACANCIES'].sum())
    
    with cols_0[3]:
        st.metric(label= "Malmö",
        value=df.query("WORKPLACE_CITY == 'Malmö'")['VACANCIES'].sum())

        

    
    
    # Display the bar chart with the result
    st.subheader("Employers with most vacancies")
    st.bar_chart(
        query_job_listings(
            """
                SELECT 
                    SUM(vacancies) as vacancies,
                    employer_name
                FROM 
                    mart_job_listings
                GROUP BY 
                    employer_name
                ORDER BY vacancies DESC LIMIT 5;
                """
        ),
        x="EMPLOYER_NAME",
        y="VACANCIES",
    )
    
    with st.expander("See explanation"):
        st.write('''
                The chart above shows which region has the top 5 most vacencies for roles with higher education. 
            ''')
        st.image("https://as2.ftcdn.net/v2/jpg/04/98/17/05/1000_F_498170577_QlUqnkLW7vb4Ho5XmjgVTL6J1bMfBw8a.jpg")
    

    st.title("Find a advertisment")
    selected_region = st.selectbox("Select a region:", df["WORKPLACE_CITY"].unique())
    cols_1 = st.columns(2)
    with cols_1[0]:
        selected_company = st.selectbox("Select a employer:", df.query("WORKPLACE_CITY == @selected_region")["EMPLOYER_NAME"].unique())
    
    with cols_1[1]:
        selected_headline = st.selectbox("Select a advertisement:", df.query("EMPLOYER_NAME == @selected_company")["HEADLINE"],
                                         )
    
    st.header(selected_headline)    
    st.markdown(
        df.query("EMPLOYER_NAME == @selected_company and HEADLINE == @selected_headline")["DESCRIPTION_HTML_FORMATTED"].values[0], unsafe_allow_html=True,
    )

    # x = df['WORKPLACE_CITY'].value_counts()
    # y = df['APPLICATION_DEADLINE']
    # chart_data = pd.DataFrame(data=None, x=x, y=y, columns=["a", "b", "c"])
    # st.subheader("Chart name")
    # st.line_chart(chart_data)
    # with st.expander("See explanation"):
    #         st.write('''
    #                 The chart above shows some numbers I picked for you.
    #                 I rolled actual dice for these, so they're *guaranteed* to
    #                 be random.
    #             ''')
    #         st.image("https://static.streamlit.io/examples/dice.jpg")


if __name__ == "__main__":
    layout()
