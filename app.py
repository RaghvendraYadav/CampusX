import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

st.set_page_config(layout='wide',page_title='StartUp Analysis')

df =pd.read_csv('startup_clean.csv')
df['date']=pd.to_datetime(df['date'],errors='coerce')
df['month']=df['date'].dt.month
df['year'] = df['date'].dt.year

def load_investor_details(investors):
    st.title(investors)
    #load the last 5 investment details of the investors
    last5_df=df[df['investors'].str.contains(investors)][['date','startup','vertical','city','round']].reset_index().head(5)
    st.subheader('Most Recent Investments')
    st.dataframe(last5_df)


    #Biggest  Investment

    col1,col2,col3=st.columns(3)
    with col1:
        big_series = df[df['investors'].str.contains(investors)].groupby('startup')['amount'].sum().sort_values(
            ascending=False).head()
        st.subheader('Biggest Investments')
        fig, ax = plt.subplots()
        ax.bar(big_series.index,big_series.values)
        st.pyplot(fig)
    with col2:
        vertical_series=df[df['investors'].str.contains(investors)].groupby('vertical')['amount'].sum()
        st.subheader('Sector Wise Investments')
        fig1,ax1=plt.subplots()
        ax1.pie(vertical_series,labels=vertical_series.index,autopct='%0.01f%%')
        st.pyplot(fig1)
    col3, col4= st.columns(2)
    with col3:
        stage_series = df[df['investors'].str.contains(investors)].groupby('round')['amount'].sum()
        st.subheader('Stage Wise Investments')
        fig2, ax2 = plt.subplots()
        ax2.pie(stage_series, labels=stage_series.index, autopct='%0.01f%%')
        st.pyplot(fig2)
    with col4:
        city_series = df[df['investors'].str.contains(investors)].groupby('city')['amount'].sum()
        st.subheader('City Wise Investments')
        fig3, ax3 = plt.subplots()
        ax3.pie(city_series, labels=city_series.index, autopct='%0.01f%%')
        st.pyplot(fig3)

    year_series=df[df['investors'].str.contains(investors)].groupby('year')['amount'].sum()
    st.subheader('YoY Investment')
    fig4,ax4=plt.subplots()
    ax4.plot(year_series.index,year_series.values)
    st.pyplot(fig4)
def load_overall_analysis():
    st.title('Overall Analysis')
    # totalinvestedamount
    total = round(df['amount'].sum())
    #max_funding infused in startup
    max_funding=df.groupby('startup')['amount'].max().sort_values(ascending=False).head(1).values[0]
    col1,col2,col3,col4=st.columns(4)
    #avg ticket size
    avg_funding=round(df.groupby('startup')['amount'].sum().mean())
    #totalfundnedstartup
    total_funded_startup=df['startup'].nunique()

    with col1:
        st.metric('Total', str(total) + '  Cr.')
    with col2:
        st.metric('Maximum Funding',str(max_funding)+' Cr.')
    with col3:
        st.metric('AverageFunding',str(avg_funding)+' Cr.')
    with col4:
        st.metric('Total Funded Starups',str(total_funded_startup))

    st.header('MoM Graph')
    sel_option=st.selectbox('Select Type',['Total','Count'])
    if sel_option == 'Total':
        temp_df=df.groupby(['year','month'])['amount'].sum().reset_index()
        temp_df['x_axis']=temp_df['month'].astype('str')+'-'+temp_df['year'].astype('str')

        fig5,ax5=plt.subplots()
        ax5.plot(temp_df['x_axis'],temp_df['amount'])
        st.pyplot(fig5)
    else:
        temp_df = df.groupby(['year', 'month'])['amount'].count().reset_index()
        temp_df['x_axis'] = temp_df['month'].astype('str') + '-' + temp_df['year'].astype('str')

        fig5, ax5 = plt.subplots()
        ax5.plot(temp_df['x_axis'], temp_df['amount'])
        st.pyplot(fig5)


st.sidebar.title('Startup Funding Analysis')
option=st.sidebar.selectbox('Select One',['OverAll Analysis','StartUp','Investor'])
if option == 'OverAll Analysis':
        load_overall_analysis()





elif option =='StartUp':

    st.sidebar.selectbox('Select Startup',sorted(df['startup'].unique().tolist()))
    btn1=st.sidebar.button('Find StartUp Details')
    st.title('StartUp Analysis')

else:
    selected_investor=st.sidebar.selectbox('Select Investor',sorted(set(df['investors'].str.split(',').sum())))
    btn2=st.sidebar.button('Find Investor Details')
    if btn2:
        load_investor_details(selected_investor)

    #st.title('Investor Analysis')
