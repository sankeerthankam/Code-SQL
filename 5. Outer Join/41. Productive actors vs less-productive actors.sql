/*
Instruction

Write a query to return the number of productive and less-productive actors.
The order of your results doesn't matter.
Definition

productive: appeared in >= 30 films.
less-productive: appeared in <30 films.
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

 actor_category  | count
-----------------+-------
 less productive |   123
 productive      |   456
*/
SELECT actor_category,
    COUNT(*)
FROM (        
	SELECT 
	    A.actor_id,
	    CASE WHEN  COUNT(DISTINCT FA.film_id) >= 30 THEN 'productive' ELSE 'less productive' END AS actor_category	     
	FROM actor A
	LEFT JOIN film_actor FA
	ON FA.actor_id = A.actor_id
	GROUP BY A.actor_id
) X
GROUP BY actor_category;
