import streamlit as st
from dbhelper import DB
import plotly.graph_objects as go
import plotly.express as px

db=DB()
st.sidebar.title('Flight Analytics')
user_options=st.sidebar.selectbox('Menu',['Select One','Check Flights','Flight Analytics','About Project'])
if user_options=='Check Flights':
    st.title('Checks Flights for your route')
    col1,col2=st.columns(2)
    city = db.fetch_city_names()
    with col1:
        source=st.selectbox('Select Source',sorted(city))
    with col2:
        destination=st.selectbox('Select Destination',sorted(city))
    if st.button('Search'):
        results=db.fetch_all_flights(source,destination)
        st.dataframe(results)

elif user_options=='Flight Analytics':
    st.title('Flight Analytics Dashboard')
    airline,freq=db.fetch_airline_freq()
    fig=go.Figure(
        go.Pie(
            labels=airline,
            values=freq,
            hoverinfo='label+percent',
            textinfo='value'
        )
        )
    st.header('Pie Chart')
    st.plotly_chart(fig)

    city, freq = db.busy_airport()

    fig=px.bar(
        x=city,
        y=freq
    )
    st.plotly_chart(fig,theme='streamlit',use_container_width=True)

    date,freq1=db.flights_per_day()
    fig=px.line(
        x=date,
        y=freq1
    )
    st.plotly_chart(fig, theme='streamlit', use_container_width=True)
elif user_options=='About Project':
    st.title('About the project')
else:
     pass
