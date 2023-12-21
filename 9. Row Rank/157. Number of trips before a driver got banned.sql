/*
Write a query to return the average number of trips before a driver is banned.
Skip those drivers who never got banned.
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

     avg_trips
--------------------
 1.5000000000000000
(1 row)

*/
WITH banned_drivers AS (
    SELECT
        driver_id,
        ROW_NUMBER() OVER(PARTITION BY driver_id ORDER BY request_dt) rn
    FROM rideshare_trips T
    INNER JOIN rideshare_users U
    ON T.driver_id = U.user_id
    WHERE banned_at IS NOT NULL
    AND request_dt < banned_at
),
num_trips_before_banned AS (
    SELECT driver_id, MAX(rn) AS num_trips
    FROM banned_drivers
    GROUP BY driver_id
)
SELECT AVG(num_trips) avg_trips
FROM  num_trips_before_banned
;
