import streamlit as st


st.title(f'''Welcome to the greater educational dashboard!''')

st.subheader(''':rainbow[This is where you can find the job you always wanted.]''')
             
st.write('''The used data for this dashboard is collected from Arbetsförmedlingens API and is ingested into a Snowflake database using DLT as the EL in ETL process. DBT transforms it and puts it in a warehouse stage and mart stage. After that Streamlit reads the mart stage and you
         can enjoy the good end result!:balloon:''')