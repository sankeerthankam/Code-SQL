/*
This is a follow-up question to question 120.
Write a query to compute the WoW (week over week) changes of the first-ever bookings in August.
Definition of WoW change:  (number of today's first-ever bookings  - the same day of last week's first-ever bookings ) * 100.0/  the same day of last week's first-ever bookings.
Return NULL if there is no data 7 days ago.
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

    date    |       wow_change
------------+------------------------
 2021-08-01 | NULL
 2021-08-02 | NULL
 2021-08-03 | NULL
 2021-08-04 | NULL
 2021-08-05 | NULL
 2021-08-06 | NULL
 2021-08-07 | NULL
 2021-08-08 |   -32.7586206896551724
 2021-08-09 |   -18.1818181818181818
 2021-08-10 | 0.00000000000000000000
 2021-08-11 |   -29.6296296296296296
 2021-08-12 |    71.4285714285714286
*/
WITH nth_bookings AS (
    SELECT D.date, booking_id, ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY D.date) AS nth_booking
    FROM dates D
    LEFT JOIN bookings B
    ON  B.date = D.date
),
first_booking AS (
    SELECT * FROM nth_bookings
    WHERE nth_booking = 1
),
daily_first_booking AS (
    SELECT date, COUNT(*) AS first_bookings
    FROM first_booking
    GROUP BY date
)
SELECT date,  (first_bookings -  LAG(first_bookings, 7) OVER())  * 100.0/ (LAG(first_bookings, 7) OVER()) AS wow_change
FROM daily_first_booking
WHERE date >= '2021-08-01'
AND date < '2021-09-01'
ORDER BY date
;

