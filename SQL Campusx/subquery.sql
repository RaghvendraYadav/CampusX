USE sql_cx;
-- Highest Rated Movies
SELECT * FROM MOVIES 
WHERE score = (SELECT MAX(score) FROM movies);

-- ALTER TABLE movies change IMDB_Rating score numeric;

-- TYPES OF SUBQUERY 
-- BAesd on Return  1. Scalar subquery 2. Row subquery 3. Table subquery 
-- Based on working  1. Independent subquery 2.Corelated subquery 

SELECT * FROM movies; 

#INDEPENDENT Subquery 
 #Movie with highest profit 
 SELECT * FROM movies 
 where (gross- budget)= (SELECT MAX(Gross-budget) FROM movies);
 
 #Movies whose score > than  average score 
SELECT count(*) AS 'Total Movies'  FROM movies 
where score> (SELECT AVG(score) FROM movies);

#FIND THE Highest rated movie of 2000
SELECT * FROM movies;
SELECT name FROM movies 
WHERE year=2000 AND score=(SELECT MAX(score) FROM movies WHERE year=2000);

#FIND the highest rated movie among all the movies whose no of votes > avg votes
SELECT name FROM movies 
WHERE score= (SELECT MAX(score) from movies WHERE votes>(SELECT avg(votes) FROM movies));


#Independent Subquery  - Row Subquery 
#Users who have never placed the orders 
SELECT * FROM zomato.users 
WHERE user_id NOT IN (SELECT distinct(user_id) FROM zomato.orders);

-- FIND ALL THE MOVIES FROM TOP 3 Directors

SELECT * FROM sql_cx.movies 
WHERE  director  in (
				SELECT director FROM sql_cx.movies
				 GROUP BY director
				 ORDER BY sum(gross) DESC LIMIT 3);


-- USING CTE 
WITH  top_directors  AS (
				SELECT director FROM sql_cx.movies
				 GROUP BY director
				 ORDER BY sum(gross) DESC LIMIT 3) 
SELECT * FROM sql_cx.movies
WHERE director in (SELECT * FROM top_directors);

-- FIND ALL the movies for all those actors whose filmography's avg rating > 8.5 (take votes  250000 as cut off )
SELECT * FROM movies ;
WHERE  star in (
			SELECT star FROM movies
			WHERE votes > 25000 
			GROUP BY  star
			HAVING AVG(score) > 8.5 );
            
Select * FROM movies;

-- Independent Subquery  Table Subquery 
-- The most profitable movie of each year;
SELECT * FROM movies where (year,(gross-budget)) IN
		(SELECT  year ,MAX(gross-budget) FROM movies
		GROUP BY year);


#FInd the highest rated movie of each genre votes cutoff  25000
SELECT * FROM movies 
where (genre,score) IN 
						(
						SELECT genre,MAX(score) FROM movies 
						WHERE votes > 25000
						GROUP BY genre)
					AND  votes > 25000;
                    
-- Find the highest grossing movie of top 5 actor director commbo  in terms of total gross incomes 
WITH  top_star_directors AS (SELECT star,director,max(gross) FROM movies 
		GROUP BY star,director 
		ORDER BY sum(gross) DESC  LIMIT 5)
	
SELECT * FROM movies WHERE 
(star,director,gross) IN 
		(SELECT * FROM top_star_directors);
        


-- Correlated Subquery 
#FIND THE Movies THAT have the rating  higher than the average ratig of movies in the same genre 
SELECT * FROM movies m1 
where score > (SELECT avg(score) 
FROM movies m2  where m2.genre=m1.genre) ;

-- FIND  the FAVORITE FOOD of each customer 
WITH fav_food AS (
		SELECT t2.user_id,name,f_name,count(*)AS 'freq' FROM zomato.users t1 
		JOIN zomato.orders t2 
		ON t1.user_id=t2.user_id
		JOIN zomato.order_details t3 
		ON t2.order_id=t3.order_id
		JOIN zomato.food t4
		ON t3.f_id=t4.f_id
		GROUP BY t1.user_id,t3.f_id
        ) 
        SELECT * FROM fav_food f1 
        WHERE freq=(SELECT MAX(freq) FROM fav_food f2
				WHERE  f2.name=f1.name);


#GET the percentage of votes for each movie comapred with the total no of votes 
SELECT  name, round((votes/(select sum(votes)FROM movies))*100,2) AS 'percent' from movies;

#Display all movies names ,genre ,score and avg(score) by genre 
SELECT name,genre,score,(SELECT avg(score) FROM movies t1 WHERE t1.genre=t2.genre) AS 'AVG_SCORE_Genre' FROM movies t2;
 
-- FROM  AVG RATING in Restaurant Table 
SELECT r_name,t1.r_id,avg_rating FROM (SELECT r_id,avg(restaurant_rating) AS 'avg_rating'
FROM zomato.orders 
GROUP BY r_id) t1 
JOIN zomato.restaurants t2 
ON t1.r_id=t2.r_id;
;

-- Subquery Using  with Having 
-- FIND genres having avg score > avg score of all movies 
SELECT genre,avg(score) FROM movies 
GROUP BY genre
HAVING  avg(score)> (SELECT  avg(score) from movies); 

-- Subquery in INSERT 
USE zomato;
CREATE table loyal_users(
user_id int,
name varchar(255),
money int); 
-- pupulate a already created loyal_customers  with records of only those 
-- customers who have ordered food more than 3 times 
insert into loyal_users (name,user_id)
	 (select name,t1.user_id from orders t1 
	JOIN users t2 
	ON t1.user_id=t2.user_id
	group by user_id 
	having count(*)>3);

-- Populate the money column of loyal_users. Provide a 10%  app money  to all customers  based on order value 
UPDATE loyal_users 
SET money=
		(
			SELECT (sum(amount)*0.1) FROM orders
            WHERE orders.user_id = loyal_users.user_id) ;
            
DELETE FROM users 
WHERE user_id IN (SELECT user_id FROM users
WHERE user_id NOT IN (SELECT distinct(user_id) FROM orders));