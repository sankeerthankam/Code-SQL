/*
Instruction

Write a query to generate percentile distribution for the following movies by their total rental revenue in their category.
film_id <= 20.
Use NTILE(100) to create percentile.
The order of your results doesn't matter.
Return the following columns: category, film_id, revenue, percentile
For simplicity: only compare films with >0 revenue (i.e., exclude films that are not  inside inventory, or films with 0 rentals)
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

  category   | film_id | revenue | percentile
-------------+---------+---------+---------
 Action      |      19 |   33.79 |      11
 Animation   |      18 |   32.78 |      13
 Comedy      |       7 |   82.85 |      35
 Documentary |       1 |   36.77 |      17
 Documentary |       3 |   37.88 |      19
 Family      |       5 |   51.88 |      30
*/
WITH film_revenue_by_cat AS (
  SELECT  
    F.film_id,    
    MAX(C.name) AS category,
    SUM(P.amount) revenue
  FROM payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id  
  INNER JOIN film F
  ON F.film_id = I.film_id
  INNER JOIN film_category FC
  ON FC.film_id = F.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
  GROUP BY F.film_id
)

SELECT 
    category, 
    film_id,
    revenue,
    percentile
FROM (
  SELECT  
    category,
    FR.film_id,
    revenue,    
    NTILE(100) OVER(PARTITION BY category ORDER BY revenue) percentile    
  FROM film_revenue_by_cat FR
  INNER JOIN film_category FC
  ON FC.film_id = FR.film_id
  INNER JOIN category C
  ON C.category_id = FC.category_id
) X
WHERE film_id <=20
ORDER BY category, revenue;
