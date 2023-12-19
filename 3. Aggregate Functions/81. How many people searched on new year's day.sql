/*
Write a query to return the total number of users who have searched on new year's day: 2021-01-01.

Table: search 

  col_name| col_type
----------+------------
country   | varchar(2)
date      | date
user_id   | integer
search_id | integer
query     | text


Sample results

num_searches
--------------------
1234567899
*/
SELECT COUNT(user_id) FROM (
    SELECT
	user_id
    FROM search
    WHERE date = '2021-01-01'
    GROUP BY 1
) X;
