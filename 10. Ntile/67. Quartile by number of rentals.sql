/*
Instruction

Write a query to return quartiles for the following movies by number of rentals among all movies.
film_id IN (1,10,11,20,21,30).
Use NTILE(4) to create quartile buckets.
The order of your results doesn't matter.
Return the following columns: film_id, number of rentals, quartile.
For simplicity: only compare films with >0 revenue (i.e., exclude films that are not  inside inventory, or films with 0 rentals)
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
Table 2: inventory 

Each row is unique, inventoy_id is the primary key of this table.

   col_name   | col_type
--------------+--------------------------
 inventory_id | integer
 film_id      | smallint
 store_id     | smallint
Table 3: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 film_id | num_rentals | quartile
---------+-------------+----------
      30 |           9 |        1
      20 |          10 |        1
      21 |          22 |        4
*/
WITH movie_rentals AS (
  SELECT  
    F.film_id,        
    COUNT(*) AS num_rentals,
    NTILE(4) OVER(ORDER BY COUNT(*)) AS quartile
  FROM rental R  
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id  
  INNER JOIN film F
  ON F.film_id = I.film_id  
  GROUP BY F.film_id
)
SELECT * 
FROM movie_rentals
WHERE film_id IN (1,10,11,20,21,30);
