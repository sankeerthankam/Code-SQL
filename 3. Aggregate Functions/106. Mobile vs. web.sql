/*
Write a query to compute the percentage of time a user spends on mobile vs. web.
Return 3 columns: user_id, web_percentage, mobile_percentage, the last 2 columns should sum to 100.
For simplicity, we can ignore users with no activities.
Table 1: session_mobile 

Every time a user opens the mobile app (iOS, Android), a new session starts, it ends when the user leaves the app.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Table 2: session_mobile_duration 

The number of seconds a user spends by session in their mobile app.

  col_name       | col_type
-----------------+---------------------
date             | date    
session_id       | bigint
duration         | int

Table 3: session_web 

Every time a user visits the website, a new session starts, it ends when the user leaves the site.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Table 4: session_web_duration 

The number of seconds a user spends by session.

  col_name       | col_type
-----------------+---------------------
date             | date    
session_id       | bigint
duration         | int

Sample results

 user_id    | web_percentage | mobile_percentage
------------+----------------+-------------
800001      |   20.12345     |    80.87655
800002      |   29.123       |    71.877
800003      |   0            |    100.0
*/
WITH duration AS (
    SELECT 'web' as platform,  session_id,  duration
    FROM session_web_duration
    UNION ALL
    SELECT 'mobile' as platform, session_id, duration
    FROM session_mobile_duration
),
session AS (
    SELECT  session_id, user_id
    FROM session_web
    UNION
    SELECT session_id, user_id
    FROM session_mobile
)
SELECT
    S.user_id,
    SUM(CASE WHEN D.platform='web' then duration ELSE 0 END) * 100.0 / SUM(duration )  AS web_duration,
    SUM(CASE WHEN D.platform='mobile' then duration ELSE 0 END) * 100.0 /SUM(duration )  AS mobile_duration
FROM duration D
INNER JOIN session S
ON S.session_id = D.session_id
GROUP BY S.user_id;
