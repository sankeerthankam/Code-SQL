/*
Instructions

Write a query to return the cumulative daily spend for the following customers:
customer_id in (1, 2, 3).
Each day a user has a rental, return their total spent until that day.
If there is no rental on that day, you can skip that day.
Table: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Sample results

    date    | customer_id | daily_spend | cumulative_spend
------------+-------------+-------------+------------------
 2020-05-25 |           1 |        2.99 |             2.99
 2020-05-28 |           1 |        0.99 |             3.98
 2020-06-15 |           1 |       16.97 |            20.95
 2020-06-16 |           1 |        4.99 |            25.94
 2020-06-18 |           1 |        5.98 |            31.92
 2020-06-21 |           1 |        3.99 |            35.91
 2020-07-08 |           1 |       11.98 |            47.89
 2020-07-09 |           1 |        9.98 |            57.87
 2020-07-11 |           1 |        7.99 |            65.86
 2020-07-27 |           1 |        2.99 |            68.85
*/
WITH customer_spend AS (
	SELECT 
	  DATE(payment_ts) date,
	  customer_id,
	  SUM(amount) AS daily_spend
	FROM payment
	WHERE customer_id IN (1, 2, 3)
	GROUP BY DATE(payment_ts), customer_id
)	

SELECT 
  date, 
  customer_id, 
  daily_spend, 
  SUM(daily_spend) OVER(PARTITION BY customer_id ORDER BY date) cumulative_spend
FROM customer_spend;
