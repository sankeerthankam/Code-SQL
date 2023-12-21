/*
Write a query to return the daily number of bookings (reservations) in July 2021 in the US.
If there is no booking, return 0.
Table 1: bookings 

When someone makes a reservation on Airbnb.

  col_name    | col_type
--------------+-------------------
date          | date
booking_id    | bigint
listing_id    | bigint

Table 2: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 3: listings 

When a new Airbnb listing is created in a country ('US', 'UK', 'JP', 'CA', 'AU', 'DE')

  col_name    | col_type
--------------+-------------------
listing_id    | bigint
country       | varchar(2)
created_dt    | date

Sample results

    date    | count
------------+-------
 2021-07-01 |    1
 2021-07-02 |    2
 2021-07-03 |    3
 2021-07-04 |    0
 2021-07-05 |    5

*/
WITH us_bookings AS (
    SELECT
        B.date,
        COUNT(booking_id) AS num_bookings
    FROM bookings B	
    INNER JOIN listings L
    ON L.listing_id = B.listing_id
    AND L.country = 'US'	
    GROUP BY date	
)
SELECT 
    D.date, 
    CASE WHEN B.num_bookings IS NULL THEN 0 ELSE B.num_bookings END AS num_bookings
FROM dates D
LEFT JOIN us_bookings B
ON B.date = D.date
WHERE D.date >= '2021-07-01'
AND D.date < '2021-08-01'
ORDER BY D.date;
