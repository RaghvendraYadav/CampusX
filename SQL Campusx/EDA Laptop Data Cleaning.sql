use sql_cx;

SELECT * FROM laptop;

-- head,tail and sample 
SELECT * FROM laptop ORDER BY index1 limit 5;

-- tail 

SELECT * FROM laptop ORDER BY index1 desc limit 5;

-- sample using rand()
SELECT * FROM laptop ORDER BY  rand() limit 5;


-- univariate analysis on numerical cols 
SELECT price FROM laptop;

-- count,min,max,mean,std,q1,q2,q3
SELECT MIN(price) OVER(),
MAX(price) OVER(),
COUNT(price) OVER(),
AVG(price) OVER(),
STD(price) OVER(),
percentile_cont(0.25) WITHIN GROUP(ORDER BY price) OVER() AS 'Q1',
percentile_cont(0.50) WITHIN GROUP(ORDER BY price) OVER() AS 'Median',
percentile_cont(0.75) WITHIN GROUP(ORDER BY price) OVER() AS 'Q3'
FROM laptop
ORDER BY index1 limit 1;

-- outliers 

SELECT * FROM (
SELECT percentile_cont(0.25) WITHIN GROUP(ORDER BY price) OVER() AS 'Q1',
percentile_cont(0.75) WITHIN GROUP(ORDER BY price) OVER() AS 'Q3',
FROM laptop ) t
WHERE t.price <t.Q1 -(1.5*(t.Q3-t.Q1)) OR t.price > t.Q3 + (1.5*(t.Q3-t.Q1));


-- histogram in SQL 
SELECT buckets,repeat('*',(count(*)/10)) FROM 
		(SELECT price,
		CASE
			WHEN price BEtWEEN 0 AND 25000 THEN  '0-25k'
			WHEN price BETWEEN 25001 AND 50000 THEN  '25-50k'
			WHEN price BETWEEN 50001 AND 75000 THEN  '50k-75K'
			WHEN price BETWEEN 75001 AND 100000 THEN  '75-100k'
			ELSE  '>100K'
			END AS 'buckets'
		FROM laptop) t 
        
GROUP By  t.buckets
ORDER BY count(*) desc ; 

SELECT company ,count(*) 
FROM laptop 
group by company;



