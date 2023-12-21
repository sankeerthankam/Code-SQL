/*
Write a query to return the  most popular video categories watched by the most number of distinct users each day in August 2021;
Hint: a user can watch the same video multiple times.
Table: video_session

Video watch history for all users.

  col_name       | col_type
-----------------+---------------------
session_id       | bigint
user_id          | bigint
video_id         | bigint
video_category   | varchar(20)
start_at         | timestamp

Sample results

    date    | video_category
------------+----------------
 2021-08-01 | Dance
 2021-08-02 | Entertainment
 2021-08-03 | Dance
 2021-08-04 | Dance
 2021-08-05 | Dance
 2021-08-06 | Entertainment
*/
WITH daily_plays AS (
    SELECT 
        DATE(start_at) date, 
        video_category, 
        ROW_NUMBER() OVER (PARTITION BY DATE(start_at) ORDER BY COUNT(DISTINCT user_id) DESC ) AS ranking
    FROM video_session
    WHERE DATE(start_at) >= '2021-08-01'
    AND DATE(start_at) <= '2021-08-31'
    GROUP BY 1,2
)
SELECT date,  video_category
FROM daily_plays
WHERE ranking <= 1
ORDER BY 1;
