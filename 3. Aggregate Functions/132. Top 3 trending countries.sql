/*
Write a query to return the top 3 countries with the highest month-over-month growth in new accounts creation.
Compute growth rate with August 2021 and July 2021.
Growth rate: num_new_accounts in august * 100.0 / num_new_accouts in july
Table 1: affirm_account 

Bank account creation/deletion records, the account type can only be one of 'checking', 'saving', or 'both'.

  col_name     | col_type
---------------+-------------------
id             | bigint
account_type   | varchar (20) -- 'checking', 'saving', or 'both
action         | varchar (10) --  'created' or 'deleted'
date           | date



Table 2: affirm_account_detail 

Bank account and meta data.

  col_name     | col_type
---------------+-------------------
account_id     | bigint
city           | varchar (100)
state          | varchar (100)
country        | varchar (2)


Sample results

 country |     mom_growth
---------+---------------------
 CA      | 50.0000000000000000
 US      | 28.5714285714285714
 UK      | 25.0000000000000000
*/
WITH july AS (
    SELECT D.country, COUNT(DISTINCT A.id) AS num_new_accounts
    FROM affirm_account A
    INNER JOIN affirm_account_detail D
    ON D.account_id = A.id
    WHERE action = 'created'
    AND date BETWEEN '2021-07-01'
    AND                '2021-07-31'
    GROUP BY D.country
),
august AS (
    SELECT D.country, COUNT(DISTINCT A.id) AS num_new_accounts
    FROM affirm_account A
    INNER JOIN affirm_account_detail D
    ON D.account_id = A.id
    WHERE action = 'created'
    AND   date BETWEEN '2021-08-01'
    AND                '2021-08-31'
    GROUP BY D.country
)
SELECT A.country, COALESCE(A.num_new_accounts, 0) * 100.0 / J.num_new_accounts AS mom_growth
FROM july J
LEFT JOIN  august A
ON A.country = J.country
ORDER BY mom_growth DESC LIMIT 3;
