/*
This is a follow-up question to #194
Write a query to report month-over-month active user growth from April 2021 to April 2022 (the product was first launched in March 1, 2021)
MAU: monthly active user.  A user with at least one event from the snap_session table.
Formula: mom growth: (current_month_mau - last_month_mau) *100.0 / last_month_mau  
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 2: snap_session 

   col_name     | col_type
----------------+--------------------------
 user_id        | bigint
 event          | text 
 dt
*/
WITH mau AS (
    SELECT D.year, D.month, count(DISTINCT S.user_id) active_users
    FROM dates D
    LEFT JOIN snap_session S
    ON D.date = S.dt
    WHERE D.date >= '2021-03-01'
    AND D.date <= '2022-04-30'
    GROUP BY 1, 2
), mau_growth AS (
    SELECT year, month, (active_users - LAG(active_users, 1) OVER (ORDER BY year, month)) * 100.0/ LAG(active_users, 1) OVER (ORDER BY year, month) AS mom_growth
    FROM mau
)
SELECT year, month, mom_growth
FROM mau_growth
WHERE mom_growth IS NOT NULL;
