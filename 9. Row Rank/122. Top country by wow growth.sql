/*
This is a follow-up question to question 121.
Write a query to return the country with the highest week-over-week growth for first-ever bookings' WoW (week over week) changes of the first-ever bookings for the first week of  August 2021.
Definition of WoW change:  (today's first bookings  - the same day of last week's first bookings ) * 100.0/ the same day of last week's first bookings.
Wow comparisons: 08-01 vs. 07-25, 08-02 vs. 07-26, ..., 08-07 vs. 07-31.
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

    date    | country 
------------+------------------
 2021-08-01 | DE
 2021-08-02 | CA
 2021-08-03 | ES
*/
WITH nth_bookings AS (
	SELECT B.date, L.listing_id, B.booking_id, country, ROW_NUMBER() OVER (PARTITION BY B.listing_id  ORDER BY B.date) AS nth_booking
	FROM listings L
	INNER JOIN bookings B
	ON L.listing_id = B.listing_id
),
   first_bookings AS (
    SELECT * FROM nth_bookings
    WHERE nth_booking = 1
),

  first_bookings_by_country AS (
	SELECT date, country, COUNT(DISTINCT listing_id) AS weekly_first_bookings
	FROM first_bookings
	WHERE date >= '2021-07-25'
	AND date <= '2021-08-07'
	GROUP BY 1,2
),
wow_growth AS (
	SELECT B1.date, B1.country, B1.weekly_first_bookings * 100.0/ B2.weekly_first_bookings - 100.0 AS wow_growth
	FROM first_bookings_by_country B1
	INNER JOIN first_bookings_by_country B2
	ON B1.country= B2.country
	AND B1.date = DATE_ADD(B2.date, INTERVAL 7 DAY)
	ORDER BY 1
),
growth_ranking AS (
	SELECT date, country, RANK()OVER(PARTITION BY date ORDER BY wow_growth DESC) ranking
	FROM wow_growth
)
SELECT date, country
FROM growth_ranking
WHERE ranking =1;
