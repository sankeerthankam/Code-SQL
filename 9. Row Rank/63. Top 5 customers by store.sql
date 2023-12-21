/*
Instruction

Write a query to return the top 5 customer ids and their rankings based on their spending for each store.
The order of your results doesn't matter.
If there are ties, give them the same 'ranking'.
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

 store_id | customer_id | revenue | ranking
----------+-------------+---------+---------
        1 |         148 |  216.54 |       1
        1 |         144 |  195.58 |       2
        1 |         459 |  186.62 |       3
        1 |         468 |  175.61 |       4
        1 |         236 |  175.58 |       5
        2 |         526 |  221.55 |       1
        2 |         178 |  194.61 |       2
        2 |         137 |  194.61 |       2
        2 |         469 |  177.60 |       3
        2 |         181 |  174.66 |       4
        2 |         259 |  170.67 |       5
*/
WITH cust_revenue AS (
  SELECT 
    C.customer_id, 
    MAX(store_id) store_id,
    SUM(amount) revenue
  FROM customer C
  INNER JOIN payment P
  ON P.customer_id = C.customer_id
  GROUP BY C.customer_id
)
SELECT * FROM (
  SELECT 
    store_id,
    customer_id,
    revenue,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY revenue DESC) ranking
  FROM cust_revenue
) X
WHERE ranking <= 5;
