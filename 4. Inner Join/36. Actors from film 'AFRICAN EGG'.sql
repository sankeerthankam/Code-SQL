/*
Instruction
Write a query to return the first name and last name of all actors in the film 'AFRICAN EGG'.
The order of your results doesn't matter.
Table 1: actor 

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
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
Table 3: film_actor 

Films and their casts

  col_name   | col_type
-------------+--------------------------
 actor_id    | smallint
 film_id     | smallint
Sample results

 first_name | last_name
------------+-----------
 GARY       | PHOENIX
 DUSTIN     | TAUTOU
*/
SELECT A.first_name, A.last_name
FROM film F
INNER JOIN film_actor FA
ON FA.film_id = F.film_id
INNER JOIN actor A
ON A.actor_id = FA.actor_id
WHERE F.title = 'AFRICAN EGG';
