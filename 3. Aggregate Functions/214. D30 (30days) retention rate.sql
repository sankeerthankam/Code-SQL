/*
Today is April 30, 2023.
Write a query to calculate D30 (Day 30) retention rate.
To calculate the D30 retention rate on April 30, 2023, first identify users who created their accounts on April 1, 2023.
Then, we'll determine how many of those users were still active on April 30, 2023.
Active user: user with a session at least 10 seconds long.
 
Table 1: roblox_account

Roblox account creation records.

   col_name              | col_type
-------------------------+--------------------------
  user_id                | uuid
  created_at             | timestamp
Table 2: roblox_session

User sessions log.

   col_name              | col_type
-------------------------+--------------------------
  session_id             | uuid
  user_id                | uuid
  started_at             | timestamp
  ended_at               | timestamp
Sample results

   retention_rate
---------------------
 27.2727272727272727
*/
WITH new_users AS (
    -- Users who created accounts on April 1, 2023
    SELECT DISTINCT user_id
    FROM roblox_account
    WHERE DATE(created_at) = '2023-04-01'
),

active_users AS (
    -- Users from the April 1 cohort who had sessions on April 30, 2023
    -- lasting at least 10 seconds
    SELECT DISTINCT user_id
    FROM roblox_session
    WHERE DATE(started_at) = '2023-04-30'
    AND TIMESTAMPDIFF(SECOND, started_at, ended_at) >= 10
    AND user_id IN (SELECT user_id FROM new_users)
)

-- Calculate D30 retention rate
SELECT
    (SELECT COUNT(*) FROM active_users) * 100.0/
    (SELECT COUNT(*) FROM new_users) AS retention_rate;
