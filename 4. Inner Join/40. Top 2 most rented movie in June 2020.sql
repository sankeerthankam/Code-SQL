/*
Instruction

Write a query to return the film_id and title of the top 2 movies that were rented the most times in June 2020
Use the rental_ts column from the rental for the transaction time.
The order of your results doesn't matter.
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

film_id  |       title
---------+--------------------
   12345 | MOVIE TITLE 1
   12346 | MOVIE TITLE 2
*/
SELECT 
    F.film_id, 
    MAX(F.title) AS title   
FROM rental R
INNER JOIN inventory I
ON I.inventory_id = R.inventory_id
INNER JOIN film F
ON F.film_id = I.film_id
WHERE DATE(rental_ts) >= '2020-06-01'
AND   DATE(rental_ts) <= '2020-06-30'
GROUP BY F.film_id
ORDER BY COUNT(*) DESC
LIMIT 2;
