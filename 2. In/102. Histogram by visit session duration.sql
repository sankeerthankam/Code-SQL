/*
Write a query to generate the distribution of the number of users by different session durations.
For simplicity, we want to know the following time intervals and the group labels.
less than 50 seconds. label: < 50
[50, 100) seconds. label: 50, 100
[100, 150) seconds. label: 100, 150
[150, 200) seconds. label: 150, 200
[200, 250) seconds. label: 200, 250
250 seconds and above. label:  >= 250
A user can have multiple sessions with different duration and can be counted multiple times.
Table 1: session_web 

Every time a user visits the website, a new session starts, it ends when the user leaves the site.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Table 2: session_web_duration 

The number of seconds a user spends by session.

  col_name       | col_type
-----------------+---------------------
date             | date    
session_id       | bigint
duration         | int

Sample results

   date    |   uu_cnt
-----------+--------------
< 50       | 20000
50, 100     | 12000
100, 150     | 5000
*/

WITH session_user_duration AS (
    SELECT 
        W.session_id,
        W.user_id, 
        MAX(D.duration) AS duration
    FROM session_web W
    inner JOIN session_web_duration D
    ON D.session_id = W.session_id
    GROUP BY W.session_id, W.user_id
),
session_user_label AS (
    SELECT session_id,
           CASE WHEN duration < 50 THEN '< 50'
                WHEN duration < 100 THEN '50, 100'
                WHEN duration < 150 THEN '100, 150'
                WHEN duration < 200 THEN '150, 200'
                WHEN duration < 250 THEN '200, 250'
                WHEN duration >= 250 THEN '>= 250'
               ELSE NULL END AS duration_category,
           user_id
    FROM session_user_duration
)
SELECT duration_category, COUNT(DISTINCT user_id)
FROM session_user_label
GROUP BY duration_category
ORDER BY duration_category;
