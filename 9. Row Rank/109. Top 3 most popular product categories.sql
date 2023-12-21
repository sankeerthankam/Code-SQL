/*
Write a query to return the top 3 most popular product categories by the number of orders
Table 1: orders 

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
Table 2: product_category 

One product can only belong to one category

  col_name            | col_type
----------------------+-------------------
product_id            | bigint
product_category_id   | smallint

Sample results

 product_category_id | ranking
---------------------+------------------
3                    |  1
2                    |  2
4                    |  3
*/
WITH prod_cat_orders AS (
    SELECT product_category_id, COUNT(*) AS num_orders
    FROM orders O
    INNER JOIN product_category C
    ON C.product_id = O.product_id
    GROUP BY product_category_id
)

SELECT 
    product_category_id, 
    RANK() OVER(ORDER BY num_orders DESC) AS ranking
FROM prod_cat_orders
LIMIT 3;
