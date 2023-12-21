/*
Today is 2023-05-01.
For every merchant category, find the issuer who generated the most sales in the first 4 months of 2023.
If two issuer both have the highest sales, report both.
Hint: use RANK function to handle ties.
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

 merchant_category | issuer_id | total_sales
-------------------+-----------+-------------
 Automotive        |         4 |    74928.10
 Dining            |         4 |    72501.49
*/
WITH issuer_sales AS (
    -- Calculate total sales for each issuer in each merchant category
    SELECT
        issuer_id,
        merchant_category,
        SUM(sales_amount) AS total_sales
    FROM visa_sales
    WHERE year = 2023 AND month BETWEEN 1 AND 4
    GROUP BY issuer_id, merchant_category
),

rankings AS (
    -- Rank issuers by their sales within each merchant category
    SELECT
        issuer_id,
        merchant_category,
        total_sales,
        RANK() OVER(PARTITION BY merchant_category ORDER BY total_sales DESC) AS sales_rank
    FROM issuer_sales
)

-- Select the top issuer (or issuers in case of ties) for each merchant category
SELECT
    merchant_category,
    issuer_id,
    total_sales
FROM rankings
WHERE sales_rank = 1
ORDER BY merchant_category, issuer_id;
