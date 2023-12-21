/*
Instructions
Write a query to return the spend amount difference between the last and the second last movie rentals for the following customers:
customer_id IN (1,2,3,4,5,6,7,8,9,10).
Skip customers if they made less than 2 rentals.
Hint
Use ROW_NUMBER to determine the sequence of movie rental
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

 customer_id | delta
-------------+-------
           1 |  3.00
           2 |  0.00
           3 |  2.00
           4 | -1.00
           5 | -2.00
*/
WITH cust_spend_seq AS (
	SELECT 
	  customer_id,
	  payment_ts,
	  amount AS current_payment,
	  LAG(amount, 1) OVER(PARTITION BY customer_id ORDER BY payment_ts) AS prev_payment,
	  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY payment_ts DESC) AS payment_idx
	FROM payment P
)
SELECT
    customer_id,
    current_payment - prev_payment AS delta
FROM cust_spend_seq
WHERE customer_id IN(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
AND payment_idx = 1;
