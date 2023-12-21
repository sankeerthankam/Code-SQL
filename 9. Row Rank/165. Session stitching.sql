/*
If a user signs back in within 5 minutes, we want to combine the two sessions and only keep the first (smaller) session_id to represent the same sessions.
E.g., if a user logged in at 1 pm and was given a raw_session_id 1, logged back in again on 1:03 pm with a raw_session_id 2, we want to remove the raw_session_id 2 and only keep raw_session_id 1.
E.g., if a user logged in on 1 pm and was given a raw_session_id 1, logged back in again on 1:03 pm with a raw_session_id 2,  and logged back in again on 1:07, we want to remove both sessions 2 and 3 because all are in the same session.
If a user logged in at 1 pm and logged back in at 1:06 pm, we will not remove any session.
You can use EXTRACT(EPOCH FROM ts_2 - ts_1)/60 to get the number of minutes between 2 time stamps: ts_1 and ts_2, where ts_2 > ts_1.

Table: walmart_logins

Every time a user sign in to walmart.com, we take a snapshot and add a new raw_session_id

  col_name      | col_type
----------------+-------------------
cust_id         | bigint
login_ts        | timestamp
raw_session_id  | bigint
Sample results

customer_id | raw_session_id |      login_ts
-------------+----------------+---------------------
        8001 |          20001 | 2020-02-14 01:15:01
        8001 |          20003 | 2020-02-14 01:55:01
        8001 |          20004 | 2020-02-15 15:10:01
        8001 |          20008 | 2020-02-15 17:15:01
        8001 |          20010 | 2020-02-16 08:15:01
        8002 |          20011 | 2020-02-15 01:15:01
        8002 |          20013 | 2020-02-15 01:55:01
        8003 |          20014 | 2020-02-16 15:10:01
        8003 |          20016 | 2020-02-16 15:35:01
        8004 |          20017 | 2020-02-17 17:15:01
        8005 |          20019 | 2020-02-18 08:15:01
*/
WITH last_logins AS (
    SELECT customer_id, login_ts, raw_session_id,
    LAG(login_ts, 1) OVER(PARTITION BY customer_id ORDER BY login_ts) AS last_login_ts
    FROM walmart_logins
)
SELECT
    customer_id,
    raw_session_id,
    login_ts
FROM last_logins
WHERE TIMESTAMPDIFF(MINUTE, last_login_ts, login_ts) >= 5
OR last_login_ts IS NULL;
