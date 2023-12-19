/*
Instruction

Write a query to return the title of the film with the second-largest cast.
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
-----------
 SECOND LARGEST*/

WITH second_film AS (
    SELECT film_id,
    COUNT(*) AS actors_cnt
    FROM film_actor
    GROUP BY film_id
    ORDER BY actors_cnt DESC
    LIMIT 1
    OFFSET 1

)
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM second_film    
);
