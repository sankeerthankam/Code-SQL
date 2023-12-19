/*
Write a query to compute the average number of sessions per user per day in August 2021.
Definition: a visit = a unique session
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 2: session_web 

Every time a user visits the website, a new session starts, it ends when the user leaves the site.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Sample results

    date    |   avg_session_per_user
------------+--------------
 2021-01-01 | 1.51
 2021-01-02 | 1.23
*/
SELECT D.date, COUNT(DISTINCT session_id) * 1.0 /COUNT(DISTINCT user_id) AS avg_session_per_user
FROM dates D
LEFT JOIN  session_web W
ON D.date = W.date
WHERE D.date >= '2021-08-01'
AND D.date <= '2021-08-31'
GROUP BY D.date;
