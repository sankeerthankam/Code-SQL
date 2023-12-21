/*
This is a follow-up question of #140;
Generate the cumulative daily sales of restaurant id =100011 in August 2021;
Include every day.
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

    date    | cumulative_daily_rev
------------+----------------------
 2021-08-01 |                24.46
 2021-08-02 |   100.16999999999999
 2021-08-03 |   100.16999999999999
 2021-08-04 |               206.64
 2021-08-05 |               206.64
*/
WITH daily_rev AS (
    SELECT
        D.date,
        SUM(COALESCE(F.total_amt,0)) AS daily_revenue
    FROM dates D
    LEFT JOIN food_order F
    ON DATE(F.created_at) = D.date
    AND F.restaurant_id = 100011
    WHERE D.date >= '2021-08-01'
    AND D.date <= '2021-08-31'
    GROUP BY 1
)
SELECT date, SUM(daily_revenue) OVER(ORDER BY date) AS cumulative_daily_rev
FROM daily_rev
;
