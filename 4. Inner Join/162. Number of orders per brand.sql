/*
Write a query to return the total number of orders per brand in Aug 2021.
If a brand doesn't have any order, return 0.
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

 brand_id | count
----------+-------
     1001 |    10
     1002 |     5
     1003 |     3
*/
SELECT B.brand_id, COUNT(order_id) AS cnt
FROM walmart_order O
INNER JOIN walmart_brand B
ON B.product_id = O.product_id
WHERE order_dt >= '2021-08-01'
AND   order_dt <= '2021-08-31'
GROUP BY B.brand_id;
