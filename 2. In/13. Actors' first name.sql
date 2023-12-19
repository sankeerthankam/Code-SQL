/*
Instruction

Write a query to return the number of actors whose first name starts with 'A', 'B', 'C', or others.
The order of your results doesn't matter.
You need to return 2 columns:
The first column is the group of actors based on the first letter of their first_name, use the following: 'a_actors', 'b_actors', 'c_actors', 'other_actors' to represent their groups.
Second column is the number of actors whose first name matches the pattern.
Table: actor 

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
Sample results

actor_category | count
----------------+-------
 a_actors       |    13
 b_actors       |     8
*/

SELECT  
 CASE WHEN first_name LIKE 'A%' THEN 'a_actors'
      WHEN first_name LIKE 'B%' THEN 'b_actors'
      WHEN first_name LIKE 'C%' THEN 'c_actors'
      ELSE 'other_actors' 
      END AS actor_category,
  COUNT(*)
FROM actor
GROUP BY actor_category;
