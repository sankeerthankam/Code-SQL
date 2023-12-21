/*
Write a query to calculate the number of monthly active users in July and August 2021.
Active User: if a user has at least one non-enter, or non-exit event (e.g., tap) on either web or mobile.
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

   year    |   mon  | mau
-----------+--------+--------
2021       | 7      | 123
2021       | 8      | 234
*/
WITH session AS (
    SELECT * FROM session_web
    WHERE event NOT IN ('enter', 'exit')
    UNION ALL
    SELECT * FROM session_mobile
    WHERE event NOT IN ('enter', 'exit')
)
SELECT
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS mon,
    COUNT(DISTINCT user_id) AS mau
FROM session
GROUP BY 1,2;
