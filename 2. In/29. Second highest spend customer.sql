/*
Instruction

Write a query to return the name of the customer who spent the second-highest for movie rentals in May 2020.
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
------------+-----------
 MARK       | ZUCKERBERG
*/

WITH second_cust_spend_may AS (
    SELECT customer_id,
    SUM(amount) AS cust_spend
    FROM payment
    WHERE payment_ts >= '2020-05-01'
    AND payment_ts < '2020-06-01'
    GROUP BY customer_id
    ORDER BY cust_spend DESC
    LIMIT 1
    OFFSET 1
)
SELECT 
    first_name, 
    last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM second_cust_spend_may
);
