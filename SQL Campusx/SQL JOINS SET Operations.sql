CREATE DATABASE sql_cx;
USE sql_cx;
SELECT * FROM sql_cx.users;
SELECT * FROM sql_cx.groups;
#CROSS JOIN  ON USERS & GROUPS 
SELECT * FROM sql_cx.users t1 
CROSS JOIN sql_cx.groups t2 ;

#INNER JOIN IMPORTANT USERS & Membership
 SELECT * FROM sql_cx.users;
 SELECT * FROM sql_cx.membership;
 
 #INNER JOIN QUERY 
 SELECT * FROM sql_cx.users t1 
 INNER JOIN sql_cx.membership t2
 ON t1.user_id=t2.user_id;
 
 #LEFT JOIN 
SELECT * FROM  sql_cx.membership t1
LEFT JOIN sql_cx.users t2
ON t1.user_id=t2.user_id;

#RIGHT JOIN 
SELECT * FROM  sql_cx.membership t1
RIGHT JOIN sql_cx.users t2
ON t1.user_id=t2.user_id;

# OUTER JOIN MYSQL DOESNOT SUPPORT 


#SQL SET OPERATIONS 
#UNION 
SELECT * FROM sql_cx.person1 
UNION 
SELECT * FROM sql_cx.person2; 

#UNION ALL
SELECT * FROM sql_cx.person1 
UNION ALL
SELECT * FROM sql_cx.person2;

#INTERSECT
SELECT * FROM sql_cx.person1 
INTERSECT 
SELECT * FROM sql_cx.person2 ;


#EXCEPT NOT IN MYSQL SOME VERSION DOESNOT SUPPORT 
SELECT * FROM sql_cx.person1 
EXCEPT
SELECT * FROM sql_cx.person2 ;

#FULL OUTER JOIN IN MYSQL USING UNION 
SELECT * FROM  sql_cx.membership t1
LEFT JOIN sql_cx.users t2
ON t1.user_id=t2.user_id
UNION 
SELECT * FROM  sql_cx.membership t1
RIGHT JOIN sql_cx.users t2
ON t1.user_id=t2.user_id;


#SELF JOINS 
 SELECT * FROM sql_cx.users t1 
 INNER JOIN sql_cx.users t2
 ON t1.emergency_contact=t2.user_id;

#Multitable Joins 
USE flipkart; 
 SELECT * FROM flipkart.orders;
 SELECT * FROM flipkart.order_details;
 SELECT * FROM flipkart.category;
 SELECT * FROM flipkart.users;
 
 
  SELECT t1.order_id,t1.user_id,t3.name,t2.amount,t2.profit,t2.quantity FROM orders t1 INNER JOIN order_details t2 
 ON t1.order_id=t2.order_id INNER JOIN users t3
 ON t1.user_id=t3.user_id;
 
 #FILTERING COLUMNS 
 SELECT t1.order_id,t3.name,t2.amount,t2.profit,t2.quantity FROM orders t1 INNER JOIN order_details t2 
 ON t1.order_id=t2.order_id INNER JOIN users t3
 ON t1.user_id=t3.user_id;
 
 #FIND order_id,name and city 
 SELECT t1.order_id,t2.name,t2.city FROM flipkart.orders t1
 INNER JOIN flipkart.users t2
 ON t1.user_id = t2.user_id;

 #Order_id,product category 
 SELECT order_id,vertical FROM flipkart.order_details t1 
 INNER JOIN flipkart.category t2 
 ON t1.category_id=t2.category_id;
 
 #FILTERING ROWS 
 #FIND ALL ORDER FROM PUNE 
 SELECT order_id,name,state,city FROM flipkart.orders t1
 INNER JOIN flipkart.users t2
 ON t1.user_id = t2.user_id
 WHERE t2.city='Pune';
 
  #FIND ALL ORDER FROM PUNE  AND FROM PERSON Pearl
 SELECT order_id,name,state,city FROM flipkart.orders t1
 INNER JOIN flipkart.users t2
 ON t1.user_id = t2.user_id
 WHERE t2.city='Pune'and name='Pearl';
 
 # FIND ALL ORDERS under CHAIR Category 
 SELECT t1.order_id,category,vertical FROM flipkart.orders t1
 INNER JOIN flipkart.order_details t2
 ON t1.order_id=t2.order_id
 INNER JOIN flipkart.category t3
 ON t2.category_id=t3.category_id
 WHERE t3.vertical='Chairs';
 
 #Practice Questions 
 #FIND TOP 10  PROFITABLE orders
 SELECT t1.order_id,sum(profit) AS total_profit FROM flipkart.orders t1
 INNER JOIN flipkart.order_details t2
 ON t1.order_id=t2.order_id
 GROUP BY t2.order_id HAVING sum(profit)>0
 ORDER BY sum(profit) DESC LIMIT 10;
 
 #FIND customer who have place max no of orders 
 SELECT t1.user_id,name,count(*) FROM  flipkart.orders t1
 INNER JOIN flipkart.users t2
 ON t1.user_id=t2.user_id
GROUP BY t2.name ORDER BY count(*) DESC LIMIT 1;

#FIND THE MOST PROFITABLE CATEGORY 
SELECT vertical,sum(profit) as 'Total Profit' FROM  order_details t1
INNER JOIN category t2
ON t1.category_id=t2.category_id
GROUP BY vertical 
ORDER By sum(profit) DESC LIMIT 1;

#FIND THE MOST PROFITABLE State

SELECT state,sum(profit) as 'Total Profit' FROM  order_details t1
INNER JOIN orders t2
ON t1.order_id=t2.order_id
INNER JOIN users t3
ON t2.user_id=t3.user_id
GROUP BY state
ORDER By sum(profit) DESC LIMIT 1;
 
#Profit HIGHER THAN 3000
 SELECT vertical,sum(profit) as 'Total Profit' FROM  order_details t1
INNER JOIN category t2
ON t1.category_id=t2.category_id
GROUP BY vertical 
HAVING sum(profit)>3000;


 
	





