/*
Instruction
Write a query to return the name of the actor who appears in the most films.
You have to use INNER JOIN in your query.
Table 1: actor 

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
Table 2: film_actor 

Films and their casts

  col_name   | col_type
-------------+--------------------------
 actor_id    | smallint
 film_id     | smallint
Sample results

 actor_id | first_name | last_name
----------+------------+-----------
     1234 | FIRST_NAME | LAST_NAME
*/
SELECT
    FA.actor_id,
    MAX(A.first_name) first_name,
    MAX(A.last_name) last_name
FROM film_actor FA
INNER JOIN actor A
ON A.actor_id = FA.actor_id
GROUP BY FA.actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;
