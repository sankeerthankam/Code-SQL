/*
Write a query to return the number of streams in the same day when a user subscribes  in the first 7 days of August 2021 (2021-08-01 to 2021-08-07, inclusively).
Table 1: subscription 

When a user subscribes to amazon prime video.

    col_name       |  col_type
-------------------+--------------------------
 subscription_id   | bigint
 subscription_dt   | date
 customer_id       | bigint
Table 2: video_stream 

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

 count
-------
     6
(1 row)
*/
SELECT COUNT(stream_id)
FROM subscription S
INNER JOIN video_stream V
ON S.customer_id = V.customer_id
AND S.subscription_dt = V.stream_dt
WHERE stream_dt >= '2021-08-01'
AND stream_dt <= '2021-08-07';
