/*
Today is 2023-05-01 

Write a query to report every issuer's interchange revenue by their merchant category in the first 4 months of this year.

Interchange_revenue = interchange_rate * sales_amount

Table 1: visa_interchange_rate

Interchange rate is a fee that a merchant must pay with every credit and debit card transaction, to the issuing bank. The rate is usually set by the issuing bank by merchant category, and every issuer has a different set of rates. e.g., Bank of america may have a interchange rate for retailers at 0.3%.

   col_name         | col_type
  ------------------+--------------------------
  issuer_id         | bigint
  merchant_category | varchar(100) 
  interchange_rate  | float 

Table 2: visa_sales 

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

 issuer_id | merchant_category | interchange_revenue
-----------+-------------------+---------------------
         1 | Automotive        |          14060.7566
         1 | Dining            |           8087.5795
         1 | Electronics       |           8408.3103
         1 | Entertainment     |          12699.7596
         1 | Groceries         |          10840.7648
         1 | Health & Fitness  |          10793.5280
         1 | Home Improvement  |           9242.7020
         2 | Automotive        |          17968.5432
*/
SELECT
    v_ir.issuer_id,
    v_ir.merchant_category,
    SUM(v_ir.interchange_rate * v_s.sales_amount) AS interchange_revenue
FROM visa_interchange_rate v_ir
JOIN visa_sales v_s
ON v_ir.issuer_id = v_s.issuer_id AND v_ir.merchant_category = v_s.merchant_category
WHERE v_s.year = 2023 AND v_s.month BETWEEN 1 AND 4 -- if you only want data for the first 4 months of 2023
GROUP BY v_ir.issuer_id, v_ir.merchant_category
ORDER BY v_ir.issuer_id, v_ir.merchant_category;
