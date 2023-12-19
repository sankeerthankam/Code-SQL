/*
Instruction

Write a query to return the total number of sales for each product this month (August 2021).
number of sales = sum(qty per order) .
ordering of your results is not considered.
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

 product_id | sum
------------+-----
   10000023 |  92
   10000093 | 114
   10000077 |  92
   10000095 |  77
   10000045 | 136
   10000036 |  75
   10000019 |  88
   10000096 | 113
   10000039 |  96
   10000010 | 113
   10000038 | 105
   10000084 |  97
*/
SELECT product_id, SUM(qty)
FROM orders
WHERE order_dt >= '2021-08-01'
AND order_dt < '2021-09-01'
GROUP BY product_id;
