/*
Write a query to find all users who have watched less than 1 hour of content (< 3600 seconds) within one week of creating their accounts.

Table 1: netflix_account 

 col_name    | col_type
-------------+---------------------
 account_id  | bigint
 country     | character varying(2)
 created_dt  | date

Table 2: netflix_daily_streaming 

Daily aggregated watch time by account by content.

  col_name    | col_type
--------------+---------------------
 date         | date
 account_id   | bigint
 content_id   | bigint
 duration     | int -- in seconds
Sample results

 account_id | watch_time_in_seconds
------------+-----------------------
    8000022 |                  1584
    8000194 |                  1767
    8000065 |                  2141
    8000053 |                  1019
*/
SELECT A.account_id, SUM(COALESCE(S.duration, 0)) watch_time_in_seconds
FROM netflix_account A
LEFT JOIN netflix_daily_streaming S
ON S.account_id = A.account_id
AND DATEDIFF(S.date, A.created_dt) <= 7
GROUP BY A.account_id
HAVING SUM(COALESCE(S.duration, 0)) < 3600;
