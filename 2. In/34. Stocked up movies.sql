/*
Instruction
Write a query to return the titles of movies with more than >7 dvd copies in the inventory.
The film titles are unique, i.e., no 2 films share the same titles.
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
Sample results

         title
------------------------
 ACADEMY DINOSAUR
 APACHE DIVINE
*/

SELECT title
FROM film
WHERE film_id IN (
	SELECT 
	    film_id
	FROM inventory
	GROUP BY film_id
	HAVING COUNT(*) >=8
);
