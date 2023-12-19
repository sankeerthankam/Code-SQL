/*
Instruction

Write a query to return the average movie rental spend per customer in Feb 2020.
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

        avg
--------------------
1.23456789
*/
WITH cust_feb_spend AS (
  SELECT customer_id,
      SUM(amount) cust_spend
  FROM payment
  WHERE DATE(payment_ts ) >= '2020-02-01'
  AND DATE(payment_ts ) <= '2020-02-28'
  GROUP BY customer_id
)
SELECT AVG(cust_spend)
FROM cust_feb_spend
;
