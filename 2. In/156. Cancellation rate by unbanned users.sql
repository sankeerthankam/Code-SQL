/*
Write a query to calculate the overall trip cancellation rate from unbanned users only
Both drivers and clients must have been unbanned when the request was made.
Table 1: rideshare_trips 

  col_name       | col_type
-----------------+---------------------
id               | bigint   
client_id        | bigint
driver_id        | bigint
status           | varchar(20) -- 'completed', 'cancelled by driver', 'cancelled by client'
request_dt       | date

Table 2: rideshare_users

All users on the ridesharing platform. If a user has two roles, they will have multiple rows, e.g., one row for the client, one row for the driver with different user_id.

  col_name       | col_type
-----------------+---------------------
user_id          |  bigint   
role             |  varchar(10) -- 'client' or 'driver'
joined_at        |  timestamp  -- when the user account is created
banned_at        |  timestamp -- when the user accounts is banned, null if not banned



Sample results

   completion_rate
---------------------
 87.5000000000000000
*/
WITH banned_clients AS (
    SELECT user_id, banned_at
    FROM rideshare_users
    WHERE banned_at IS NOT NULL
    AND role = 'client'
),
banned_drivers AS (
    SELECT user_id, banned_at
    FROM rideshare_users
    WHERE banned_at IS NOT NULL
    AND role = 'driver'
)
SELECT
    100 - COUNT(CASE WHEN status = 'completed' THEN ID ELSE NULL END) * 100.0 / COUNT(*) AS cancellation_rate
FROM rideshare_trips T
LEFT JOIN banned_clients C
ON C.user_id = T.client_id
AND request_dt > C.banned_at
LEFT JOIN banned_drivers D
ON D.user_id = T.driver_id
AND request_dt > D.banned_at
WHERE C.user_id IS NULL
AND D.user_id IS NULL
;
