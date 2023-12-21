/*
Instruction
Write a query to return the number of in demand and not in demand movies in May 2020.
Assumptions (great to clarify in your interview): all films are available for rent before May.
But if a film is not in stock, it is not in demand.
The order of your results doesn't matter.
Definition
in-demand: rented >1 times in May 2020.
not-in-demand: rented <= 1 time in May 2020.
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

 demand_category | count
-----------------+-------
 in-demand       |   123
 not-in-demand   |   456
*/
SELECT demand_category, COUNT(*)
FROM (
	SELECT 
		F.film_id, 
		CASE WHEN COUNT(R.rental_id) >1 THEN 'in demand' ELSE 'not in demand' END AS demand_category
	FROM film F
	LEFT JOIN inventory I
	ON F.film_id =I.film_id
	LEFT JOIN (
	    SELECT inventory_id, rental_id
		FROM rental 
		WHERE DATE(rental_ts) >= '2020-05-01'
		AND DATE(rental_ts) <= '2020-05-31'
	) R
	ON R.inventory_id = I.inventory_id
	GROUP BY F.film_id
)X
GROUP BY demand_category;
