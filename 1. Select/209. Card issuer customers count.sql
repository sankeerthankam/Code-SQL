/*
For every card issuer (e.g., bank of america, chase), report their monthly active customers in 2023.
Monthly Active Customer: a customer whose sales_amount is not 0.
Customers who don't have a transaction will not have a record in the visa_sales table.
There could be some edge cases if the sales amount is negative, which indicates the customes had received a refund, as long as a customer's sales_amount is not 0, this customer is considered an active customer.
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

 issuer_id | year | month | active_customers
-----------+------+-------+------------------
         1 | 2023 |     1 |              755
         1 | 2023 |     2 |              755
         1 | 2023 |     3 |              755
         1 | 2023 |     4 |              755
         2 | 2023 |     1 |              818

*/

SELECT issuer_id, year, month, COUNT(DISTINCT customer_id) as active_customers
FROM visa_sales
WHERE year = 2023 AND sales_amount <> 0
GROUP BY issuer_id, year, month
ORDER BY issuer_id, year, month;

