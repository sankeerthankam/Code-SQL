/*
Write a query to return the top 3 account_id who created the most active sessions by month.
Active session: session longer than 10 seconds
Ties: return all of them
Table: roblox_session

User sessions log.

   col_name              | col_type
-------------------------+--------------------------
  session_id             | uuid
  user_id                | uuid
  started_at             | timestamp
  ended_at               | timestamp
Sample results

               user_id                | year | month | active_sessions_count
--------------------------------------+------+-------+-----------------------
 bd4060c6-b5bd-48c7-bb74-8082f6255590 | 2023 |     3 |                    29
 6ce61b14-9844-43d1-aee5-3b19cc66f40b | 2023 |     3 |                    29
 da2a61e0-0062-40ab-ae2b-3e45a6ff8047 | 2023 |     3 |                    28
*/


WITH monthly_active_sessions AS (
    SELECT
        user_id,
        YEAR(started_at) AS year,
        MONTH(started_at) AS month,
        COUNT(*) AS active_sessions_count
    FROM
        roblox_session
    WHERE
        TIMESTAMPDIFF(SECOND, started_at, ended_at) > 10
    GROUP BY
        user_id,
        YEAR(started_at),
        MONTH(started_at)
)

, rankings AS (
    SELECT
        user_id,
        year,
        month,
        active_sessions_count,
        RANK() OVER(PARTITION BY year, month ORDER BY active_sessions_count DESC) AS rnk
    FROM
        monthly_active_sessions
)

SELECT
    user_id,
    year,
    month,
    active_sessions_count
FROM
    rankings
WHERE
    rnk <= 3
ORDER BY
    year, month, rnk;


