/*
Write a query to return the top country by the number of streams in the first 7 days of August 2021 (2021-08-01 to 2021-08-07, inclusively).
We assume there is only 1 country that has the most streams.
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

 customer_country
------------------
 US
(1 row)
*/
SELECT customer_country
FROM video_stream
WHERE stream_dt >= '2021-08-01'
AND stream_dt <= '2021-08-07'
GROUP BY customer_country
ORDER BY COUNT(stream_id) DESC
LIMIT 1;
