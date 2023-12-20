/*
Write a query that returns customer id,  customers name, merchant id, merchant name and number of purchases.

For the following 10 customer_id:

8001, 8002, ..., 8010

Table 1: ap_customer 

Afterpay's customer meta data.

  col_name     | col_type
---------------+-------------------
id             | bigint
full_name      | text

Table 2: ap_merchant 

Merchants that implemented Afterpay solution to their commerce platform.

  col_name       | col_type
-----------------+---------------------
id               | bigint     
name             | text
Table 3: ap_order 

Afterpay's order table

  col_name      | col_type
----------------+-------------------
id              | bigint
date            | date
customer_id     | bigint
merchant_id     | bigint
order_channel   | varchar(10)
purchase_amount | float

Sample results

 customer_id |    full_name     |   name   | num_purchases
-------------+------------------+----------+---------------
        8001 | Jon Snow         | Best Buy |             1
        8002 | Ned Stark        | Amazon   |             8
        8002 | Ned Stark        | Apple    |             4
        8002 | Ned Stark        | Best Buy |             4
        8002 | Ned Stark        | Google   |            10
*/
SELECT customer_id, full_name, M.name, COUNT(DISTINCT O.id) num_purchases
FROM ap_order O
INNER JOIN ap_customer C
ON C.id = O.customer_id
INNER JOIN ap_merchant M
ON M.id = O.merchant_id
WHERE  customer_id IN (8001, 8002, 8003, 8004, 8005, 8006, 8007, 8008, 8009, 8010)
GROUP BY 1,2,3;
