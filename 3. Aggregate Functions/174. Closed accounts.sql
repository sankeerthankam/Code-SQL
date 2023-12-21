/*
Write a query to compute the percentage of closed accounts by September 30th, 2021.

Table: fb_account_status 

An account can have at most 2 rows: when it's created, and when it's closed. For active accounts, there is only one-row corresponding to when the account was first created.

    col_name       |  col_type
-------------------+--------------------------
 account_id        | bigint
 date              | date
 status            | varchar(10) -- 'created', 'closed'
Sample results

 closed_percentage
---------------------
 33.3333333333333333
*/
SELECT COUNT(DISTINCT CASE WHEN status = 'closed' THEN account_id ELSE NULL END) * 100.0/ 
COUNT(DISTINCT account_id) As closed_percentage
FROM fb_account_status;
