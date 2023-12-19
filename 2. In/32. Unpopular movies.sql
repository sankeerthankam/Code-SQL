/*
Instruction
Write a query to return the number of films with no rentals in Feb 2020.
Count the entire movie catalog from the film table.
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

 count
-------
   123
*/

WITH rented_film AS (
	SELECT DISTINCT film_id 
	FROM inventory 
	WHERE inventory_id IN(
		SELECT inventory_id
		FROM rental
		WHERE DATE(rental_ts) >= '2020-02-01'
		AND   DATE(rental_ts) <= '2020-02-29'
	)
)

SELECT COUNT(*)
FROM film
WHERE film_id NOT IN(
    SELECT film_id
    FROM rented_film
);
