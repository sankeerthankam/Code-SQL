/*
Write a query to return the top searched term in the US and UK on new year's day (2021-01-01), separately
The order of your results doesn't matter.
Rank each search query based on the number of unique users who searched this query.
Table: search 

  col_name| col_type
----------+------------
country   | varchar(2)
date      | date
user_id   | integer
search_id | integer
query     | text


Sample results

 country      | query
--------------+-------
           US |  Joe Biden
           UK |  David Beckham
*/
SELECT
    country,
    query	
FROM (
    SELECT
        query,
        country,
        COUNT(DISTINCT user_id),
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY COUNT(DISTINCT user_id) DESC) AS row_num
    FROM search
    WHERE country IN ('US', 'UK')
    AND date = '2021-01-01'
    GROUP BY 1,2
) X
WHERE row_num = 1;
