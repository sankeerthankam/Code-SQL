/*
Instruction

Write a query to return the number of fast movie watchers vs slow movie watchers.
fast movie watcher: by average return their rentals within 5 days.
slow movie watcher: takes an average of >5 days to return their rentals.
Most customers have multiple rentals over time, you need to first compute the number of days for each rental transaction, then compute the average on the rounded up days. e.g., if the rental period is 1 day and 10 hours, count it as 2 days.
Skip the rentals that have not been returned yet, e.g., return_ts IS NULL.
The orders of your results doesn't matter.
A customer can only rent one movie per transaction.
Table: rental 

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
Sample results

watcher_category | count
------------------+-------
 fast_watcher     |   112
 slow_watcher     |   487
*/

WITH average_rental_days AS (
	SELECT 
	    customer_id,        
	    AVG(ROUND(DATEDIFF(return_ts,  rental_ts ) + 1)) AS average_days
	FROM rental
	WHERE return_ts IS NOT NULL
	GROUP BY 1
)
SELECT CASE WHEN average_days <= 5 THEN 'fast_watcher'
            WHEN average_days > 5 THEN 'slow_watcher'
            ELSE NULL
            END AS watcher_category,
        COUNT(*)
FROM average_rental_days
GROUP BY watcher_category;
