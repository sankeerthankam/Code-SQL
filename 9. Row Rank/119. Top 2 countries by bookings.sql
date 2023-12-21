/*
Write a query to return top 2 countries for each day in August 2021
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

    date    | country | bookings | ranking
------------+---------+----------+---------
 2021-08-01 | US      |      125 |       1
 2021-08-01 | UK      |       50 |       2
 2021-08-02 | US      |       43 |       1
 2021-08-02 | UK      |       22 |       2

*/
WITH daily_bookings_by_country AS (
    SELECT D.date, L.country, COUNT(B.booking_id) AS bookings
    FROM dates D
    LEFT JOIN bookings B
    ON  B.date = D.date
    LEFT JOIN listings L
    ON L.listing_id = B.listing_id
    WHERE D.date >= '2021-08-01'
    AND D.date < '2021-09-01'
    GROUP BY D.date, L.country
)
SELECT date, country, bookings, ranking FROM (
     SELECT date,
            country,
            bookings,
            ROW_NUMBER() OVER (PARTITION BY date ORDER BY bookings DESC) AS ranking
     FROM daily_bookings_by_country
) X
WHERE ranking <=2 ;
