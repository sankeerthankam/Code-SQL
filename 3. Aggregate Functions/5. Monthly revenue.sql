/*
Instruction

Write a query to return the total movie rental revenue for each month.
For Postgres: you can use EXTRACT(MONTH FROM colname) and EXTRACT(YEAR FROM colname) to extract month and year from a timestamp column.
For Python/Pandas: you can use pandas DatetimeIndex() to extract Month and Year
df['year'] = pd.DatetimeIndex(df['InsertedDate']).year
Table: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Sample results

 year | mon |   rev
------+-----+----------
 2020 |   1 |  123.45
 2020 |   2 |  234.56
 2020 |   3 |  345.67
*/
SELECT 
    EXTRACT(YEAR FROM payment_ts) AS year,
    EXTRACT(MONTH FROM payment_ts) AS mon,
    SUM(amount) as rev
FROM payment
GROUP BY year, mon
ORDER BY year, mon;
