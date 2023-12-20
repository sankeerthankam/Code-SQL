/*
Today is May 1, 2023. Write a query to count the number of active subscriptions for the first 4 months of 2023.
A subscription cycle can either be monthly or yearly.
The end_at column is when this specific subscription will end, it could be in the past or in the future, but never NULL.
If a user didn't cancel their subscription, there will be a new record with a distinct subscription id with a non-overlapping start and end timestamps,
subscription_id is unique and the primary key of this table.
'Trial' is not considered an 'active paid' subscrption.
If a paid subscription started before the start of a month, and ends in or after that month, it is considered 'active paid subscription' for that month, and our goal is to report this number for each month.
Table 1: apple_subscription 

Subscription table

     Column      |            Type             
-----------------+-----------------------------
 subscription_id | bigint                      
 product_name    | character varying(100)      
 country         | character varying(2)        
 start_at        | timestamp 
 end_at          | timestamp
 state           | character varying(20)       
Table 2: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Sample results

 country | subscription_count
---------+--------------------
 AU      |                278
 CA      |                283
*/
WITH month_start_dt AS (
    SELECT date, MONTH(date) AS month
    FROM dates
    WHERE date >= '2023-01-01'
    AND date < '2023-05-01'
    AND DAY(date) = 1
)
SELECT
    country,
    COUNT(DISTINCT subscription_id) AS subscription_count
FROM apple_subscription S
JOIN month_start_dt D
ON S.start_at <= D.date
AND S.end_at >= D.date
WHERE S.state = 'paid'
GROUP BY country;
