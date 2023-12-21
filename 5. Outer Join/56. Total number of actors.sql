/*
Instruction
Write a query to return the total number of actors from actor_tv, actor_movie with FULL OUTER JOIN.
Use COALESCE to return the first non-null value from a list.
Actors who appear in both tv and movie share the same value of actor_id in both actor_tv and actor_movie tables.
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

 count
-------
   123
*/
/* 
Note: MySQL has no FULL OUTER JOIN command, here is a simulation: 1. left join of two tables, then union the right join of the two tables.
*/

SELECT COUNT(DISTINCT actor_id) FROM (
    SELECT 
         COALESCE(T.actor_id, M.actor_id) AS actor_id        
    FROM actor_tv T
    LEFT JOIN 
        actor_movie M
    ON M.actor_id = T.actor_id
    UNION
    SELECT 
         COALESCE(T.actor_id, M.actor_id) AS actor_id        
    FROM actor_tv T
    RIGHT JOIN 
        actor_movie M
    ON M.actor_id = T.actor_id
) X;
