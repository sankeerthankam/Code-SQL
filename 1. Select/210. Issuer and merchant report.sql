/*
This is a follow up question of #209

Instead of reporting by issuing banks, we want to count number of active customers by issuing banks and merchant category.

Table: visa_sales 

Monthly Visa Credit cards holders transactions. Issuer is a issuing bank For example: a customer John who has a Visa card issued by Bank of America (issuer)

   col_name             | col_type
------------------------+--------------------------
  customer_id           | bigint
  issuer_id             | bigint
  merchant_category     | varchar(100) 
  year                  | int
  month                 | int
  sales_amount          | float
Sample results

 issuer_id | merchant_category | year | month | active_customers
-----------+-------------------+------+-------+------------------
         1 | Automotive        | 2023 |     1 |              254
         1 | Automotive        | 2023 |     2 |              258
         1 | Automotive        | 2023 |     3 |              275
         1 | Automotive        | 2023 |     4 |              264
         1 | Dining            | 2023 |     1 |              253
*/

SELECT issuer_id, merchant_category, year, month, COUNT(DISTINCT customer_id) as active_customers
FROM visa_sales
WHERE year = 2023 AND sales_amount <> 0
GROUP BY issuer_id, merchant_category, year, month
ORDER BY issuer_id, merchant_category, year, month;


