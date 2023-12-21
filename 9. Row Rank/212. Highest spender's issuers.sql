/*
Today is 2023-05-01.
For every merchant category, find the issuer who spent the most in the first 4 months of 2023.
Highester spender: a customer who spend the most in that merchant category.
If there are ties, return all.
A customer can have multiple issuers, report all of them.
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

 merchant_category | customer_id | top_issuer
-------------------+-------------+------------
 Automotive        |        1232 |          2
 Dining            |         359 |          5
 Electronics       |         729 |          3
*/
WITH customer_spend_by_cat AS (
    -- Calculate total spend for each customer in each merchant category
    SELECT
        merchant_category,
        customer_id,
        SUM(sales_amount) AS total_spent
    FROM visa_sales
    WHERE year = 2023 AND month BETWEEN 1 AND 4
    GROUP BY merchant_category, customer_id
),

top_spenders AS (
    -- Identify the top spender in each merchant category
    SELECT
        merchant_category,
        customer_id
    FROM (
        SELECT
            merchant_category,
            customer_id,
            RANK() OVER(PARTITION BY merchant_category ORDER BY total_spent DESC) AS spend_rank
        FROM customer_spend_by_cat
    ) tmp
    WHERE spend_rank = 1
),

top_spenders_issuers AS (
    -- Sum up the spending of top spenders by category and issuer
    SELECT
        ts.merchant_category,
        ts.customer_id,
        vs.issuer_id,
        SUM(vs.sales_amount) AS issuer_spent
    FROM top_spenders ts
    JOIN visa_sales vs
    ON ts.customer_id = vs.customer_id AND ts.merchant_category = vs.merchant_category
    WHERE vs.year = 2023 AND vs.month BETWEEN 1 AND 4
    GROUP BY ts.merchant_category, ts.customer_id, vs.issuer_id
),

rankded_issuers_by_top_spender AS (
    -- Rank issuers by the spending of top spenders in each merchant category
    SELECT
        merchant_category,
        customer_id,
        issuer_id,
        RANK() OVER(PARTITION BY merchant_category, customer_id ORDER BY issuer_spent DESC) AS issuer_rank
    FROM top_spenders_issuers
)

-- Return the issuer where each top spender spent the most for each category
SELECT
    merchant_category,
    customer_id,
    issuer_id AS top_issuer
FROM rankded_issuers_by_top_spender
WHERE issuer_rank = 1
ORDER BY merchant_category, customer_id;
