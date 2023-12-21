/*
Write a query to report the average number of orders per brand in Aug 2021.
Table 1: walmart_brand 

  col_name    | col_type
--------------+-------------------
brand_id      | bigint
brand_name    | text
product_id    | bigint

Table 2: walmart_order 

  col_name    | col_type
--------------+-------------------
order_id      | bigint
product_id    | bigint
order_dt      | date
qty           | integer

Sample results

        avg
--------------------
 5.0000000000000000
(1 row)
*/
SELECT COUNT(order_id) * 1.0 / COUNT(DISTINCT B.brand_id) AS avg
FROM walmart_brand B
LEFT JOIN  walmart_order O
ON B.product_id = O.product_id
WHERE order_dt >= '2021-08-01'
AND   order_dt <= '2021-08-31'
;
