/*
Instruction

Write a query to return the first name and the last name of the actor who appeared in the most films.
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

 first_name | last_name
------------+-----------
 MICHAEL       | JACKSON
*/
WITH top_actor AS (
	SELECT 
	  actor_id, 
	  COUNT(*) AS film_cnt
	FROM film_actor
	GROUP BY actor_id
	ORDER BY film_cnt DESC
	LIMIT 1
)
SELECT first_name, last_name
FROM actor A
WHERE A.actor_id 
IN (
  SELECT actor_id 
  FROM top_actor
);
