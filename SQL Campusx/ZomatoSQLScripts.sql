CREATE DATABASE zomato;
-- Select A Particular DAtaSET 
USE zomato;
-- COUNT NO OF ROWS 
SELECT COUNT(*) FROM zomato.delivery_partner;
SELECT COUNT(*) FROM order_details;

-- return n random records 
-- replicates sample function from pandas
SELECT * FROM users ORDER BY rand() LIMIT 5 ;

-- FIND NOT NULL VALUES 
SELECT * FROM orders WHERE restaurant_rating IS NOT NULL;

-- To REPLACE NULL VALUES WITH ZERO
UPDATE orders SET restaurant_rating=0 WHERE restaurant_rating IS NULL;

-- FIND NO OF ORDERS PLACED BY EACH CUSTOMERS 
SELECT name,count(*) AS 'num_orders'  FROM orders t1
INNER JOIN users t2
ON t1.user_id=t2.user_id
GROUP BY t2.user_id;

-- FIND RESTAURANT WITH MOST NO OF MENU 
SELECT r_name,count(*)  FROM restaurants t1 
INNER JOIN menu t2
ON t1.r_id=t2.r_id
GROUP BY t1.r_id;

-- FIND NO of Votes and avg rating for all the restaurants

SELECT r_name,count(*) AS 'num_votes' ,round(avg(restaurant_rating),1) AS 'avg_rating' FROM orders t1
INNER JOIN restaurants t2 
ON t1.r_id =t2.r_id 
WHERE restaurant_rating IS NOT NULL
GROUP BY t1.r_id;

-- FIND THE FOOD THT IS BEING SOLD AT MOST NO OF RESTAURANT 
SELECT  f_name,count(*)  FROM menu t1 
INNER JOIN food t2
ON t1.f_id=t2.f_id
GROUP BY t1.f_id
ORDER BY count(*) DESC LIMIT 1 ;

-- FIND restaurant with max revenue in a gien month 
-- JULY
SELECT r_name,sum(amount) AS 'revenue' FROM orders t1
INNER JOIN restaurants t2 
ON t1.r_id=t2.r_id
WHERE monthname(DATE(date))='July'
GROUP BY t1.r_id
ORDER BY revenue DESC LIMIT 1; 
-- SELECT MONTHNAME(DATE(date)),DATE(date) FROM orders;

SELECT r_name,monthname(DATE(date)),sum(amount) FROM orders t1
INNER JOIN restaurants t2 
ON t1.r_id=t2.r_id
GROUP BY monthname(DATE(date)),t1.r_id
ORDER BY month(DATE(date)) ASC ,sum(amount) DESC ; 

-- FIND the restaurant  with sales > x 
SELECT r_name, sum(amount) AS 'revenue' FROM orders t1 
JOIN restaurants t2 
ON t1.r_id=t2.r_id
GROUP BY t1.r_id
HAVING revenue>1500;

-- FIND customers who have never ordered 
SELECT user_id,name FROM users 
EXCEPT 
SELECT t1.user_id,name  FROM orders t1
JOIN users t2 
t1.user_id=t2.user_id;


#SHOW Order details of particular customers in a given date range 
SELECT f_name,date,amount FROM orders  t1 
JOIN order_details t2
ON t1.order_id=t2.order_id
JOIN food t3
ON t2.f_id=t3.f_id
WHERE user_id=1 AND date BETWEEN '2022-05-15' AND '2022-07-15';

-- Customer wise  favorite food 
SELECT name,f_name,count(*)  FROM users t1
JOIN orders t2 
ON t1.user_id =t2.user_id 
JOIN order_details t3
ON t2.order_id =t3.order_id
JOIN food t4
ON t3.f_id=t4.f_id
GROUP BY  t1.user_id,t4.f_id 
ORDER BY name,f_name desc;

-- FIND MOST COSTLY  restaurants 
SELECT r_name,count(*),sum(price) ,sum(price)/count(*) AS 'avg'FROM menu t1 
JOIN restaurants t2 
ON t1.r_id=t2.r_id
GROUP BY t1.r_id 
ORDER BY avg DESC limit 1;

-- DELIVERY PARTNER compensation using FORMULA
SELECT partner_name,round(avg(delivery_rating),2),
((count(*)*100)+(1000*delivery_rating))  AS 'Salary' FROM delivery_partner t1 
JOIN orders t2
ON t1.partner_id=t2.partner_id 
GROUP BY t1.partner_id 
ORDER BY Salary DESC   ;

#FIND CORRELATION BETWEEN delivery_Time and Delivery_Rating 
SELECT CORR(delivery_time,delivery_rating+restaurant_rating) FROM orders;

#FIND ALL THE VEG Restaurant 
SELECT r_name,MAX(TYPE)  FROM food t1
JOIN menu t2
ON t1.f_id=t2.f_id
JOIN restaurants t3 
ON t2.r_id=t3.r_id
group by t2.r_id
HAVING  MIN(type)='VEG' AND MAX(type)='VEG';

# FIND MIN AND MAX VALUE FOR all the Customers 
SELECT name,MAX(amount),MIN(amount) FROM orders t1 
JOIN users t2
ON t1.user_id=t2.user_id
GROUP BY t1.user_id;

  










