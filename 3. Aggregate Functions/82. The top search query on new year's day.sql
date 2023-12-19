/*
Write a query to return the top search term on new year's day: 2021-01-01

Table: search 

  col_name| col_type
----------+------------
country   | varchar(2)
date      | date
user_id   | integer
search_id | integer
query     | text


Sample results

top_search_term
--------------------
Joe Biden
*/
SELECT query FROM (
    SELECT
	query,
	COUNT(*)
    FROM search
    WHERE date = '2021-01-01'
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1
) X
