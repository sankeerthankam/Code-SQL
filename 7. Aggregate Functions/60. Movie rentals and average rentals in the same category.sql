/*
Instruction

Write a query to return the number of rentals per movie, and the average number of rentals in its same category.
You only need to return results for film_id <= 10.
Return 4 columns: film_id, category name, number of rentals, and the average number of rentals from its category.
Table 1: category 

Movie categories.

  col_name   | col_type
-------------+--------------------------
 category_id | integer
 name        | text
Table 2: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Table 3: inventory 

Each row is unique, inventoy_id is the primary key of this table.

   col_name   | col_type
--------------+--------------------------
 inventory_id | integer
 film_id      | smallint
 store_id     | smallint
Table 4: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 film_id | category_name | rentals | avg_rentals_category
---------+---------------+---------+----------------------
       1 | Documentary   |      23 |  16.6666666666666667
       2 | Horror        |       7 |  15.9622641509433962
       3 | Documentary   |      12 |  16.6666666666666667
       4 | Horror        |      23 |  15.9622641509433962
*/
WITH movie_rental AS (
    SELECT
        I.film_id,
        COUNT(*) rentals
    FROM rental R
    INNER JOIN inventory I
    ON I.inventory_id = R.inventory_id
    GROUP BY I.film_id
)
SELECT 
    film_id, 
    category_name, 
    rentals, 
    avg_rentals_category 
FROM (
	SELECT
	    MR.film_id,
	    C.name category_name,
	    rentals,
	    AVG(rentals) OVER(PARTITION BY C.name) avg_rentals_category
	FROM movie_rental MR
	INNER JOIN film_category FC
	  ON FC.film_id = MR.film_id
	INNER JOIN category C
	  ON C.category_id = FC.category_id
) X
WHERE film_id <= 10
;
