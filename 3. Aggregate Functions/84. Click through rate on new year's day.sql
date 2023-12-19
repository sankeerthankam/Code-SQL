/*
Write a query to compute the click through rate for the search results on new year's day (2021-01-01).
Click through rate: number of searches end up with at least one click.
Convert your result into a percentage (* 100.0).
Table: search_result 

  col_name   | col_type
-------------+--------------------------
 date        | date
 search_id   | bigint
 result_id   | bigint
 result_type | varchar(20)
 action      | varchar(20)
Sample results

 ctr
----------
2.34
*/
SELECT 
COUNT(DISTINCT CASE WHEN action = 'click' THEN search_id ELSE NULL END) * 100.0/COUNT(DISTINCT search_id)
FROM search_result
WHERE date = '2021-01-01';
