/*
Write a query to return the % of first deliveries with a rating of 1 by month.
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
 2021 |   7 | 32.5301204819277108
 2021 |   8 | 32.3529411764705882
*/
WITH delivery_time AS (
    SELECT
        O.order_id,
        YEAR(created_at) AS year,
        MONTH(created_at) AS mon,
        rating,
        ROW_NUMBER() OVER(PARTITION BY courier_id ORDER BY created_at) AS nth_delivery
    FROM food_order O
    INNER JOIN food_delivery D
    ON D.order_id = O.order_id
)
SELECT year, mon, COUNT(CASE WHEN rating =1 THEN order_id ELSE NULL END) * 100.0 / COUNT(*) AS percent
FROM delivery_time
WHERE nth_delivery = 1
GROUP BY year, mon
ORDER BY year, mon;
