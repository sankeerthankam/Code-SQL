/*
If a customer purchased more than $8000 values of goods in his/her lifetime, we consider this customer our super fan and would like to offer him/her a one year free Amazon prime membership;
Write a query to return the dates when a user becomes a super fan.
 
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

 customer_id | first_date
-------------+------------
        1001 | 2021-08-31
        1004 | 2021-08-20
        1007 | 2021-08-25
*/
WITH daily_aggregate AS (
	SELECT order_dt, customer_id, SUM(unit_price_usd * qty) daily_spend
	  FROM orders
	GROUP BY order_dt, customer_id
),
cumulative_daily_spend AS (
 SELECT 
	customer_id, 
	order_dt, 
	SUM(daily_spend) OVER(PARTITION BY customer_id ORDER BY order_dt) cumulative_spend
  FROM daily_aggregate
 )
SELECT customer_id, MIN(order_dt) AS first_date
FROM cumulative_daily_spend
WHERE cumulative_spend > 8000
GROUP BY customer_id;
