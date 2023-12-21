/*
Instruction

Write a query to return the name of the most popular film category and its category id
If there are ties, return just one of them.
Table 1: category 

Movie categories.

  col_name   | col_type
-------------+--------------------------
 category_id | integer
 name        | text
Table 2: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Sample results

 category_id |  name
-------------+--------
          123 | Category
*/
SELECT 
    C.category_id,
    MAX(C.name) AS name
FROM film_category FC
INNER JOIN category C
ON C.category_id = FC.category_id
GROUP BY C.category_id
ORDER BY COUNT(*) DESC
LIMIT 1;
