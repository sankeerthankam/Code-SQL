/*
Instruction

Write a query to return the total number of actors using UNION.
Actor who appeared in both tv and movie has the same value of actor_id in both actor_tv and actor_movie tables.
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
SELECT COUNT(*) FROM (
	SELECT 
	     T.actor_id	     
	FROM actor_tv T
	UNION 
	SELECT 
	    M.actor_id
	FROM actor_movie M
) X;
