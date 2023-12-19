/*
Users can make purchases via either mobile or desktop platforms.

Using the following data table to determine the total number of users and revenue for mobile_only, desktop_only, and both.

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

 platform_category | num_customers |       spend
-------------------+---------------+--------------------
 both              |            30 | 185455.25999999992
 desktop_only      |            15 |  96647.46999999994
 mobile_only       |             5 |  33410.03999999997
*/

WITH customer_spend AS (
    SELECT customer_id,
        SUM(CASE WHEN channel = 'mobile' THEN qty * unit_price_usd ELSE 0 END) mobile_spend,
        SUM(CASE WHEN channel = 'desktop' THEN qty * unit_price_usd ELSE 0 END) desktop_spend
    FROM orders
    GROUP BY customer_id
)

SELECT CASE WHEN mobile_spend >0 AND desktop_spend =0 THEN 'mobile_only'
         WHEN mobile_spend =0 AND desktop_spend >0 THEN 'desktop_only'
         WHEN mobile_spend >0 AND desktop_spend >0 THEN 'both'
    END AS platform_category,
    COUNT(DISTINCT customer_id) AS num_customers,
    SUM(mobile_spend + desktop_spend) AS spend
FROM customer_spend
GROUP BY 1;
