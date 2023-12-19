/*
Instruction
Write a query to return the total number of customers who didn't rent any movies in May 2020.
Hint
You can use NOT IN to exclude customers who have rented movies in May 2020.
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

 count
-------
 1234
*/

SELECT COUNT(*) 
FROM customer
WHERE customer_id NOT IN(
	SELECT customer_id
	FROM rental
	WHERE  DATE(rental_ts) >= '2020-05-01'
	AND    DATE(rental_ts) <= '2020-05-31'
);
