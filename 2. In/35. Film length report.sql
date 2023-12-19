/*
Instruction
Write a query to return the number of films in the following categories: short, medium, and long.
The order of your results doesn't matter.
Definition
short: less <60 minutes.
medium: >=60 minutes, but <100 minutes.
long: >=100 minutes
Table: film 

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
Sample results

 film_category | count
---------------+-------
 medium        |   1
 long          |   2
 short         |   3
*/

SELECT
  CASE WHEN length < 60 THEN 'short'
  	   WHEN length < 100 THEN 'medium'
  	   WHEN length >= 100 THEN 'long'
  	   ELSE NULL
  	   END AS film_category,
  COUNT(*)
FROM film
GROUP BY film_category;
