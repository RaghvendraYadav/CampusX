SELECT * FROM flights.flights;
#Find the the unique source name and distinct name of cities 
SELECT distinct(Source) FROM flights.flights UNION 
SELECT distinct(Destination) FROM flights.flights;

-- Query for Source and destination 
SELECT * FROM flights.flights WHERE Source='Banglore' AND Destination='New Delhi';
-- Total no of rows 
SELECT * FROM flights.flights;

# count flight based on AIRLINE 

SELECT AIRLINE,count(*) FROM flights.flights
GRoup BY AIRLINE; 

-- Busiest Airport 
SELECT SOURCE,count(*) FROM
							(SELECT source FROM flights.flights
							UNION ALL SELECT destination FROM flights.flights) t
						GROUP BY t.source; 
                            


