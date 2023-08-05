#open google.com
#search campusx
#learnwithcampusx
#join the program click hojayega or dsmp program prr chle jayenge
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

s = Service("C://Users/dell/Desktop/chromedriver.exe")
driver=webdriver.Chrome(service=s)
#Go to google
driver.get('http://www.google.com')
time.sleep(3)

#fetch the search input box using xpath
user_input = driver.find_element(by=By.XPATH,value='/html/body/div[1]/div[3]/form/div[1]/div[1]/div[1]/div/div[2]/textarea')
user_input.send_keys('Campusx')

time.sleep(3)
user_input.send_keys(Keys.ENTER)
time.sleep(3)
link = driver.find_element(by=By.XPATH,value='//*[@id="rso"]/div[1]/div/div/div[1]/div/a')
link.click()
time.sleep(3)
link1=driver.find_element(by=By.XPATH,value='//*[@id="1668425005116"]/span[2]/a')
link1.click()
time.sleep(10)