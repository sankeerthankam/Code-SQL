/*
Write a query to report monthly active users

Active user: user with a session at least 10 seconds long.

Table: roblox_session

User sessions log.

   col_name              | col_type
-------------------------+--------------------------
  session_id             | uuid
  user_id                | uuid
  started_at             | timestamp
  ended_at               | timestamp
Sample results

 year | month | monthly_active_users
------+-------+----------------------
 2023 |     3 |                 1856
 2023 |     4 |                 3534

*/
SELECT
    YEAR(started_at) AS year,
    MONTH(started_at) AS month,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM
    roblox_session
WHERE
    TIMESTAMPDIFF(SECOND, started_at, ended_at) >= 10
GROUP BY
    YEAR(started_at),
    MONTH(started_at)
ORDER BY
    year, month;
