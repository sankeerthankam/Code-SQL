/*
Binge-watching: 5 hours of watching in a day.
Write a query to find the customer id of binge-watchers in the US in August 2021.
Table: video_stream 

Online movie streaming logs.

       col_name       |  col_type
----------------------+--------------------------
 stream_id            | bigint
 stream_dt            | date
 device_id            | integer
 device_category      | varchar(20) -- 'fire tv',  'apple tv', 'samsung tv', 'google tv', 'roku'
 customer_id          | bigint
 minutes_streamed     | integer
 buffer_count         | integer -- number of seconds before the video start playing
 customer_country     | varchar(20) -- US, UK, AU
Sample results

 customer_id
-------------
       80002
*/
WITH watch_hours AS (
    SELECT customer_id,  SUM(minutes_streamed) * 1.0 / 60 AS total_watch_hour
    FROM  video_stream
    WHERE customer_country = 'US'
    AND stream_dt >= '2021-08-01'
    AND stream_dt <= '2021-08-31'
    GROUP BY customer_id
)
SELECT customer_id
FROM watch_hours
WHERE total_watch_hour > 5;
