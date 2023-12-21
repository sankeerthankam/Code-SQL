/*
Instruction

Write a query to return the number of busy days and slow days in May 2020 based on the number of movie rentals.
The order of your results doesn't matter.
If there are ties, return just one of them.
Definition

busy: rentals >= 100.
slow: rentals < 100.
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

date_category  | count
---------------+-------
 busy          |    10
 slow          |    21
*/
SELECT date_category, COUNT(*)
FROM (
	SELECT  D.date,
	    CASE WHEN COUNT(*) >= 100 THEN 'busy' ELSE 'slow' END date_category
	FROM dates D
	LEFT JOIN (
		SELECT * FROM rental		
	) R
	ON D.date = DATE(R.rental_ts)
	WHERE D.date >= '2020-05-01'
	AND   D.date <= '2020-05-31'
	GROUP BY D.date
) X
GROUP BY date_category
;
