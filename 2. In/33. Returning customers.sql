/*
Instruction

Write a query to return the number of customers who rented at least one movie in both May 2020 and June 2020.
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

 count
-------
   123
*/

WITH may_cust AS (
	SELECT DISTINCT customer_id AS may_cust_id
	FROM rental
	WHERE DATE(rental_ts) >= '2020-05-01'
    AND   DATE(rental_ts) <= '2020-05-31'
)

SELECT COUNT(DISTINCT customer_id)
FROM rental 
WHERE DATE(rental_ts) >= '2020-06-01'
AND   DATE(rental_ts) <= '2020-06-30'
AND  customer_id IN (
    SELECT may_cust_id
    FROM may_cust
);
