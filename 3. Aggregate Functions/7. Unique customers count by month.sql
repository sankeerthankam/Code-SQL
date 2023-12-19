/*
Instruction
Write a query to return the total number of unique customers for each month
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.
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

 year | mon | uu_cnt
------+-----+--------
 2020 |   1 |    123
 2020 |   2 |    456
 2020 |   3 |    789
*/
SELECT 
	EXTRACT(YEAR FROM rental_ts) AS year,
	EXTRACT(MONTH FROM rental_ts) AS mon,
	COUNT(DISTINCT customer_id) AS uu_cnt
FROM rental
GROUP BY year, mon;
