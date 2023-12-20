/*
Write a query to report the total number of transaction volumes ($) from suspended sellers in Aug 2021.
Table 1: seller_status 

Current seller status on the e-commerce platform.

  col_name       | col_type
-----------------+---------------------
seller_id        | bigint   
status           | varchar(20) -- 'suspended', 'active'

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

  sum
-------
 79.97
(1 row)
*/
SELECT SUM(total_amt) AS volume
FROM seller_status S
INNER JOIN transaction T
ON T.seller_id = S.seller_id
WHERE S.status = 'suspended'
AND transaction_dt >= '2021-08-01'
AND transaction_dt <= '2021-08-31';
