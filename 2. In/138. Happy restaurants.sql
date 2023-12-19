/*
Write a query to return % of restaurants that received more than (>) $1000 amount of orders by the month.
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
 2021 |   8 | 17.9104477611940299
 2021 |   7 | 19.2307692307692308
*/

WITH monthly_revenue AS (
    SELECT
        YEAR(created_at) AS year,
        MONTH(created_at) AS mon,
        O.restaurant_id,
        SUM(O.total_amt) AS rev
    FROM food_order O
    INNER JOIN food_delivery D
    ON D.order_id = O.order_id
    GROUP BY 1,2,3
)
SELECT year, mon, COUNT(CASE WHEN rev > 1000 THEN restaurant_id ELSE NULL END) * 100.0 / COUNT(*) AS percent
FROM monthly_revenue
GROUP BY 1,2;
