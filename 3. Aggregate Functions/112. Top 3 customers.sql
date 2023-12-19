/*
Write a query to return the top customer's customer_id, and their total spend.
Top customer: people who purchased the most by spend in $.
Table: orders 

An eCommerce company's online order table.

  col_name    | col_type
--------------+-------------------
order_id      | bigint
product_id    | bigint
customer_id   | bigint
order_dt      | date
qty           | integer
unit_price_usd| float
channel       | varchar(20) -- mobile, desktop
Sample results

 customer_id |       spend
-------------+-------------------
        1008 | 8589.499999999995
        1030 | 8562.439999999993
        1041 | 8393.839999999998
*/
SELECT 
    customer_id, 
    SUM(qty * unit_price_usd) AS spend
FROM orders
GROUP BY customer_id
ORDER BY SPEND DESC
LIMIT 3;
