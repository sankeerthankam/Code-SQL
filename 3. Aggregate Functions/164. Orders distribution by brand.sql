/*
Create a histogram for brand orders in Aug 2021 with the following groups:
Low: <= 3 orders
Medium: > 3, <= 8 orders
High: > 8 orders
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

 brand_category | count
----------------+-------
 High           |     1
 Low            |     2
 Medium         |     2
*/
WITH brand_sales AS (
    SELECT B.brand_id, COUNT(order_id) AS cnt
    FROM walmart_order O
    INNER JOIN walmart_brand B
    ON B.product_id = O.product_id
    WHERE order_dt >= '2021-08-01'
    AND   order_dt <= '2021-08-31'
    GROUP BY B.brand_id
)
SELECT CASE WHEN cnt <=3 THEN 'Low'
                      WHEN cnt < 8 THEN 'Medium'
                      WHEN cnt >= 8 THEN 'High'
                      ELSE NULL END AS brand_category,
        COUNT(*)
FROM brand_sales
GROUP BY 1;
