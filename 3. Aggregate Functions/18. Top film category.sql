/*
Instruction
Write a query to return the film category id with the most films, as well as the number films in that category.
Table: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Sample results

category_id | film_cnt
------------+----------
          1 |       2
*/
SELECT 
    category_id,
    COUNT(*) film_cnt
FROM film_category
GROUP BY category_id
ORDER BY film_cnt DESC
LIMIT 1;
