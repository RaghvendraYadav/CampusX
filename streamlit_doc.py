import streamlit as st
import pandas as pd
import time
st.title('Startup Dashboard')
st.header('I am learning Streamlit')
st.subheader('And I am loving it!')
st.write('Normal Code')
st.markdown("""
### My Favourite Movie
- Race 3
- Humshkals
- Housefull 
""")
st.code("""
def foo(input):
    return foo**2
x=foo(2)
""")
st.latex('x^2 + y^2 = 0')
## Display Elements
df=pd.DataFrame({
    'name':['Raghvendra','Madhav','Monu'],
    'Age':[25,3,27],
    'package':[10,2,20]
})
st.dataframe(df)
#Metrics
st.metric('Infosys','Rs 3000000 Cr.','3%')
#Json
st.json({
    'name':['Raghvendra','Madhav','Monu'],
    'Age':[25,3,27],
    'package':[10,2,20]
})
#Display Images & Video
st.image('DSC_0021.JPG')
st.video('VID-1.mp4')

# Creating Layouts
st.sidebar.title('Sidebar k title')
#columns - ek row m mutliple cheezein
col1,col2,col3=st.columns(3)

with col1:
    st.image('DSC_0021.jpg')
with col2:
    st.image('DSC_0021.jpg')
with col3:
    st.image('DSC_0021.jpg')
st.error('Login Unsuccessful')
st.success('Loigin successful')
st.warning('Warning!')
st.info('Basic Information')
bar=st.progress(0)
for i in range(0,50):
    time.sleep(0.1)
    bar.progress(i)
email=st.text_input('Enter Email Address')
number=st.number_input('Enter the Numeric Value')
date=st.date_input('Enter the Date')


email=st.text_input('Enter Email')
password=st.text_input('Enter Password',type='password')
#drop down
gender=st.selectbox('Select Genter',['Male','Female','Others'])

btn=st.button('Login Kkaro')
#id button is clicked
if btn:
    if email== 'nitish@gmail.com' and password=='1234':
        st.success('Login Successful')
        st.write(gender)
        st.balloons()

    else:
        st.error('Login  Failed')
file=st.file_uploader('Upload a csv File')

if file is not None:
    df=pd.read_csv(file)
    st.dataframe(df)
password=st.text_input('Enter Password',type='password')
