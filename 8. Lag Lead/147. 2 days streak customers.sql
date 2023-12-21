/*
If a user continuously uses our app for more than 2 days, e.g., if a user used the app on 2021-08-01 and also 2021-08-02, we call it a 2 days streak, if a user used the app on 2021-08-01 but didn't come back on 2021-08-02, then it's not a 2-day streak.
Write a query to find all customers who had a 2-day streak in August 2021.
A user used the app when he/she has an event that is not an 'enter' or 'exit' event.
Table: session_mobile 

Every time a user opens the mobile app (iOS, Android), a new session starts, it ends when the user leaves the app.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Sample results

user_id
---------
 8000001
 8000002
 8000003
 8000004
 8000005
 8000006
*/
WITH two_continuous_visits AS (
    SELECT user_id, date,  LAG(date, 1)  OVER(PARTITION BY user_id ORDER BY date) last_visit_date
    FROM session_mobile
    WHERE event NOT IN ('enter', 'exit')
    AND date >= '2021-08-01'
    AND date <= '2021-08-31'
)
SELECT user_id
FROM two_continuous_visits
WHERE date IS NOT NULL
AND (date - last_visit_date) = 1
GROUP BY user_id
ORDER BY 1;
