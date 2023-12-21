/*
Instruction
Write a query to return actors who appeared in both tv and movies
The order of your results doesn't matter.
You need to use INNER JOIN.
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

 actor_id | first_name  |  last_name
----------+-------------+-------------
        1 | PENELOPE    | GUINESS
        4 | JENNIFER    | DAVIS
*/
SELECT 
    M.actor_id,
    M.first_name, 
    M.last_name
FROM actor_movie M
INNER JOIN actor_tv T
ON T.actor_id = M.actor_id;
