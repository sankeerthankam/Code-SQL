/*
Write a query to return the overall completion rate by city.
Completion rate:  number of completed trips * 100.0 / total number of trips
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

     city      |   completion_rate
---------------+---------------------
 Delhi         | 93.1034482758620690
 New York      | 92.8416485900216920
 Berlin        | 92.6470588235294118
 Seattle       | 92.0289855072463768

*/
SELECT 
    city, 
    SUM(CASE WHEN is_completed = TRUE THEN 1 ELSE 0 END) * 100.0/ COUNT(*) AS completion_rate
FROM trip
GROUP BY city
ORDER BY 2 DESC;
