/*
Instruction
Write a query to return the percentage of revenue for each of the following films: film_id <= 10 by its category.
Formula: revenue (film_id x) * 100.0/ revenue of all movies in the same category.
The order of your results doesn't matter.
Return 3 columns: film_id, category name, and percentage.
Table 1: category 

Movie categories.

  col_name   | col_type
-------------+--------------------------
 category_id | integer
 name        | text
Table 2: film 

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
Table 3: film_category 

A film can only belong to one category

  col_name   | col_type
-------------+--------------------------
 film_id     | smallint
 category_id | smallint
Table 4: inventory 

Each row is unique, inventoy_id is the primary key of this table.

   col_name   | col_type
--------------+--------------------------
 inventory_id | integer
 film_id      | smallint
 store_id     | smallint
Table 5: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Table 6: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 film_id | category_name | revenue_percent_category
---------+---------------+--------------------------
       1 | Documentary   |   0.87183937479845975834
       2 | Horror        |       1.4218786097664498
       3 | Documentary   |   0.89815815929740700696
       4 | Horror        |       2.4652522202582108
       5 | Family        |       1.2276180943524362
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
),rev_percentage AS (
SELECT 
    MR.film_id, 
    C.name category_name,
    revenue * 100.0 / SUM(revenue) OVER(PARTITION BY C.name) revenue_percent_category
FROM movie_revenue MR
INNER JOIN film_category FC
  ON FC.film_id = MR.film_id
INNER JOIN category C
  ON C.category_id = FC.category_id
)
SELECT * FROM rev_percentage
WHERE film_id <= 10
ORDER BY film_id
;
