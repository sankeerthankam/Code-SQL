/*
Instruction
Identify all actors whose last name ends in 'EN' or 'RY'.
Group and count them by their last name.
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
 BERGEN    |     1
*/

SELECT
  last_name,
  COUNT(*)
FROM actor
WHERE last_name LIKE ('%RY')
OR last_name LIKE ('%EN')
GROUP BY last_name;
