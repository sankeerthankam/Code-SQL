/*
Instruction

Write a query to return the film_id with movie only casts (actors who never appeared in tv).
The order of your results doesn't matter.
You should exclude movies with one or more tv actors
Table 1: actor_tv 

Actors who appeared in a TV show.

  col_name  | col_type
------------+-------------------
 actor_id   | integer
 first_name | character varying
 last_name  | character varying
Table 2: film_actor 

Films and their casts

  col_name   | col_type
-------------+--------------------------
 actor_id    | smallint
 film_id     | smallint
Sample results

 film_id
---------
     174
     201
*/
SELECT DISTINCT F.film_id
FROM film_actor F
LEFT JOIN (
	SELECT DISTINCT FA.film_id
	FROM film_actor FA
	INNER JOIN actor_tv T
	ON T.actor_id = FA.actor_id
) X 
ON F.film_id = X.film_id
WHERE X.film_id IS NULL;
