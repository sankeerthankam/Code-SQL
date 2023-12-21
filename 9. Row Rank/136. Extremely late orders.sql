/*
If a food order is delivered longer or equal than (>=) 60 minutes, this order is considered an 'extremely late order'.
Write a query to report the percentage of extremely late orders by month in 2021.
For simplicity, we assume every order was delivered.
The Postgres function to extract minutes from two time intervals: time_a and time_b  (time_b > time_a) is:
EXTRACT (EPOCH FROM time_b - time_a)::int/60
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
 2021 |   7 | 23.0956239870340357
 2021 |   8 | 24.9605055292259084
*/
WITH delivery_time AS (
    SELECT
        O.order_id,
        YEAR(created_at) AS year,
        MONTH(created_at) AS mon,
        TIMESTAMPDIFF(MINUTE, created_at, delivered_at) AS minutes
    FROM food_order O
    INNER JOIN food_delivery D
    ON D.order_id = O.order_id
)
SELECT year, mon, COUNT(CASE WHEN minutes > 60 THEN order_id ELSE NULL END) * 100.0 / COUNT(*) AS percent
FROM delivery_time
GROUP BY year, mon
ORDER BY year, mon;

