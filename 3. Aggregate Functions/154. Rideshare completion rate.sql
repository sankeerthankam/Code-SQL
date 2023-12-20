/*
Write a query to report the overall trip completion rate (in %) in  Aug 2021.
Table: rideshare_trips 

  col_name       | col_type
-----------------+---------------------
id               | bigint   
client_id        | bigint
driver_id        | bigint
status           | varchar(20) -- 'completed', 'cancelled by driver', 'cancelled by client'
request_dt       | date

Sample results

   completion_rate
---------------------
 85.0000000000000000
*/
SELECT COUNT(CASE WHEN status = 'completed' THEN ID ELSE NULL END) * 100.0 / COUNT(*) AS completion_rate
FROM rideshare_trips
WHERE request_dt >= '2021-08-01'
AND   request_dt <= '2021-08-31';
