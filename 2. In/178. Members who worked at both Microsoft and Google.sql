/*
Write a query to return the LinkedIn members who have worked in both Microsoft and Google.
Ordering of your results doesn't count.
Table: employment 

Employment history of all LinkedIn members

    Column    |          Type       
--------------+------------------------
 member_id    | bigint       
 company_name | character varying(100)
 start_date   | integer                
Sample results

 member_id
-----------
      8002
      8001
(2 rows)
*/
WITH microsoft_google AS (
    SELECT member_id,
        MAX(CASE WHEN company_name = 'Microsoft' THEN 1 ELSE 0 END) AS is_microsoft,
        MAX(CASE WHEN company_name = 'Google' THEN 1 ELSE 0 END) AS is_google
    FROM employment
    GROUP BY member_id
)
SELECT member_id
FROM microsoft_google
WHERE is_microsoft = 1
AND   is_google  = 1;
