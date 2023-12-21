/*
Instruction

Write a query to return the percentage of revenue for each of the following films: film_id <= 10.
Formula: revenue (film_id x) * 100.0/ revenue of all movies.
The order of your results doesn't matter.
Table 1: inventory 

Each row is unique, inventoy_id is the primary key of this table.

   col_name   | col_type
--------------+--------------------------
 inventory_id | integer
 film_id      | smallint
 store_id     | smallint
Table 2: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
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

film_id	revenue_percentage
1	4.6701552061371199
2	6.7226357101125308
3	4.8111362308532527
4	11.6557014758554119
5	6.5892752813269998
*/
WITH movie_revenue AS (
	SELECT 
	    I.film_id, SUM(P.amount) revenue
	FROM payment P
	INNER JOIN rental R
	ON R.rental_id = P.rental_id
	INNER JOIN inventory I
	ON I.inventory_id = R.inventory_id
	GROUP BY I.film_id
),
rev_percent AS (
    SELECT film_id, revenue * 100.0 / SUM(revenue) OVER() revenue_percentage
    FROM movie_revenue
)
SELECT * FROM rev_percent
WHERE film_id <= 10
ORDER BY film_id
;
