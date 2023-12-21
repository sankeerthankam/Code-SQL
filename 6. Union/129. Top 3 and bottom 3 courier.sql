/*
For couriers who completed at least 10 trips, compute their average ratings, and report the top 3 and bottom 3.

Rating value: thumb up: 1 else 0

Add a third column to indicate if the courier is 'top 3', or 'bottom 3'.

Table 1: trip 

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

Table 2: trip_rating

Ratings received after a uber eat delivery, either thumb up or thumb down.

  col_name          | col_type
--------------------+-------------------
trip_id             | bigint
reviewer_id         | bigint
subject             | text
thumb_up            | boolean

Sample results

 courier_id |       avg_rating       | rating_cat
------------+------------------------+------------
    3000061 | 1.00000000000000000000 | top 3
    3000051 | 0.95652173913043478261 | top 3
    3000002 | 0.95454545454545454545 | top 3
    3000045 | 0.75000000000000000000 | bottom 3
*/
WITH qualified_courier AS (
    SELECT courier_id, COUNT(DISTINCT trip_id)
    FROM trip
    WHERE is_completed = TRUE
    GROUP BY 1
    HAVING COUNT(DISTINCT trip_id) >= 10
),
avg_rating as (
    SELECT T.courier_id, AVG(CASE WHEN thumb_up IS TRUE THEN 1 ELSE 0 END ) AS avg_rating
    FROM trip T
    INNER JOIN qualified_courier Q
    ON Q.courier_id = T.courier_id
    LEFT JOIN trip_rating R
    ON T.trip_id = R.trip_id
    GROUP BY 1
)
SELECT * FROM (
    SELECT courier_id, avg_rating, 'top 3' AS rating_cat  FROM avg_rating
    ORDER BY avg_rating DESC LIMIT 3
) X1
UNION
SELECT * FROM (
    SELECT courier_id, avg_rating, 'bottom 3' AS rating_cat FROM avg_rating
    ORDER BY avg_rating LIMIT 3
) X2
ORDER BY 2 DESC
;
