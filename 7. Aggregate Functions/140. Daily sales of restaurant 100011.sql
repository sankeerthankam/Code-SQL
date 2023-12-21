/*
Write a query to generate a report for the daily revenue of restaruant_id = 100011 in August 2021;
Every day in August needs to be included.
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
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

    date    | restaurant_id |   daily_revenue
------------+---------------+--------------------
 2021-08-01 |        100011 |              24.46
 2021-08-02 |        100011 |              75.71
 2021-08-03 |        100011 |                  0
 2021-08-04 |        100011 |             106.47
 2021-08-05 |        100011 |                  0
*/
SELECT
    D.date,
    COALESCE(F.restaurant_id, 100011) AS restaurant_id,
    SUM(COALESCE(F.total_amt,0)) AS daily_revenue
FROM dates D
LEFT JOIN food_order F
ON DATE(F.created_at) = D.date
AND F.restaurant_id = 100011
WHERE D.date >= '2021-08-01'
AND D.date <= '2021-08-31'
GROUP BY 1,2;

