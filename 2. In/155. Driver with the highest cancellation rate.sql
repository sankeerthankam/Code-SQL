/*
Write a query to return the top 1 driver with the highest cancellation rate;
Cancellation has to be requested by clients.
Table: rideshare_trips 

  col_name       | col_type
-----------------+---------------------
id               | bigint   
client_id        | bigint
driver_id        | bigint
status           | varchar(20) -- 'completed', 'cancelled by driver', 'cancelled by client'
request_dt       | date

Sample results

 driver_id |  cancellation_rate
-----------+---------------------
     20008 | 50.0000000000000000
*/

SELECT
    driver_id,
    COUNT(CASE WHEN status = 'cancelled by client' THEN ID ELSE NULL END) * 100.0/COUNT(*) AS  cancellation_rate
FROM rideshare_trips
GROUP BY driver_id
ORDER BY 2 DESC
LIMIT 1;
