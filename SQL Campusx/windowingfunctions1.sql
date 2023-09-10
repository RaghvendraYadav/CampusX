-- TOP 5 batsman of each team 
SELECT * FROM
		(SELECT batting_team,batsman,sum(total_runs) AS 'total_runs',
		DENSE_RANK() OVER (PARTITION BY batting_team ORDER BY sum(total_runs) DESC) AS 'rank_within_team'
		FROM ipl.ipl_deliveries
		GROUP BY batting_team,batsman) t
WHERE t.rank_within_team < 6
ORDER BY t.batting_team,t.rank_within_team;

-- Cumulative SUM 
-- V kohli n 50 th Match m 100th match 200th match m kitne run bnaye 
SELECT * FROM ipl.ipl_deliveries;

SELECT * FROM 
		(SELECT
		CONCAT("Match-",ROW_NUMBER() OVER(ORDER BY match_id)) AS "match_no",
		SUM(batsman_runs) AS 'runs_scored',
		SUM(SUM(batsman_runs)) OVER(ROWS BETWEEN unbounded PRECEDING AND current row) AS 'carrer_runs'
		FROM ipl.ipl_deliveries
		WHERE batsman='V Kohli'
		GROUP BY match_id) t
WHERE match_no='Match-50' OR match_no='Match-100' OR match_no='Match-125';


-- CUMULATIVE AVERAGE 
SELECT * FROM
		(SELECT 
		CONCAT('Match-'+ROW_NUMBER() OVER(ORDER BY match_id)) AS 'match_no',
		SUM(batsman_runs) AS 'sum_runs',
		AVG(SUM(batsman_runs)) OVER(ROWS BETWEEN unbounded PRECEDING AND CURRENT ROW) AS 'CUM_AVG'
		FROM ipl.ipl_deliveries
        WHERE batsman='V Kohli'
		GROUP BY match_id) t;



SELECT * FROM 
		(SELECT
		CONCAT("Match-",ROW_NUMBER() OVER(ORDER BY match_id)) AS "match_no",
		SUM(batsman_runs) AS 'runs_scored',
		SUM(SUM(batsman_runs)) OVER(ROWS BETWEEN unbounded PRECEDING AND current row) AS 'carrer_runs',
        AVG(SUM(batsman_runs)) OVER(ROWS BETWEEN unbounded PRECEDING AND current row) AS 'avg_runs'
		FROM ipl.ipl_deliveries
		WHERE batsman='V Kohli'
		GROUP BY match_id) t;
        
SELECT * FROM 
		(SELECT
		CONCAT("Match-",ROW_NUMBER() OVER(ORDER BY match_id)) AS "match_no",
		SUM(batsman_runs) AS 'runs_scored',
		SUM(SUM(batsman_runs)) OVER w AS 'carrer_runs',
        AVG(SUM(batsman_runs)) OVER w AS 'avg_runs'
		FROM ipl.ipl_deliveries
		WHERE batsman='V Kohli'
		GROUP BY match_id
        WINDOW w AS (ROWS BETWEEN unbounded PRECEDING AND current row)) t ;
        
-- Running Average 
-- Batsman Current Form  By doing avg of previous 10 values meand the window we decide 
-- 10 matches running average 
SELECT * FROM 
		(SELECT
		CONCAT("Match-",ROW_NUMBER() OVER(ORDER BY match_id)) AS "match_no",
		SUM(batsman_runs) AS 'runs_scored',
		SUM(SUM(batsman_runs)) OVER w AS 'carrer_runs',
        AVG(SUM(batsman_runs)) OVER w AS 'avg_runs',
        AVG(SUM(batsman_runs)) OVER (ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS 'running_avg'
		FROM ipl.ipl_deliveries
		WHERE batsman='V Kohli'
		GROUP BY match_id
        WINDOW w AS (ROWS BETWEEN unbounded PRECEDING AND current row)) t ;
        
        
-- COPY The QUERY AND GO to JUPYTER  CONNECT TO THE DATABASE GET THE pd.read_sql_query ANd GET DF
-- the DATAFRAME AND BUILD THE Vidulaization like I Did on sql_pytohn_con.py 

 -- Percent of total 
 
 use zomato;
 
 
 SELECT f_name,
 round((total_value/SUM(total_value) OVER())*100,2) AS 'percent_of_total'
 FROM(
		 SELECT f_id,sum(amount) AS 'total_value' FROM orders t1
		 JOIN order_details t2
		 ON t1.order_id=t2.order_id
		 WHERE r_id=1
		 GROUP BY f_id) t
JOIN food t2
ON t.f_id =t2.f_id   ;
 
 


	
        
