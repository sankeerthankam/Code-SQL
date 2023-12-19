/*
Instruction

Write a query to return the minimum and maximum customer total spend in June 2020.
For each customer, first calculate their total spend in June 2020.
Then use MIN, and MAX function to return the min and max customer spend .
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

min_spend | max_spend
-----------+-----------
      0.99 |     52.90
*/
WITH cust_tot_amt AS (
    SELECT
        customer_id,	
        SUM(amount) AS tot_amt
    FROM payment
    WHERE DATE(payment_ts) >= '2020-06-01'
    AND DATE(payment_ts) <= '2020-06-30'
    GROUP BY customer_id
)
SELECT 
    MIN(tot_amt) AS min_spend, 
    MAX(tot_amt) AS max_spend
FROM cust_tot_amt;
