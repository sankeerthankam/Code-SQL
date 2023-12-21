/*
Wrote a query to return all LinkedIn members who worked at Microsoft then moved to Google.
Count both Microsoft --> Google  counts as well as Microsoft --> Apple --> Google.
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
      8001
      8002
(2 rows)
*/
SELECT DISTINCT E1.member_id
FROM employment E1
JOIN employment E2
ON E1.member_id = E2.member_id
WHERE E1.start_date < E2.start_date
AND E1.company_name = 'Microsoft'
AND E2.company_name = 'Google'
;
