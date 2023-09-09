
USE campusx;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

SELECT AVG(marks) FROM campusx.marks;
-- In Windowing Function USING OVER
SELECT *,AVG(marks) OVER() FROM campusx.marks;

-- Windowing Function USING over Partition by branch
SELECT * , AVG(marks)   OVER(PARTITION BY branch) FROM marks;

-- MIN MARKS  OVER ENtire DATA 
SELECT *,MIN(marks) OVER() FROM marks;

-- MIN AND MAX MARKS  OVER ENtire DATA 
SELECT *,MAX(marks) OVER(),MIN(marks) OVER() FROM marks ORDER BY student_id ;

SELECT *,MAX(marks) OVER() AS 'MAX Marks',
MIN(marks) OVER(),
MAX(marks) OVER(PARTITION BY branch)
 FROM marks ORDER BY student_id ;
 
 
 -- FInd all the students who have marks higher than the avg marks of their respective branch
 SELECT * FROM (SELECT *,
 AVG(marks) OVER(PARTITION BY branch) AS 'branch_avg'
 FROM marks ) t
 WHERE t.marks > t.branch_avg;
 
 -- Rank Function
 SELECT * ,
 RANK() OVER(ORDER BY marks desc)  FROM marks;
 
 -- BRANCh WISE RAnking 
 SELECT *,
 RANK() OVER(PARTITION BY branch ORDER BY marks DESC) 
 FROM marks;
 
 
 -- Dense Rank 
 
 SELECT *,
 RANK() OVER(PARTITION BY branch ORDER BY marks DESC) ,
 DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
 FROM marks;
 
 
 -- ROW NUMBER 
 SELECT *,
 ROW_NUMBER() OVER(PARTITION BY branch)
 FROM marks;

-- ASSIGNING ROLL NUMBER 
SELECT *, 
CONCAT(branch,'-',ROW_NUMBER()  OVER(PARTITION BY branch))
FROM marks;

-- FIND top 2 most  paying customers of each month
USE zomato;
SELECT * FROM orders;

SELECT * FROM(
				SELECT MONTHNAME(date) AS 'month',user_id,sum(amount) AS 'total',
				RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY sum(amount) DESC) AS 'month_rank' 
				FROM orders
				GROUP BY MONTHNAME(date),user_id ORDER BY MONTH(date)) t
                JOIN users t1 ON t.user_id=t1.user_id
                WHERE t.month_rank<=2 ORDER BY t.month DESC,t.month_rank ;
                
-- FIRST VALUE/LAST VALUE /nth Value 
USE campusx;
-- NAME oF the Highest Score student 
SELECT * ,
FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;

-- NAME oF the LOWESt Score student  IN this we will get error 
SELECT * ,
LAST_VALUE(marks) OVER(ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'last_value'
FROM marks;

-- NAME oF the Highest Score student  IN this we will get error 
SELECT * ,
FIRST_VALUE(marks) OVER(ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'first_value'
FROM marks;

-- Har BRANCH K THIRD TOPPER BAND CHAHIYE 
SELECT * ,
NTH_VALUE(name,2) OVER(PARTITION BY branch
ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'nth_branch'
FROM marks;

-- FIND THE BRANCH TOPPER 
SELECT * ,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'first_value'
FROM marks;

SELECT * FROM
	(SELECT *,
	FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
	FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks' FROM marks ) t
WHERE t.name=t.topper_name  AND t.marks=t.topper_marks  ;

-- FIND THE LEAST SCORER of Each Branch 
SELECT * FROM
	(SELECT *,
	LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'losser_name',
   	LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'losser_marks' FROM marks ) t
WHERE t.name=t.losser_name  AND t.marks=t.losser_marks  ;

-- LEAD & LAG 
SELECT *,
LAG(marks) OVER(ORDER BY student_id) FROM marks;

-- LEAD
SELECT *,
LEAD(marks) OVER(ORDER BY student_id) FROM marks;


-- PARTITION By 
SELECT *,
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id) FROM marks;

-- FIND THE MoM Revenue Growth of ZOMATO 
USE zomato;
SELECT * FROM orders;

SELECT MONTHNAME(date),sum(amount),
(sum(amount)-LAG(SUM(AMOUNT)) OVER(ORDER BY MONTH(date)))/LAG(SUM(AMOUNT)) OVER(ORDER BY MONTH(date))*100 AS 'growth_percent'
FROM orders
GROUP BY MONTHNAME(date)
ORDER BY MONTH(date);

 




