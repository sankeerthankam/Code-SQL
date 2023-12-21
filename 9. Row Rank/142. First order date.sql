/*
Write a query that returns the first order date for each customer id.

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

 customer_id |    date
-------------+------------
        8001 | 2021-08-22
        8002 | 2021-07-01
        8003 | 2021-07-02
        8004 | 2021-07-02
        8005 | 2021-07-01
*/
WITH nth_order AS (
    SELECT customer_id, date, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY date) order_index
    FROM ap_order
)
SELECT customer_id, date
FROM nth_order
WHERE order_index = 1;
