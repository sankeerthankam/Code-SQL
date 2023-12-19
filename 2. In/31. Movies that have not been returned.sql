/*
Instruction
Write a query to return the titles of the films that were rented by our customers in August 2020 but have not been returned.
Hint
Use rental_ts from the rental table to identify when a film is rented.
If a movie is not returned, the return_ts will be NULL in the rental table.
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

          title
-------------------------
 AGENT TRUMAN
 ALABAMA DEVIL
 AMERICAN CIRCUS
 ANGELS LIFE
*/

WITH out_film AS (
    SELECT DISTINCT film_id 
    FROM inventory 
    WHERE inventory_id IN (
	SELECT inventory_id 
        FROM rental
        WHERE rental_ts >= '2020-08-01' 
        AND rental_ts <= '2020-08-31' 
	AND return_ts IS NULL
    )
)
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id 
    FROM out_film
)
;
