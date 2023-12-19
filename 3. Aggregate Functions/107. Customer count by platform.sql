/*
Write a query to count the number of
Users who only used mobile apps; 
Users who only used web apps, 
Users used both mobile and web
Return 3 columns: num_web_only_users, num_mobile_only_users, num_web_and_mobile_users.
 

Table 1: session_mobile 

Every time a user opens the mobile app (iOS, Android), a new session starts, it ends when the user leaves the app.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Table 2: session_web 

Every time a user visits the website, a new session starts, it ends when the user leaves the site.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Sample results

   web_only_users    | mobile_only_users | web_and_mobile_users
---------------------+-------------------+--------------
12                   | 34                | 56
*/
WITH web_only AS (
    SELECT COUNT(DISTINCT user_id) AS num_web_only_users
    FROM session_web
    WHERE user_id NOT IN (
        SELECT DISTINCT user_id
        FROM session_mobile
    )
),
mobile_only AS (
    SELECT COUNT(DISTINCT user_id) AS num_mobile_only_users
    FROM session_mobile
    WHERE user_id NOT IN (
        SELECT DISTINCT user_id
        FROM session_web
    )
),
web_mobile AS (
    SELECT COUNT(DISTINCT user_id) AS num_web_mobile_users
    FROM session_mobile
    WHERE user_id IN (
        SELECT DISTINCT user_id
        FROM session_web
    )
)
SELECT *
FROM web_only, mobile_only, web_mobile
