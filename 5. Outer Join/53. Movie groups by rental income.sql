/*
Instruction

Write a query to return the number of films in 3 separate groups: high, medium, low.
The order of your results doesn't matter.
Definition

high: revenue >= $100.
medium: revenue >= $20, <$100 .
low: revenue <$20.
Hint

If a movie has no rental revenue, it belongs to the low group
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
Table 3: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
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

 film_group | count
------------+-------
 medium     |   123
 high       |   456
 low        |   789
*/
SELECT film_group, COUNT(*) 
FROM (
	SELECT 
		F.film_id, 
	    CASE WHEN SUM(P.amount) >= 100 THEN 'high'
	         WHEN SUM(P.amount) >= 20 THEN 'medium'
	         ELSE 'low' END film_group
	FROM film F
	LEFT JOIN inventory I
	ON I.film_id = F.film_id
	LEFT JOIN rental R 
	ON R.inventory_id = I.inventory_id
	LEFT JOIN payment P
	ON P.rental_id = R.rental_id
	GROUP BY F.film_id
) X
GROUP BY film_group
;
