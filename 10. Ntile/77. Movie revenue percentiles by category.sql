/*
Instructions:

Write a query to return revenue percentiles (ordered ascendingly) of the following movies within their category:
film_id IN (1,2,3,4,5).
For simplicity, we ignore those movies with 0 revenue
Hint

Use NTILE(100) to create percentiles.
To save you some time, here is the CTE to create a movie's revenue by category.
WITH movie_rev_by_cat AS (
    SELECT 
       F.film_id,
       MAX(FC.category_id) AS category_id,
       SUM(P.amount) AS revenue
    FROM film F
    INNER JOIN inventory I
    ON I.film_id = F.film_id
    INNER JOIN rental R
    ON R.inventory_id = I.inventory_id
    INNER JOIN payment P
    ON P.rental_id = R.rental_id
    INNER JOIN film_category FC
    ON FC.film_id = F.film_id
    GROUP BY F.film_id
)
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
Table 4: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Table 5: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

 film_id | perc_by_cat
---------+-------------
       1 |          17
       3 |          19
       5 |          30
       2 |          22
       4 |          36
*/
WITH movie_rev_by_cat AS (
    SELECT 
       F.film_id,
       MAX(FC.category_id) AS category_id,
       SUM(P.amount) AS revenue
    FROM film F
    INNER JOIN inventory I
    ON I.film_id = F.film_id
    INNER JOIN rental R
    ON R.inventory_id = I.inventory_id
    INNER JOIN payment P
    ON P.rental_id = R.rental_id
    INNER JOIN film_category FC
    ON FC.film_id = F.film_id
    GROUP BY F.film_id
)
SELECT film_id, perc_by_cat
FROM (
	SELECT film_id,
	    NTILE(100) OVER(PARTITION BY category_id ORDER BY revenue) AS perc_by_cat
	FROM movie_rev_by_cat
)X
WHERE film_id IN (1,2,3,4,5);
