/*
This is a follow-up of question 136;
If a food order is delivered longer or equal than (>=) 60 minutes, this order is considered an 'extremely late order';
We want to analyze the success rate for all first deliveries, so let's focus on first time deliveries.
Write a query to report the percentage of extremely late first orders by month in 2021 if they are the first deliveries.
Table 1: food_delivery 

  col_name     | col_type
---------------+-------------------
order_id       | bigint
courier_id     | bigint
delivered_at   | timestamp
rating         | int (1,...,5)
Table 2: food_order 

Food orders that are placed on Doordash.

  col_name     | col_type
---------------+-------------------
order_id       | bigint
restaurant_id  | bigint
customer_id    | bigint
created_at     | timestamp
total_amt      | float



Sample results

 year | mon |       percent
------+-----+---------------------
 2021 |   7 | 18.6746987951807229
 2021 |   8 | 11.7647058823529412
*/
WITH delivery_time AS (
    SELECT
        O.order_id,
        YEAR(created_at) AS year,
        MONTH(created_at) AS mon,
        TIMESTAMPDIFF (MINUTE, created_at, delivered_at) AS minutes,
        ROW_NUMBER() OVER(PARTITION BY courier_id ORDER BY delivered_at) AS nth_delivery
    FROM food_order O
    INNER JOIN food_delivery D
    ON D.order_id = O.order_id
)
SELECT year, mon, COUNT(CASE WHEN minutes >= 60 THEN order_id ELSE NULL END) * 100.0 / COUNT(*) AS percent
FROM delivery_time
WHERE nth_delivery = 1
GROUP BY year, mon
ORDER BY year, mon;
