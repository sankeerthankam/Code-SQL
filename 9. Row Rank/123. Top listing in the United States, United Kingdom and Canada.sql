/*
Write a query to return top listing id's based on the number of bookings  in the first week of August 2021 (08/01 - 08/07 inclusively) for the following countries:

United States (country=US)

Canada (country=CA)

United Kingdom (country=UK)

Table 1: bookings 

When someone makes a reservation on Airbnb.

  col_name    | col_type
--------------+-------------------
date          | date
booking_id    | bigint
listing_id    | bigint

Table 2: listings 

When a new Airbnb listing is created in a country ('US', 'UK', 'JP', 'CA', 'AU', 'DE')

  col_name    | col_type
--------------+-------------------
listing_id    | bigint
country       | varchar(2)
created_dt    | date

Sample results

 country | listing_id | ranking
---------+------------+---------
 CA      |    1005000 |       1
 US      |    1000083 |       1
 UK      |    1002985 |       1
*/
WITH bookings_country AS (
    SELECT country, L.listing_id,   COUNT(booking_id) num_bookings
    FROM bookings B
    INNER JOIN listings L
    ON L.listing_id = B.listing_id
    WHERE B.date  >= '2021-08-01'
    AND   B.date  <= '2021-08-07'
    GROUP BY country, L.listing_id
)

SELECT country, listing_id, ranking
FROM (
    SELECT country, listing_id, num_bookings, ROW_NUMBER() OVER(PARTITION BY country ORDER BY num_bookings DESC) ranking
    FROM bookings_country
) X
WHERE country in ('CA', 'UK', 'US')
AND X.ranking =1
ORDER BY country, ranking;
