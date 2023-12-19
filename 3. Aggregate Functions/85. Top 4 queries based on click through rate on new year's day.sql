/*
Instruction

Write a query to return the top 4 search terms with the highest click through rate on new year's day (2021-01-01)
The search term has to be searched by more than 2 (>2) distinct users.
Click through rate: number of searches end up with at least one click.
Table 1: search 

  col_name| col_type
----------+------------
country   | varchar(2)
date      | date
user_id   | integer
search_id | integer
query     | text


Table 2: search_result 

  col_name   | col_type
-------------+--------------------------
 date        | date
 search_id   | bigint
 result_id   | bigint
 result_type | varchar(20)
 action      | varchar(20)
Sample results

query
------------
abc
def
biden

*/
WITH click_through_rate AS (
  SELECT 
	  S.query, 
	  COUNT(DISTINCT CASE WHEN action='click' THEN S.search_id ELSE NULL END) * 100/COUNT(DISTINCT S.search_id) ctr  
  FROM 
  search S
  INNER JOIN search_result R
  ON S.search_id = R.search_id
  WHERE S.date = '2021-01-01'
  GROUP BY S.query
  HAVING COUNT(DISTINCT S.user_id) > 2
)
SELECT query
FROM click_through_rate
ORDER BY ctr DESC
LIMIT 4;
