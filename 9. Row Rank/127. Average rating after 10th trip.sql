/*
Write a query to return each restaurant’s average rating if they have more than 10 completed trips.
Ignore restaurants with fewer than 10 completed trips (not enough samples).
When computing the average rating, you need to first convert thumb_up ratings to the value of 1, otherwise 0.
In Postgres, to check if a boolean column is true, you can use IS TRUE statement.
When computing the average ratings, including ONLY completed trips.
Table 1: merchant 

A reference table for any service provider such as a restaurant.

  col_name      | col_type
-----------------+-------------------
id               | bigint
marketplace_fee  | float
price_bucket     | varchar(5)
delivery_zone_id | bigint
is_active        | boolean
first_online_dt  | timestamp
city             | text 
country          | varchar(2)
Table 2: trip 

Fact table for every uber eats delivery.

  col_name          | col_type
--------------------+-------------------
trip_id             | bigint
date                | date
trip_start_ts       | timestamp
delivery_fee_usd    | int
surge_fee_usd       | int
is_curbside_dropoff | boolean
is_completed        | boolean 
is_cash_trip        | boolean
user_id             | bigint
restaurant_id       | bigint
courier_id          | bigint
city               | text
country             | varchar(2)

Table 3: trip_rating

Ratings received after a uber eat delivery, either thumb up or thumb down.

  col_name          | col_type
--------------------+-------------------
trip_id             | bigint
reviewer_id         | bigint
subject             | text
thumb_up            | boolean

Sample results

 restaurant_id |       avg_rating
---------------+------------------------
        100004 | 0.79245283018867924528
        100046 | 0.83333333333333333333
        100080 | 0.72222222222222222222
        100006 | 0.75268817204301075269
*/
WITH nth_trip AS (
    SELECT restaurant_id, T.trip_id, date, CASE WHEN R.thumb_up IS TRUE THEN 1 ELSE 0 END AS rating,
    RANK() OVER(PARTITION by restaurant_id ORDER BY trip_start_ts ) AS ranking
    FROM trip T
    LEFT JOIN trip_rating R
    ON R.trip_id = T.trip_id
    WHERE T.is_completed IS TRUE
)
SELECT restaurant_id, AVG(rating) avg_rating
FROM nth_trip
WHERE restaurant_id IN (
    SELECT restaurant_id
    FROM nth_trip
    GROUP BY 1
    HAVING MAX(ranking) >= 10
)
GROUP BY restaurant_id;
