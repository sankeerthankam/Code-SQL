/*
Write a query to return the acceptance rate for the first week of 2021 (2021-01-01 - 2021-01-07)				
If a friend request is not accepted, the acceptance_dt column is null				

Data
request_id	acceptance_id	request_dt	acceptance_dt	
100001	    	900001		2021-01-01	2021-01-02	
100002	    	null		2021-01-01	null	
100003	    	900002		2021-01-01	2021-01-01	
				
Table Structure				
request_id	acceptance_id	request_dt	acceptance_dt	
bigint		bigint		date		date	
				
Output				
acceptance_rate				
acceptance_rate_1								

*/

SELECT				
	SUM(CASE WHEN acceptance_dt IS NOT NULL THEN 1 ELSE 0 END) * 1.0/COUNT(*)  as acceptance_rate			
FROM				
	request			
WHERE				
	request_dt >=  '2021-01-01' AND			
	request_dt <=  '2021-01-07'			
LIMIT 5;				
				
