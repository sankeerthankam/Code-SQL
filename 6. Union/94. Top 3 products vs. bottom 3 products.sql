/*
Instructions:

Write a query to return the top 3 and bottom 3 products in August 2021 ranked by sales.
sales = sum(unit_price_usd * qty) .
ordering of your results is not considered
Hint

Make sure you clarify with the interviewer on how to deal with ties
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

 product_id | category
------------+----------
   10000045 | top
   10000060 | top
   10000067 | top
   10000089 | bottom
   10000036 | bottom
   10000065 | bottom
*/
WITH top AS(
	SELECT product_id, SUM(unit_price_usd * qty)
	FROM orders
        WHERE order_dt >= '2021-08-01'
        AND order_dt < '2021-09-01'
	GROUP BY product_id
	ORDER BY SUM(unit_price_usd * qty) DESC 
	LIMIT 3
), 
bottom AS (
	SELECT product_id, SUM(unit_price_usd * qty) 
	FROM orders
        WHERE order_dt >= '2021-08-01'
        AND order_dt < '2021-09-01'
	GROUP BY product_id
	ORDER BY SUM(unit_price_usd * qty) 
	LIMIT 3
)
SELECT top.product_id, 'top'  AS category
FROM top
UNION ALL
SELECT bottom.product_id, 'bottom' AS category
FROM bottom;
