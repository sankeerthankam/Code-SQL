/*
Instruction
Write a query to return the number of customers in 3 separate groups: high, medium, low.
The order of your results doesn't matter.
Definition
high: movie rental spend >= $150.
medium: movie rental spend >= $100, <$150.
low: movie rental spend <$100.
Hint
If a customer spend 0 in movie rentals, he/she belongs to the low group.
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

customer_group | count
---------------+-------
 high          |   123
 medium        |   456
 low           |   789
*/
SELECT customer_group, COUNT(*) 
FROM (
	SELECT 
		C.customer_id,
	    CASE WHEN SUM(P.amount) >= 150 THEN 'high'
	         WHEN SUM(P.amount) >= 100 THEN 'medium'
	         ELSE 'low' END customer_group
	FROM customer C
	LEFT JOIN payment P
	ON P.customer_id = C.customer_id
	GROUP BY C.customer_id
) X
GROUP BY customer_group
;
