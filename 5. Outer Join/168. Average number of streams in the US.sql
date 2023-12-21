/*
Write a query to return the daily number of streams in the US in the first 7 days of August 2021 (2021-08-01 to 2021-08-07, inclusively).
Return 0 if there is no streams in a day.
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
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

    date    | num_streams
------------+-------------
 2021-08-01 |           2
 2021-08-02 |           0
 2021-08-03 |           3
 2021-08-04 |           0
 2021-08-05 |           3
 2021-08-06 |           1
 2021-08-07 |           0

*/
SELECT D.date, COUNT(stream_id) AS num_streams
FROM dates D
LEFT JOIN video_stream V
ON D.date = V.stream_dt
AND  customer_country = 'US'
WHERE D.date >= '2021-08-01'
AND D.date <= '2021-08-07'
GROUP BY D.date;
