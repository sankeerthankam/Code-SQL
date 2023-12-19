/*
Instruction

Write a query to return the number of good days and bad days in May 2020 based on number of daily rentals.
Return the results in one row with 2 columns from left to right: good_days, bad_days.
good day: > 100 rentals.
bad day: <= 100 rentals.
Hint (For users already know OUTER JOIN), you can use dates table
Hint: be super careful about datetime columns.
Hint: this problem could be tricky, feel free to explore the rental table and take a look at some data.
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
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

good_days | bad_days
-----------+----------
         7 |       24
*/

WITH daily_rentals AS (
	SELECT  
	 DATE(rental_ts) AS dt,
	 COUNT(*) AS num_rentals
	FROM rental
	WHERE DATE(rental_ts) >= '2020-05-01' 
        AND DATE(rental_ts) <= '2020-05-31' 
	GROUP BY dt
)    
SELECT 		    
    SUM(CASE WHEN num_rentals > 100 THEN 1
         ELSE 0 
         END) AS good_days,
    31 - SUM(CASE WHEN num_rentals > 100 THEN 1
         ELSE 0 
         END) AS bad_days
FROM daily_rentals;
