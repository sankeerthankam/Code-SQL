/*
Write a query to return the most popular product for each product category by quantity
Hint: a customer may purchase the same product more than once in the same order (qty column)
For simplicity, we assume there is no tie.
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

 product_category_id | product_id | quantities 
---------------------+------------+------------+---------
                   1 |   10000005 |        132        
                   2 |   10000018 |        125        
                   3 |   10000053 |        118        
*/
WITH prod_cat_qty AS (    
    SELECT product_category_id, O.product_id, SUM(qty) AS quantities
    FROM orders O
    INNER JOIN product_category C
    ON C.product_id = O.product_id
    GROUP BY product_category_id, O.product_id
)

SELECT product_category_id, product_id, quantities
FROM (
	SELECT product_category_id, product_id, quantities, RANK() OVER(PARTITION BY product_category_id ORDER BY quantities DESC) as ranking
	FROM prod_cat_qty
) X
WHERE X.ranking=1;
