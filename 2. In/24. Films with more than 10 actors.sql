/*
Instruction
Write a query to return the titles of the films with >= 10 actors.
Table 1: film 

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
Table 2: film_actor 

Films and their casts

  col_name   | col_type
-------------+--------------------------
 actor_id    | smallint
 film_id     | smallint
Sample results

         title
------------------------
 ACADEMY DINOSAUR
 ARABIA DOGMA
*/
WITH film_casts_cnt AS (
	SELECT 
	    film_id,
	    COUNT(*) AS actors_cnt
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*)>=10
)

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_casts_cnt
);
