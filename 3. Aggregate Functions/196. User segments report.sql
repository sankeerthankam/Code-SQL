/*
Write a query to report the number of users by the following buckets.

Assuming today is 2021-04-01.

New: users that just signed up on 2021-04-01
Churned: signed up before 2021-03-18, but not active for the last 14 days: 2021-03-18 - 2021-03-31 (inclusively);
Resurrected: churned the day before 2021-04-01 but became active today(2021-04-01)
Retained: active today and not resurrected.
Table 1: snap_account 

Users signup dates.

   col_name     | col_type
----------------+--------------------------
 user_id        | bigint
 signup_dt      | date
Table 2: snap_dau 

List of unique users and dates when they are active.

   col_name     | col_type
----------------+--------------------------
 user_id        | bigint
 active_dt      | date
Sample results

 new | churned | resurrected | retained
-----+---------+-------------+----------
   5 |      47 |           2 |        7
*/
WITH new_users AS (
    SELECT user_id
    FROM snap_account
    WHERE signup_dt = '2021-04-01'
),
churned_users AS (
    SELECT user_id
    FROM snap_account
    WHERE signup_dt < '2021-03-18'
    AND user_id NOT IN (
                SELECT user_id
                FROM snap_dau
                WHERE active_dt >= '2021-03-18'
                AND active_dt < '2021-04-01' )
),
resurrected_users AS (
  SELECT user_id
  FROM snap_account
  WHERE signup_dt < '2021-03-17'
  AND user_id NOT IN (
                SELECT user_id
                FROM snap_dau
                WHERE active_dt >= '2021-03-17'
                AND active_dt < '2021-03-31' )
    AND user_id IN (
        SELECT user_id
        FROM snap_dau
        WHERE active_dt = '2021-04-01'
    )
),
retained_users AS (
    SELECT user_id
    FROM snap_dau
    WHERE active_dt = '2021-04-01'
    AND NOT user_id IN (
        SELECT user_id
        FROM resurrected_users
    )
)
SELECT
  (SELECT  COUNT(*) FROM new_users ) AS new,
  (SELECT  COUNT(*) FROM churned_users) AS churned,
  (SELECT  COUNT(*) FROM resurrected_users) AS resurrected,
  (SELECT  COUNT(*) FROM retained_users) AS retained
;
