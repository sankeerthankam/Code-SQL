/*
For each day compute the rolling 7 days average revenue
Rolling 7 days: 6 days before + this day
HINT: x rows rolling average window in Postgres syntax
AVG(col1) OVER(ORDER BY col2 ROWS BETWEEN x-1 PRECEDING AND CURRENT ROW)
If there aren't 7 days before a row, use all days available.
For simplicity, we assume there were at least one order every day.
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

  order_dt  |        avg
------------+--------------------
 2021-08-01 |  7834.779999999989
 2021-08-02 |  6499.039999999994
 2021-08-03 |  6587.723333333325
 2021-08-04 |  6588.669999999994
*/
WITH daily_revenue AS (
   SELECT order_dt, SUM(unit_price_usd * qty) AS revenue
   FROM orders    
   GROUP BY order_dt
)
SELECT order_dt, AVG(revenue) OVER(ORDER BY order_dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
FROM daily_revenue
ORDER BY order_dt;
