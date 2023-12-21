/*
Instruction

Write a query to return a customer's life time value for the following: customer_id IN (1, 100, 101, 200, 201, 300, 301, 400, 401, 500).
Add a column to compute the average LTV of all customers from the same store.
Return 4 columns: customer_id, store_id, customer total spend, average customer spend from the same store.
The order of your results doesn't matter.
Hint

Assumptions: a customer can only be associated with one store.
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

 customer_id | store_id | ltd_spend |         avg
-------------+----------+-----------+----------------------
1	1	118.68	113.5015950920245399
100	1	102.76	113.5015950920245399
101	1	96.76	113.5015950920245399
200	2	136.73	111.4102197802197802
*/
WITH customer_ltd_spend AS (
	SELECT 
	    P.customer_id, 
	    MAX(store_id) store_id, 
	    SUM(P.amount) ltd_spend
	FROM payment P
	INNER JOIN customer C
	ON C.customer_id = P.customer_id
	GROUP BY P.customer_id
)

SELECT customer_id, store_id, ltd_spend, store_avg 
FROM (
	SELECT
	    customer_id,
	    store_id,
	    ltd_spend,
	    AVG(ltd_spend) OVER(PARTITION BY store_id) as store_avg
	FROM customer_ltd_spend CLS
) X
WHERE X.customer_id IN (1,100,101, 200, 201, 300,301, 400, 401, 500)
ORDER BY 1;
