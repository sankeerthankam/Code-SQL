/*
Write a query that returns the third-order date for each customer.

If a user ordered fewer than 3 times, return NULL

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

 customer_id | third_order_date
-------------+------------------
        8001 |
        8002 | 2021-07-03
        8003 | 2021-07-02
        8004 | 2021-07-02
*/
WITH nth_order AS (
    SELECT customer_id, date, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY date) order_index
    FROM ap_order
)
SELECT customer_id, MAX(CASE WHEN order_index = 3 THEN date ELSE NULL END) AS third_order_date
FROM nth_order
GROUP BY customer_id
;
