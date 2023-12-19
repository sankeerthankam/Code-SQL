/*
Instruction

Write a query to return the first and last name of the customer who spent the most on movie rentals in Feb 2020.
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
Sample results

first_name | last_name
-----------+-----------
 JAMES     | BOND
*/
WITH cust_feb_spend AS (
	SELECT 
		customer_id,
		SUM(amount) AS cust_amt
	FROM payment
	WHERE DATE(payment_ts) >= '2020-02-01'
	AND DATE(payment_ts) <= '2020-02-29'
	GROUP BY customer_id
	ORDER BY cust_amt DESC
	LIMIT 1
)
SELECT first_name, last_name 
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM cust_feb_spend
);
