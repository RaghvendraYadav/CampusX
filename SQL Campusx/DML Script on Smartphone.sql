#How to import data from csv 
#DataSET Link : https://drive.google.com/drive/folders/1rN2AkOfuJEhroHqRuECshxBKhz0gJBeJ
#Select ALl The ROWs & COLUMNS 
SELECT * FROM campusx.smartphones;

#Select ALl The ROWs & COLUMNS 
SELECT * FROM campusx.smartphones WHERE 1;

#Filter COlumns 

SELECT model,price,rating FROM campusx.smartphones;

SELECT model,battery_capacity,os FROM campusx.smartphones;

#Give COLUMN NEW  Name in SELECT COmmand using AS Keyword  ALIAS
SELECT model,battery_capacity AS  'MAH' ,os as 'Operating System' FROM campusx.smartphones;

#CREATE MAtheMATICAl EXPRESSION to find PPI from resolution width and length 

SELECT model, 
SQRT(resolution_width*resolution_width + resolution_height*resolution_height) / screen_size as 'PPI' from campusx.smartphones;

SELECT model, rating/10 AS 'rating' from campusx.smartphones;

# ADDING SAME VALUE TO  the new COLUMN 
SELECT model,'SMARTPHONE' AS 'type' FROM campusx.smartphones;

#UNIQUE VALUE FETCH KRNA FROM COLUMN 

SELECT DISTINCT(brand_name)  AS 'ALL Brands'
FROM campusx.smartphones;

SELECT DISTINCT(os)  AS 'OS Names'
FROM campusx.smartphones;

SELECT DISTINCT(brand_name)  AS 'ALL Brands'
FROM campusx.smartphones;


#Unique Combinations /Distinct Combinations 

SELECT DISTINCT brand_name,processor_brand 
FROM campusx.smartphones;


#Filtering rows based on conditions 

#using where clause 
#All rows having samsung phones 
SELECT * FROM campusx.smartphones WHERE brand_name='samsung';

#All rows having apple phones 
SELECT * FROM campusx.smartphones WHERE brand_name='apple';


#Price > 50k
SELECT * FROM campusx.smartphones WHERE price > 50000;


#AND Operator 
SELECT * FROM campusx.smartphones WHERE price > 10000 AND price <20000;

-- Between Operator 
SELECT * FROM campusx.smartphones WHERE price BETWEEN 10000 AND 20000 ;

-- RATING > 80 and Price <15000 and processor brand is snapdragon 
SELECT * FROM campusx.smartphones WHERE price<15000 AND rating > 80 AND processor_brand='snapdragon'; 
 
 
--  Brand SAMSUNG  and  RAM CAPACITY > 8	
SELECT * FROM campusx.smartphones WHERE brand_name= 'samsung' AND ram_capacity>8 ; 

-- SAMSUNG WITH SNAPDRAGON
SELECT * FROM campusx.smartphones WHERE brand_name= 'samsung' AND processor_brand='snapdragon';

#QUERY EXECUTION ORDER  - FROM, JOIN, WHERE, GROUP BY , HAVING , SELECT , DISTINCT , ORDER BY 
 #BRAND WHICH MAKE PHONE > 100000 
 SELECT distinct(brand_name) from campusx.smartphones where price > 100000;
 
 # IN and NOT IN 
 #PHONE WHOSE Processor BRand  is   snapdragon , bionic ,exynos 
 
 select * FROM campusx.smartphones WHERE processor_brand IN  ('snapdragon','bionic','exynos');
 
  #PHONE WHOSE Processor BRand  is not   snapdragon , bionic ,exynos
  select * FROM campusx.smartphones WHERE processor_brand NOT IN  ('snapdragon','bionic','exynos'); 
  
  #Phone where processor_brand is mediatek 
  
  select * from campusx.smartphones WHERE processor_brand = 'mediatek';
  
  # SET processor_brand 'dimensity' where processor brand is mediatek 
  
  UPDATE campusx.smartphones 
  SET processor_brand='dimensity' 
  WHERE processor_brand='mediatek';
  -- First the above query will give error bcoz we need to  disable safe mode 
  -- go to edit  , prefrences , SQL Editor  in Bottom we need to uncheck safe edit 
  
SELECT * FROM campusx.users;

# EMAIL CHange and passoword 
 UPDATE users 
 SET email='rag@yahoo.com' ,password ='1212'
 WHERE name ='Raghvendra';
  
SELECT * FROM campusx.users;  


# DELETE Operation 
#PHONES WHOSE PRice is > 2 Lakh 
SELECT * FROM  campusx.smartphones WHERE price >200000;

#DELETE PHONES WHOSE PRice is > 2 Lakh
DELETE FROM campusx.smartphones WHERE price > 200000;
 
 
 #DELETE PHONES whose PRIMARY CAMERA is > 150 Megapixel  or jo samsung k h 
 
 SELECT * FROM campusx.smartphones  where primary_camera_rear > 150  and brand_name='samsung';
 
 DELETE FROM campusx.smartphones where primary_camera_rear > 150  and brand_name='samsung';
 
 #TYPES OF FUNCTIONS IN SQL 
 
 #Aggrage Functions 
 # MAX? MIN 
 
 #find most expensive mobile 
 SELECT MAX(price) FROM campusx.smartphones;
 
 # RAM M maximu value kya h 
 SELECT MAX(ram_capacity) FROM campusx.smartphones;
 
 #FIND THE PRICE OF COSTIEST SAMSUNG SMARTPHONE 
 SELECT MAX(price) from campusx.smartphones WHERE brand_name ='samsung';
 
# Find the MODEL NAME of the COSTIEST SAMSUNG SMARTPHONE 
SELECT model from campusx.smartphones where price in (SELECT MAX(price) from campusx.smartphones WHERE brand_name ='samsung'); 

# FIND the AVG RATING of APPLE mobile 
SELECT AVG(rating) from campusx.smartphones WHERE brand_name ='apple';

# FIND the AVG PRICE of APPLE mobile 
SELECT AVG(price) from campusx.smartphones WHERE brand_name ='apple';

#SUM 
SELECT SUM(price) from campusx.smartphones WHERE brand_name ='apple';

 #COUNT - it icount the no of instances 
 #COUNT the no of oneplus phones 
 SELECT count(*)from campusx.smartphones WHERE brand_name ='oneplus';
 SELECT count(*)from campusx.smartphones WHERE brand_name ='apple';
 
 #UNIQUE Count Nikalna 
 #FInd no of brands in our Data 
 SELECT COUNT(DISTINCT(brand_name)) from campusx.smartphones;
 
 #Total no of processor_brand
 SELECT COUNT(DISTINCT(processor_brand)) from campusx.smartphones;
 
 #Standard Deviation of screen_size 
  SELECT STD(screen_size) FROM campusx.smartphones;
  
#Variance of screen_size 
SELECT VARIANCE(screen_size) FROM campusx.smartphones;
 
 
 #Scalor Functions 
 #Absolute 
 SELECT price-100000  as temp FROM campusx.smartphones;
 SELECT ABS(price-100000)  as temp FROM campusx.smartphones;
 
 #ROUND 
SELECT model, 
round(SQRT(resolution_width*resolution_width + resolution_height*resolution_height) / screen_size,2) as 'PPI' from campusx.smartphones;

#CEIL 
SELECT CEIL(4.2);
SELECT FLOOR(2.3);

 










