/*
Write a query to report the number of newly created accounts by account type in Aug 2021
Table: affirm_account 

Bank account creation/deletion records, the account type can only be one of 'checking', 'saving', or 'both'.

  col_name     | col_type
---------------+-------------------
id             | bigint
account_type   | varchar (20) -- 'checking', 'saving', or 'both
action         | varchar (10) --  'created' or 'deleted'
date           | date



Sample results

 account_type | count
--------------+-------
 both         |     4
 checking     |     3
 saving       |     1
(3 rows)
*/
SELECT account_type, COUNT(*)
FROM affirm_account
WHERE action = 'created'
AND date BETWEEN  '2021-08-01' AND '2021-08-31'
GROUP BY account_type
;
