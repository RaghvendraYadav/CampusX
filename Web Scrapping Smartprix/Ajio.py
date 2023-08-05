#import webdriver
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
import time

#Path provide of chrome driver to Service
s=Service('C://Users/dell/Desktop/chromedriver.exe')

#Chrome m service ko bhejna
driver=webdriver.Chrome(service=s)

#give url of backbacks from Ajio website

driver.get('https://www.ajio.com/men-backpacks/c/830201001')
time.sleep(3)
#scroll till the end of the dynamic page
old_height=driver.execute_script('return document.body.scrollHeight')
counter=1
while True:
    driver.execute_script('window.scrollTo(0,document.body.scrollHeight)')
    time.sleep(3)
    new_height=driver.execute_script(('return document.body.scrollHeight'))
    print(counter)
    counter+=1
    print('old_height is : ',old_height)
    print('new_height is : ',new_height)
    if new_height == old_height:
        break

    old_height=new_height

time.sleep(10)
html=driver.page_source
with open('ajio.html','w',encoding='utf-8') as f:
    f.write(html)
