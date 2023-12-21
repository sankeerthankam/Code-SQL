/*
Instructions:

Any customers who made at least 10 movie rentals are happy customers, write a query to return the dates when the following customers became happy customers:
customer_id in (1,2,3,4,5,6,7,8,9,10).
You can skip a customer if he/she never became a ‘happy customer'.
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

 customer_id |    date
-------------+------------
           1 | 2020-07-08
           2 | 2020-07-29
           3 | 2020-07-27
           4 | 2020-07-30
           5 | 2020-07-06
           6 | 2020-07-10
*/
WITH cust_rental_dates AS (
	SELECT   
	  customer_id,
	  DATE(rental_ts) date,
	  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY rental_ts) rental_idx
	FROM rental
	WHERE customer_id IN (1,2,3,4,5,6,7,8,9,10)
)
SELECT 
  customer_id, 
  date
FROM cust_rental_dates
WHERE rental_idx = 10;
