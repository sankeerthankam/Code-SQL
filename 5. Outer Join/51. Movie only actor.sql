/*
Instruction
Write a query to return the first name and last name of actors who only appeared in movies.
Actor appeared in tv should not be included .
The order of your results doesn't matter.
Table 1: actor_movie 

Actors who appeared in a movie.

  col_name  | col_type
------------+-------------------
 actor_id   | integer
 first_name | character varying
 last_name  | character varying
Table 2: actor_tv 

Actors who appeared in a TV show.

  col_name  | col_type
------------+-------------------
 actor_id   | integer
 first_name | character varying
 last_name  | character varying
Sample results

 first_name  |  last_name
-------------+-------------
 ED          | CHASE
 ZERO        | CAGE
 CUBA        | OLIVIER
*/
SELECT M.first_name, M.last_name
FROM actor_movie M
LEFT JOIN actor_tv T
ON M.actor_id = T.actor_id
WHERE T.actor_id IS NULL;
