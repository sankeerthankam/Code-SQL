/*
Instructions:

A customer can only belong to one store
Write a query to return the quartile by the number of rentals (within the same store) for the following customers:
customer_id IN (1,2,3,4,5,6,7,8,9,10)
Hint

USE NTILE(4) to create quartiles.
To save you some time, here is the CTE to create customer rentals by store:
WITH cust_rentals AS (
    SELECT C.customer_id, 
    MAX(C.store_id) AS store_id, -- one customer can only belong to one store
    COUNT(*) AS num_rentals FROM 
    rental R
    INNER JOIN customer C
    ON C.customer_id = R.customer_id
    GROUP BY C.customer_id
)
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

 customer_id | store_id | quartile
-------------+----------+----------
           1 |        1 |        2
           2 |        1 |        2
           3 |        1 |        1
           4 |        2 |        1

*/
WITH cust_rentals AS (
    SELECT C.customer_id, 
    MAX(C.store_id) AS store_id, -- one customer can only belong to one store
    COUNT(*) AS num_rentals FROM 
    rental R
    INNER JOIN customer C
    ON C.customer_id = R.customer_id
    GROUP BY C.customer_id
)
SELECT customer_id, store_id, quartile
FROM (
	SELECT 
	    customer_id,
	    store_id,
	    NTILE(4) OVER(PARTITION BY store_id ORDER BY num_rentals) AS quartile
	FROM cust_rentals
) X
WHERE customer_id IN (1,2,3,4,5,6,7,8,9,10);
