/*
Write a query to return the completion rate (in %) for all drivers' first trips.
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
 80.0000000000000000
(1 row)
*/
WITH nth_trip AS (
    SELECT
        id,
        driver_id,
        status,
        ROW_NUMBER() OVER(PARTITION BY driver_id ORDER BY request_dt) AS rn
    FROM rideshare_trips
)


SELECT COUNT(CASE WHEN status = 'completed' THEN id ELSE NULL END) * 100.0 / COUNT(*) AS completion_rate
FROM  nth_trip
WHERE rn = 1;
