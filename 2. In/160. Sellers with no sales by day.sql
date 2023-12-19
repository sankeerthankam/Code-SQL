/*
Write a query to return the daily number of sellers with 0 sales from August 1, 2021 to August 7  2021 (inclusive).
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 2: seller_status 

Current seller status on the e-commerce platform.

  col_name       | col_type
-----------------+---------------------
seller_id        | bigint   
status           | varchar(20) -- 'suspended', 'active'

Table 3: transaction 

E-Commerce transactions records

  col_name       | col_type
-----------------+---------------------
seller_id        | bigint   
transaction_id   | bigint
item_id          | bigint
total_amt        | float
transaction_dt   | date
Sample results

    date    | num_zero_sales
------------+----------------
 2021-08-01 |              3
 2021-08-02 |              5
 2021-08-03 |              4
 2021-08-04 |              4
 2021-08-05 |              3
 2021-08-06 |              5
 2021-08-07 |              7
*/
WITH sellers AS (
    SELECT DISTINCT seller_id
    FROM seller_status
)
SELECT D.date, COUNT(CASE WHEN T.seller_id IS NULL THEN S.seller_id ELSE NULL END) AS num_zero_sales
FROM dates D
CROSS JOIN sellers S
LEFT JOIN transaction T
ON D.date = T.transaction_dt
AND S.seller_id = T.seller_id
WHERE D.date >= '2021-08-01'
AND D.date <= '2021-08-07'
GROUP BY D.date
ORDER BY D.date;
