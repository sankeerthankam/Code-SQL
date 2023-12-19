/*
Instruction
Write a query to return the first and last name of the customer who made the most rental transactions in May 2020.
Table 1: customer 

  col_name   | col_type
-------------+--------------------------
 customer_id | integer
 store_id    | smallint
 first_name  | text
 last_name   | text
 email       | text
 address_id  | smallint
 activebool  | boolean
 create_date | date
 active      | integer
Table 2: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 first_name | last_name
------------+-----------
 JENNIFER   | ANISTON
*/
WITH cust_may_rentals AS (
	SELECT 
		customer_id,
		COUNT(*) AS cust_rentals
	FROM rental
	WHERE DATE(rental_ts) >= '2020-05-01'
	AND DATE(rental_ts) <= '2020-05-31'
	GROUP BY customer_id
	ORDER BY cust_rentals DESC
	LIMIT 1
)
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM cust_may_rentals
);
