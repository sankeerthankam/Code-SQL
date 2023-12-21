/*
For each user, find the number of days gap between their last action and the second last action.
e.g., if the last 2 actions are on '2021-08-01' and '2021-08-02', the gap is 1
If the last 2 actions happen on the same day, the gap is 0
Definition of action: any event that is not an enter nor an exit.
If a user has no action, or fewer than 2 actions, skip this user.
Table: session_web 

Every time a user visits the website, a new session starts, it ends when the user leaves the site.

  col_name       | col_type
-----------------+---------------------
date             | date    
user_id          | bigint
session_id       | bigint
event            | varchar(20)

Sample results

   user_id    |   delta
--------------+--------
8000001       | 1


*/
-- Solution updated by courtesy of Will, who pointed our the bug when calculating date differences in MySQL.
-- See discussion here:https://sqlpad.io/forum/question/235/question-105-subtracting-dates-vs-datediff-mysql/

WITH ordered_actions AS (
    SELECT user_id, date, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY date DESC) AS nth_action
    FROM session_web
    WHERE event NOT IN ('enter', 'exit')
),
last_action AS (
    SELECT user_id, date, nth_action
    FROM ordered_actions
    WHERE nth_action = 1
),
second_last_action AS (
    SELECT user_id, date, nth_action
    FROM ordered_actions
    WHERE nth_action = 2
)
SELECT L.user_id, DATEDIFF(L.date, S.date) AS days_gap
FROM last_action L
INNER JOIN second_last_action S
ON S.user_id = L.user_id;
