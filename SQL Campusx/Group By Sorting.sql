SELECT * FROM campusx.smartphones;
#Find top 5 samsung phones with biggest screen size  (ORDER BY &LIMIT) 
SELECT model,screen_size FROM smartphone WHERE brand_name='samsung' ORDER BY screen_size DESC LIMIT 5;
#Sort all the phones with no of camera in desc order 
SELECT model,num_front_cameras + num_rear_cameras AS 'total_cameras' FROM smartphone ORDER BY total_cameras DESC;
#Sort DATA  on the BASIS Of PPI
SELECT model,
(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size) AS ppi
FROM  campusx.smartphone 
ORDER BY ppi ASC;

#FIND THE PHONE WITH 2 Highest BATTERY LIMIT 10,2 (10th ROW se 2 row print krana h )
SELECT model,battery_capacity FROM campusx.smartphone ORDER BY battery_capacity desc LIMIT 1,1;


#FIND THE PHONE WITH 5 Highest BATTERY LIMIT 10,2 (10th ROW se 2 row print krana h )
SELECT model,battery_capacity FROM campusx.smartphone ORDER BY battery_capacity desc LIMIT 4,1;

SELECT model,battery_capacity FROM campusx.smartphone ORDER BY battery_capacity DESC LIMIT 3,2;

#FIND THE PHONE WITH 2 Lowest BATTERY LIMIT 10,2 (10th ROW se 2 row print krana h )
SELECT model,battery_capacity FROM campusx.smartphone ORDER BY battery_capacity ASC LIMIT 1,1;

#Find the name  and rating of the worst rated apple phone 
SELECT model,rating FROM campusx.smartphone
WHERE brand_name='apple' 
ORDER BY rating LIMIT 1;

# 2 COLUMN BASED SORTING BASED On BRAND_Name , PRice 
SELECT * from campusx.smartphone 
ORDER BY brand_name ASC,price ASC;

# 2 COLUMN BASED SORTING BASED On brand_name , rating 
SELECT * from campusx.smartphone 
ORDER BY brand_name ASC,rating DESC;

## GROUPING DATA 
#brand_name and noofphones btana h 
SELECT brand_name,count(model)  AS 'total phones' FROM campusx.smartphone
GROUP BY brand_name;
 
# Groupby smartphones By brand anf get the count ,average price ,max rating ,avg screensize and avg battery capacity 
SELECT brand_name,COUNT(model)  AS 'total_phones' ,
round(avg(price)) as 'average price',
max(rating) AS 'max rating',
round(avg(screen_size)) AS 'avg screen size',
round(avg(battery_capacity)) AS 'avg battery capacity'
FROM campusx.smartphone
GROUP BY brand_name
ORDER BY total_phones DESC; 

SELECT brand_name,COUNT(model)  AS 'total_phones' ,
round(avg(price)) as 'average price',
max(rating) AS 'max rating',
round(avg(screen_size),2) AS 'avg screen size',
round(avg(battery_capacity)) AS 'avg battery capacity'
FROM campusx.smartphone
GROUP BY brand_name
ORDER BY total_phones DESC LIMIT 15; 

#Group Smartphonw whether they have NFC  andget average price and rating 
SELECT has_nfc,
round(avg(price)) AS 'average_price' ,
round(avg(rating),2) AS 'average _rating' FROM campusx.smartphone 
GROUP BY has_nfc ;

#Group Smartphonw whether they have 5g  andget average price and rating 
SELECT has_5g,
round(avg(price)) AS 'average_price' ,
round(avg(rating),2) AS 'average _rating' FROM campusx.smartphone 
GROUP BY has_5g;
 
#Group Smartphonw whether they have Fast Charging   andget average price and rating 
SELECT fast_charging_available,
round(avg(price)) AS 'average_price' ,
round(avg(rating),2) AS 'average _rating' FROM campusx.smartphone 
GROUP BY fast_charging_available; 
 
 
 #Group Smartphone whether they have Extended Memory Availablee  andget average price and rating 
SELECT extended_memory_available,
round(avg(price)) AS 'average_price' ,
round(avg(rating),2) AS 'average _rating' FROM campusx.smartphone 
GROUP BY extended_memory_available; 

#TWO COLUMNS GROUP BY 

#Group smartphones by band and processor brand and get the count of models and average 
#primary camera resolution 

SELECT  brand_name,processor_brand,COUNT(*) AS 'num_phones',ROUND(AVG(primary_camera_rear)) AS 'avg_camera_resolution'
FROM campusx.smartphone
GROUP BY brand_name,processor_brand;

#Find TOP 5 COstly brand 
SELECT brand_name,ROUND(AVG(price),2) AS 'avg_price' FROM campusx.smartphone
GROUP BY brand_name  ORDER BY avg_price DESC LIMIT 5;

#Which Brand make the smallest screen_size smartphone
SELECT brand_name,ROUND(AVG(screen_size)) AS 'avg_screen_size' FROM campusx.smartphone
GROUP BY brand_name  ORDER BY avg_screen_size  LIMIT 1;


#Group smartphone by Brand and find the brand with highest numbrer of model that have both NFC and IR Blaster 
SELECT brand_name,COUNT(*) AS 'count_phones'
FROM campusx.smartphone
WHERE has_nfc='True' AND has_ir_blaster='True'
GROUP BY brand_name
ORDER BY count_phones DESC  LIMIT 5;

# FInll th samsung 5g enabled smartphoes and find the avg pricr for NFC and NOn_nfc phone
SELECT  has_nfc, round(avg(price))

FROM campusx.smartphone
WHERE brand_name='samsung' AND has_5g ='True'
GROUP BY has_nfc;

#Having Clause 
#Avg Price based on brand_name which have atleast 20phones
select * from smartphone;
SELECT brand_name,COUNT(*),ROUND(AVG(price),2) AS 'avg_price' FROM campusx.smartphone
GROUP BY brand_name HAVING COUNT(*)>20 
ORDER BY avg_price DESC ;
#Find the top 3 brands with highedt avg ram have a refresh rate of at leasr 90 HZ and fast charging available and donot consider brands
#which have less than 10 phones 
SELECT brand_name,ROUND(avg(ram_capacity),2) AS 'avg_ram'
FROM campusx.smartphone
WHERE fast_charging_available=1  AND refresh_rate >=90
GROUP BY brand_name
HAVING  COUNT(*)>=10 ORDER BY avg_ram DESC LIMIT 3;

#FInd the AVG Price of all the phone brands woth avg rating > 70 
# and num_phornd more than 10 among all 5g enabled phones 

SELECT brand_name, ROUND(AVG(price),2) AS 'avg_price'
FROM campusx.smartphone
WHERE has_5g='True'
GROUP BY brand_name
HAVING AVG(rating)>70 AND COUNT(*)>10;







 