/*
Instruction

For each movie category: return the customer id who spend the most in rentals.
If there are ties, return any customer id.
Hint

To save you some time, you can use the following CTE (Common table expression) to get each customer's spend by movie category:
WITH cust_revenue_by_cat AS (
    SELECT 
        P.customer_id,
	FC.category_id,
	SUM(P.amount) AS revenue
    FROM payment P
    INNER JOIN rental R
    ON R.rental_id = P.rental_id
    INNER JOIN inventory I
    ON I.inventory_id = R.inventory_id
    INNER JOIN film F
    ON F.film_id = I.film_id
    INNER JOIN film_category FC
    ON FC.film_id = F.film_id
    GROUP BY P.customer_id, FC.category_id
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

 category_id | customer_id
-------------+-------------
           1 |         363
           2 |         526
           3 |         467
           4 |         293
           5 |         459
*/
WITH cust_revenue_by_cat AS (
	SELECT 
	  P.customer_id,
	  FC.category_id,
	  SUM(P.amount) AS revenue
	FROM payment P
	INNER JOIN rental R
	ON R.rental_id = P.rental_id
	INNER JOIN inventory I
	ON I.inventory_id = R.inventory_id
	INNER JOIN film F
	ON F.film_id = I.film_id
	INNER JOIN film_category FC
	ON FC.film_id = F.film_id
	GROUP BY P.customer_id, FC.category_id
)
SELECT category_id, customer_id
FROM (
	SELECT 
	  customer_id,
	  category_id,
	  ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY revenue DESC) AS rev_cat_idx
	FROM cust_revenue_by_cat  
) X
WHERE rev_cat_idx = 1;
