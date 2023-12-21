/*
Instruction

Write a query to return the difference of the spend amount between the following customers' first movie rental and their second rental.
customer_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10).
Use first spend - second spend to compute the difference.
Skip users who only rented once.
Hint:

You can use ROW_NUMBER to identify the first and second transactions.
You can use LAG or LEAD to find previous or following transaction amount.
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
           1 |  2.00
           2 |  2.00
           3 | -1.00
           4 |  4.00
           5 |  0.00
*/
SELECT customer_id,
    prev_amount - current_amount AS delta
FROM (
	SELECT 
	  customer_id,
	  payment_ts,
	  amount as current_amount,
	  LAG(amount, 1) OVER(PARTITION BY customer_id ORDER BY payment_ts ) AS prev_amount,
	  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY payment_ts) AS payment_idx
	FROM payment
	WHERE customer_id IN
	(1,2,3,4,5,6,7,8,9,10)
) X
WHERE payment_idx = 2;
