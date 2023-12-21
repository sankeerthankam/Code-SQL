/*
Instructions:

Any customers who made 10 movie rentals are happy customers
Write a query to return the average number of days for a customer to make his/her 10th rental.
If a customer has never become a ‘happy’ customer, you should skip this customer when computing the average.
You can use EXTRACT(DAYS FROM tenth_rental_ts - first_rental_ts) to get the number of days in between the 1st rental and 10th rental
Use ROUND(average_days) to return an integer
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

 avg
-------
    65
*/
WITH cust_rental_ts AS (
    SELECT   
        customer_id,
    rental_ts,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY rental_ts) rental_idx
    FROM rental
)
SELECT ROUND(AVG(delta)) AS avg_days FROM (
    SELECT 
        customer_id,
    first_rental_ts,
    tenth_rental_ts,
    DATEDIFF(tenth_rental_ts, first_rental_ts) AS delta
    FROM (
        SELECT 
            customer_id, 
        MAX(CASE WHEN rental_idx = 1 THEN rental_ts ELSE NULL END) AS first_rental_ts,
        MAX(CASE WHEN rental_idx = 10 THEN rental_ts ELSE NULL END) AS tenth_rental_ts
     FROM cust_rental_ts
     GROUP BY customer_id
    ) X
    WHERE tenth_rental_ts IS NOT NULL
)Y;
