/*
Instruction
Find the number of actors whose last name is one of the following: 'DAVIS', 'BRODY', 'ALLEN', 'BERRY'

Table: actor 

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
Sample results

last_name | count
-----------+-------
 ALLEN     |     3
 DAVIS     |     3
*/

SELECT
  last_name,
  COUNT(*)
FROM actor
WHERE last_name IN ('DAVIS', 'BRODY', 'ALLEN', 'BERRY')
GROUP BY last_name;
