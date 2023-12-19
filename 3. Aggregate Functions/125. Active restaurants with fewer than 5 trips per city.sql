/*
Write a query to report the number of active restaurants with fewer than 5 completed trips per city.

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

Sample results

     city      | count
---------------+-------
 Austin        |    12
 Chicago       |    15
 Portland      |    14
 Seattle       |    22
*/
SELECT city, COUNT(id) FROM (
    SELECT M.city, M.id, COUNT(DISTINCT trip_id) AS trip_cnt
    From merchant M
    LEFT JOIN trip T on M.id = T.restaurant_id
    WHERE is_active IS TRUE
    AND is_completed = TRUE
    GROUP BY  1, 2
    HAVING COUNT(DISTINCT trip_id) <5
) X
GROUP BY 1;
