/*
Write a query to return the number of customers who made their second purchase within the same day of their first purchase.
Table: ap_order 

Afterpay's order table

  col_name      | col_type
----------------+-------------------
id              | bigint
date            | date
customer_id     | bigint
merchant_id     | bigint
order_channel   | varchar(10)
purchase_amount | float

Sample results

 count
-------
    17
(1 row)
*/
WITH nth_order AS (
    SELECT customer_id, date, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY date) order_index
    FROM ap_order
),
first_two_orders AS (
    SELECT customer_id,
        MAX(CASE WHEN order_index = 1 THEN date ELSE NULL END) AS first_buy_date,
        MAX(CASE WHEN order_index = 2 THEN date ELSE NULL END) AS second_buy_date
    FROM nth_order
    GROUP BY customer_id
)
SELECT COUNT(*)
FROM first_two_orders
WHERE first_buy_date - second_buy_date = 0
;
