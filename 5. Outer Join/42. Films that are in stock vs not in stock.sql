/*
Instruction

Write a query to return the number of films that we have inventory vs no inventory.
A film can have multiple inventory ids
Each film dvd copy has a unique inventory ids
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

   in_stock   | count
--------------+-------
 in stock     |   123
 not in stock |   456
*/
SELECT in_stock, COUNT(*) 
FROM (
	SELECT 
		F.film_id, 
		MAX(CASE WHEN I.inventory_id IS NULL THEN 'not in stock' ELSE 'in stock' END) in_stock
	FROM film F
	LEFT JOIN inventory I
	ON F.film_id =I.film_id
	GROUP BY F.film_id
) X
GROUP BY in_stock;
