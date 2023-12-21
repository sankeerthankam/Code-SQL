/*
Instruction

For movies that are not in demand (rentals = 0 in May 2020), we want to remove them from our inventory.
Write a query to return the number of unique inventory_id from those movies with 0 demand.
Hint: a movie can have multiple inventory_id.
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
12345
*/
SELECT COUNT(inventory_id )
FROM inventory I
INNER JOIN (
	SELECT F.film_id
	FROM film F
	LEFT JOIN (
	    SELECT  DISTINCT I.film_id
	    FROM inventory I
	    INNER JOIN (
		SELECT inventory_id, rental_id
		FROM rental 
		WHERE DATE(rental_ts) >= '2020-05-01'
		AND DATE(rental_ts) <= '2020-05-31'
	    ) R
	    ON I.inventory_id = R.inventory_id
	) X ON X.film_id = F.film_id
	WHERE X.film_id IS NULL
)Y
ON Y.film_id = I.film_id;
