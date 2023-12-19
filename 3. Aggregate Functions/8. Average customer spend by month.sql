/*
Instruction

Write a query to return the average customer spend by month.
Definition: average customer spend: total customer spend divided by the unique number of customers for that month.
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.
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

year	mon	avg_spend
2020	2	3.2543037974683544
2020	5	9.1301559454191033
*/
SELECT
	EXTRACT(YEAR FROM payment_ts) AS year,
	EXTRACT(MONTH FROM payment_ts) AS mon,
	SUM(amount)/COUNT(DISTINCT customer_id) AS avg_spend
FROM payment
GROUP BY year, mon
ORDER BY year, mon;
