/*
Instructions

Write a query to return the cumulative daily rentals for the following customers:
customer_id in (3, 4, 5).
Each day a user had a rental, return their total spent until that day.
If there is no rental on that day, ignore that day.
Table: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

    date    | customer_id | daily_rental | cumulative_rentals
------------+-------------+--------------+--------------------
 2020-05-27 |           3 |            1 |                  1
 2020-05-29 |           3 |            1 |                  2
 2020-06-16 |           3 |            2 |                  4
 2020-06-17 |           3 |            1 |                  5
 2020-06-19 |           3 |            1 |                  6
 2020-07-07 |           3 |            1 |                  7
 2020-07-08 |           3 |            1 |                  8
*/
WITH customer_rentals AS (
	SELECT 
	  DATE(rental_ts) date,
	  customer_id,
	  COUNT(*) AS daily_rental
	FROM rental
	WHERE customer_id IN (3,4,5)
	GROUP BY DATE(rental_ts), customer_id
)	

SELECT 
  date, 
  customer_id, 
  daily_rental, 
  SUM(daily_rental) OVER(PARTITION BY customer_id ORDER BY date) cumulative_rentals
FROM customer_rentals;
