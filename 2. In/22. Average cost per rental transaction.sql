/*
Instruction
Write a query to return the average cost on movie rentals in May 2020 per transaction.
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
 1.234567
*/

SELECT AVG(amount)
FROM payment
WHERE  DATE(payment_ts) >= '2020-05-01'
AND DATE(payment_ts) <= '2020-05-31';
