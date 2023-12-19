/*
This is a follow up question to #216.

Instead of reporting top 3 users who started the most sessions, use total spend time to rank them.

Table: roblox_session

User sessions log.

   col_name              | col_type
-------------------------+--------------------------
  session_id             | uuid
  user_id                | uuid
  started_at             | timestamp
  ended_at               | timestamp
Sample results

               user_id                | year | month | total_time_spent
--------------------------------------+------+-------+------------------
 da2a61e0-0062-40ab-ae2b-3e45a6ff8047 | 2023 |     3 |    340800.000000
 679138aa-483f-4cc6-80dd-098703a59d94 | 2023 |     3 |    339840.000000
 6ca42905-9239-4943-a6fb-d0e02c54ff6c | 2023 |     3 |    326580.000000
 1128f058-8b2d-4f3c-ab53-fde35b35b14e | 2023 |     4 |    408997.000000
 4fbd9736-1f49-4c37-838e-3ae026f76dd2 | 2023 |     4 |    390240.000000
 8ef815eb-b700-4c9b-8850-be468dcccfa4 | 2023 |     4 |    388560.000000

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
