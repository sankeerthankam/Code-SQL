/*
Instruction

Write a query to return DoD(day over day) growth for each store from May 25 (inclusive) to May 31 (inclusive).
DoD: (current_day/ prev_day -1) * 100.0
Multiply dod growth to 100.0 to get percentage of growth.
Use ROUND to convert dod growth to the nearest integer.
For simplicity, it's safe to assume there were revenue at each day for each store
Hint

To save you some time, use the following CTE to create a store's daily revenue:
WITH store_daily_rev AS (
  SELECT 
    I.store_id, 
    DATE(P.payment_ts) date,
    SUM(amount) AS daily_rev
  FROM 
    payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id
  WHERE DATE(P.payment_ts) >= '2020-05-01'
  AND DATE(P.payment_ts) <= '2020-05-31'
  GROUP BY I.store_id, DATE(P.payment_ts)
)

Table 1: inventory 

Each row is unique, inventoy_id is the primary key of this table.

   col_name   | col_type
--------------+--------------------------
 inventory_id | integer
 film_id      | smallint
 store_id     | smallint
Table 2: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Table 3: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 store_id |    date    | dod_growth
----------+------------+------------
        1 | 2020-05-24 |       null   
        1 | 2020-05-25 |       2058
        1 | 2020-05-26 |        137
        1 | 2020-05-27 |         74
        1 | 2020-05-28 |        166
        1 | 2020-05-29 |         62
        1 | 2020-05-30 |        109
        1 | 2020-05-31 |        107
        2 | 2020-05-24 |        null
        2 | 2020-05-25 |       1794
*/
WITH store_daily_rev AS (
  SELECT 
    I.store_id, 
    DATE(P.payment_ts) date,
    SUM(amount) AS daily_rev
  FROM 
    payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id
  WHERE DATE(P.payment_ts) >= '2020-05-01'
  AND DATE(P.payment_ts) <= '2020-05-31'
  GROUP BY I.store_id, DATE(P.payment_ts)
)
SELECT 
  store_id,
  date,
  ROUND( (daily_rev / LAG(daily_rev, 1) OVER(PARTITION BY store_id ORDER BY date) -1) * 100.0 ) AS dod_growth
FROM store_daily_rev;
