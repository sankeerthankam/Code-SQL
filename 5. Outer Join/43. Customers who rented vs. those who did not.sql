/*
Instruction

Write a query to return the number of customers who rented at least one movie vs. those who didn't in May 2020.
The order of your results doesn't matter.
Use customer table as the base table for all customers (assuming all customers have signed up before May 2020)
Rented: if a customer rented at least one movie.
Bonus: Develop a LEFT JOIN as well as a RIGHT JOIN solution
Table 1: customer 

  col_name   | col_type
-------------+--------------------------
 customer_id | integer
 store_id    | smallint
 first_name  | text
 last_name   | text
 email       | text
 address_id  | smallint
 activebool  | boolean
 create_date | date
 active      | integer
Table 2: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

   has_rented  | count
  -------------+-------
 rented        |  123
 never-rented  |  456
*/
SELECT have_rented, COUNT(*)
FROM (
	SELECT 
	    C.customer_id,
	    CASE WHEN R.customer_id IS NOT NULL THEN 'rented' ELSE 'never-rented' END AS have_rented
	FROM customer C
	LEFT JOIN (
	    SELECT DISTINCT customer_id
		FROM rental 
	    WHERE DATE(rental_ts) >= '2020-05-01'
	    AND DATE(rental_ts) <= '2020-05-31'
    ) R	
	ON R.customer_id = C.customer_id	
) X
GROUP BY have_rented;
