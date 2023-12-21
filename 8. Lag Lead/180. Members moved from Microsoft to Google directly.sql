/*
Wrote a query to return all LinkedIn members who worked at Microsoft then moved to Google.
Microsoft --> Google  counts but NOT  Microsoft --> Apple --> Google.
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
(1 row)
*/
SELECT DISTINCT member_id
FROM (
    SELECT
        member_id,
        company_name,
        LEAD(company_name, 1) OVER (PARTITION BY member_id ORDER BY start_date) AS next_company
    FROM employment
) X
WHERE company_name = 'Microsoft'
AND next_company = 'Google'
;
