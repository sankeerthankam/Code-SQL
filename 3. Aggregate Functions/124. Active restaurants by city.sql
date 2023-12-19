/*
Write a query to return the number of active restaurants for each city. 

Assumption: for simplicity, we can safely assume that city names are unique.

Table: merchant 

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
Sample results

     city      | cnt
---------------+-----
 Tokyo         |  31
 Delhi         |  37
 Shanghai      |  45
 Berlin        |  46

*/
SELECT city, COUNT(DISTINCT id) AS cnt
FROM  merchant
WHERE is_active = TRUE
GROUP BY 1
ORDER BY 2;
