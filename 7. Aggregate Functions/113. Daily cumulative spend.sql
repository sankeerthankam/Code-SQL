/*
Write a query to return daily cumulative spend for customers:
customer_ids = [1008, 1021, 1028, 1033, 1030, 1038]
Date from 2021-08-01 to 2021-08-10 (inclusive).
There was no orders before 2021-08-01.
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

 customer_id |  order_dt  |        sum
-------------+------------+--------------------
        1008 | 2021-08-01 | 230.46999999999997
        1008 | 2021-08-02 | 340.16999999999996
        1008 | 2021-08-03 |             405.02
        1008 | 2021-08-04 | 424.91999999999996
        1008 | 2021-08-05 |            1477.42
        1008 | 2021-08-06 | 1677.3700000000001
        1008 | 2021-08-07 |            3208.57
        1008 | 2021-08-08 | 3283.9300000000003
        1008 | 2021-08-09 |            3384.53
        1008 | 2021-08-10 |            3449.28
*/
WITH daily_spend AS (
    SELECT 
        customer_id,  
        order_dt, 
        SUM(unit_price_usd * qty) AS spend
    FROM orders
    WHERE customer_id in (1008, 1030, 1038, 1021, 1033, 1028)
    AND order_dt >= '2021-08-01'
    AND order_dt < '2021-08-11'
    GROUP BY customer_id, order_dt
 )
SELECT 
    customer_id, 
    order_dt, 
    SUM(spend) OVER(PARTITION BY customer_id ORDER BY order_dt)
FROM daily_spend;
