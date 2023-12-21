/*
Write a query to report the top 3 countries with the average number of watch time per customer.
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

 customer_country |       avg_time
------------------+----------------------
 AU               | 196.5000000000000000
 US               | 141.6000000000000000
 CA               |  84.0000000000000000
*/
SELECT customer_country, SUM(minutes_streamed) * 1.0 / COUNT(DISTINCT customer_id) AS avg_time
FROM video_stream
GROUP BY customer_country
ORDER BY 2 DESC LIMIT 3;
