/*
Instruction
Write a query to return the shortest movie from each category.
The order of your results doesn't matter.
If there are ties, return just one of them.
Return the following columns: film_id, title, length, category, row_num
Table 1: category 

Movie categories.

  col_name   | col_type
-------------+--------------------------
 category_id | integer
 name        | text
Table 2: film 

       col_name       |  col_type
----------------------+--------------------------
 film_id              | integer
 title                | text
 description          | text
 release_year         | integer
 language_id          | smallint
 original_language_id | smallint
 rental_duration      | smallint
 rental_rate          | numeric
 length               | smallint
 replacement_cost     | numeric
 rating               | text
Table 3: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Sample results

 film_id |        title        | length |    category     | row_num
---------+---------------------+--------+-------------+---------
     869 | SUSPECTS QUILLS     |     47 | Action      |       1
     243 | DOORS PRESIDENT     |     49 | Animation   |       1
     505 | LABYRINTH LEAGUE    |     44 | Children    |       1
*/
SELECT 
  film_id,
  title,
  length,
  category,
  row_num
FROM (
  SELECT  
    F.film_id,
    F.title, 
    F.length, 
    C.name category,
    ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY F.length) row_num    
  FROM film F
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) X
WHERE row_num = 1
;
