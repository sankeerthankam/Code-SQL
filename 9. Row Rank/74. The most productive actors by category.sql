/*
Instructions:

An actor’s productivity is defined as the number of movies he/she has played.
Write a query to return the category_id, actor_id and number of moviesby the most productive actor in that category.
For example: John Doe filmed the most action movies, your query will return John as the result for action movie category.
Do this for every movie category.
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
Table 3: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Sample results

 category_id | actor_id | num_movies
-------------+----------+------------
           1 |       50 |          6
           2 |      150 |          6
           3 |       17 |          7
           4 |       86 |          6
           5 |      196 |          6
           6 |       48 |          6
           7 |        7 |          7
*/
WITH actor_movies AS (
  SELECT 
    FC.category_id,
    FA.actor_id, 
    COUNT(DISTINCT F.film_id) num_movies
  FROM film_actor FA
  INNER JOIN film F
  ON F.film_id = FA.film_id
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  GROUP BY FC.category_id, FA.actor_id
)
SELECT category_id, actor_id, num_movies
FROM (
	SELECT 
		category_id, 
		actor_id, 
		num_movies,
		ROW_NUMBER()OVER(PARTITION BY category_id ORDER BY num_movies DESC) AS productivity_idx
	FROM actor_movies
) X
WHERE productivity_idx = 1;
