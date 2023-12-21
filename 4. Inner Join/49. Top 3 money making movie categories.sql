/*
Instruction
Write a query to return the name of the 3 movie categories that generated the most rental revenue
And rental revenue from each of the category.
The order of your results doesn't matter.
If there are ties, return just one of them.
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

    name     |   revenue
-------------+---------
 Sports      | 123
 Sci-Fi      | 456
 Animation   | 789
*/
SELECT C.name, SUM(P.amount)
FROM 
    payment P
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
GROUP BY C.name 
ORDER BY SUM(P.amount) DESC
LIMIT 3
;
