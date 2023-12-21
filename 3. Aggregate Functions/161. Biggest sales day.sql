/*
Write a query to return for each seller, the date when they have the biggest sales from August 1, 2021 to August 7  2021 (inclusive).
For simplicity, there are no ties.
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 2: transaction 

E-Commerce transactions records

  col_name       | col_type
-----------------+---------------------
seller_id        | bigint   
transaction_id   | bigint
item_id          | bigint
total_amt        | float
transaction_dt   | date
Sample results

 seller_id | transaction_dt
-----------+----------------
     10001 | 2021-08-01
     10002 | 2021-08-03
     10003 | 2021-08-06
*/
WITH daily_sales AS (
    SELECT seller_id, transaction_dt, SUM(total_amt) AS daily_total
    FROM transaction
    WHERE transaction_dt >= '2021-08-01'
    AND transaction_dt <= '2021-08-07'
    GROUP BY seller_id, transaction_dt
)
SELECT seller_id, transaction_dt FROM (
    SELECT seller_id, transaction_dt, daily_total, ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY daily_total DESC) AS ranking
    FROM daily_sales
) X
WHERE ranking =1
ORDER BY 1;
