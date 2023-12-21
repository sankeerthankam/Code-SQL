/*
Instruction

Write a query to return percentile distribution for the following movies by their total rental revenues in the entire movie catalog.
film_id IN (1,10,11,20,21,30).
A film can only belong to one category.
The order of your results doesn't matter.
Return the following columns: film_id, revenue, percentile
For simplicity: only compare films with >0 revenue (i.e., exclude films that are not  inside inventory, or films with 0 rentals)
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

film_id  | revenue | percentile
---------+---------+------------
      11 |   35.76 |         23
       1 |   36.77 |         24
      30 |   46.91 |         35
*/
WITH film_revenue AS (
  SELECT  
    F.film_id,        
    SUM(P.amount) revenue,
    NTILE(100) OVER(ORDER BY SUM(P.amount)) AS percentile
  FROM payment P
  INNER JOIN rental R
  ON R.rental_id = P.rental_id
  INNER JOIN inventory I
  ON I.inventory_id = R.inventory_id  
  INNER JOIN film F
  ON F.film_id = I.film_id  
  GROUP BY F.film_id
)
SELECT 
  film_id,   
  revenue,
  percentile
FROM film_revenue 
WHERE film_id IN (1,10,11,20,21,30);
