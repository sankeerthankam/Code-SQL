/*
Write a query to return top 10 customers based on their spend growth from the first week of Aug 2021 to the last week of Aug 2021.
The first week of Aug 2021: Aug 1 - Aug 7
The last week of Aug 2021: Aug 25 - Aug 31
Growth: last week's spend / first week's spend.
Skip users who spent 0 the first week of Aug.
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

 customer_id | ranking
-------------+---------
        1032 |       1
        1024 |       2
        1048 |       3
*/
WITH customer_spend AS (
    SELECT
        customer_id,
        SUM(case when order_dt BETWEEN '2021-08-01' AND '2021-08-07' THEN qty * unit_price_usd ELSE 0 END) as first_week_spend,
        SUM(case when order_dt BETWEEN '2021-08-25' AND '2021-08-31' THEN qty * unit_price_usd ELSE 0 END) as last_week_spend
    FROM orders
    GROUP BY customer_id
),
growth AS (
    SELECT
        customer_id,
        ROW_NUMBER() OVER(ORDER BY last_week_spend * 1.0 / first_week_spend  DESC) AS ranking
    FROM customer_spend
)
SELECT customer_id, ranking
FROM growth
WHERE ranking <= 10;
