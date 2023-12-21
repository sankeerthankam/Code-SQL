/*
For each day, calculate the growth rate of revenue compared to the previous day;
Day over day change rate: (today's revenue - yesterday's revenue) * 100.0/ yesterday's revenue
If there was no result for a previous day, leave it NULL;
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

  order_dt  |     dod_change
------------+---------------------
 2021-08-01 | null
 2021-08-02 | -51.739778823620355
 2021-08-03 |   23.67729032429714
 2021-08-04 | -2.6333874939125135
 2021-08-05 |  54.331708635149674
*/
WITH daily_revenue AS (
   SELECT order_dt, SUM(unit_price_usd * qty) AS revenue
   FROM orders    
   GROUP BY order_dt
)
SELECT 
    order_dt, 
    ( (revenue/ LAG(revenue, 1) OVER (ORDER BY order_dt) ) - 1) * 100.0 AS dod_change
FROM daily_revenue
ORDER BY order_dt;
