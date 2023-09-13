SELECT * FROM campusx.smartphone;
#Segmentation 
#NTILE 
SELECT brand_name,model,price,
NTILE(3) OVER(Partition  BY brand_name ORDER BY Price)
FROM campusx.smartphone;


SELECT brand_name,model,price,
CASE 
	WHEN bucket=1 then 'Budget'
    WHEN bucket=2 then 'MidRange'
    When bucket=3 then 'Aukaad Se Bhaar'
END AS 'phone_type'
FROM (
			SELECT brand_name,model,price,
			NTILE(3) OVER(Partition  BY brand_name ORDER BY Price) AS 'bucket'
			FROM campusx.smartphone) t ;
            
            
#Cheapest Flight Konsi h 
SELECT * FROM (
			Select SOURCE,DESTINATION,airline,round(AVg(price),2),
			dense_rank()  OVER(PARTITION By SOURCE ,DESTINATION ORDER BY price) AS 'cheap_price'  From flights.flights
			GROUP By SOURCE,DESTINATION,airline) t
WHERE t.cheap_price=1;

