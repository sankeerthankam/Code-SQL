/*
It can take days or weeks before a listing is first booked;
Write a query to count the daily number of listings that were booked the first time in August 2021.
If there are no listings that were first booked during a day, return 0.
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
Sample results

    date    | count
------------+-------
 2021-08-01 |   297
 2021-08-02 |    63
 2021-08-03 |    59
 2021-08-04 |    87
 2021-08-05 |    48
 2021-08-06 |    53
*/
WITH nth_bookings AS (
    SELECT 
        D.date, 
        booking_id, 
        ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY D.date) AS nth_booking
    FROM dates D
    LEFT JOIN bookings B
    ON  B.date = D.date
),
first_booking AS (
    SELECT * FROM nth_bookings
    WHERE nth_booking = 1
    AND date >= '2021-08-01'
    AND date < '2021-09-01'
)
SELECT date, COUNT(booking_id)
FROM first_booking
GROUP BY date
;

