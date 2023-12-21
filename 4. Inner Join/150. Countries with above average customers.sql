/*
Write a query to return countries with an above-average number of customers.
The average number of customers is calculated by the number of customers *1.0 / number of countries
Table 1: address 

  col_name   | col_type
-------------+--------------------------
 address_id  | integer
 address     | text
 address2    | text
 district    | text
 city_id     | smallint
 postal_code | text
 phone       | text
Table 2: city 

  col_name   | col_type
-------------+--------------------------
 city_id     | integer
 city        | text
 country_id  | smallint
Table 3: customer 

  col_name   | col_type
-------------+--------------------------
 customer_id | integer
 store_id    | smallint
 first_name  | text
 last_name   | text
 email       | text
 address_id  | smallint
 activebool  | boolean
 create_date | date
 active      | integer
Sample results


 country_id
------------
          6
         15
         23
         24
         29
         38
         44
*/
WITH avg_customers_by_country AS (
    SELECT COUNT(DISTINCT customer_id) * 1.0 / COUNT(DISTINCT country_id) AS avg
    FROM customer C
    INNER JOIN address A
    ON A.address_id = C.address_id
    INNER JOIN city T
    ON T.city_id = A.city_id
)
SELECT T.country_id
FROM customer C
INNER JOIN address A
ON A.address_id = C.address_id
INNER JOIN city T
ON T.city_id = A.city_id
GROUP BY 1
HAVING  COUNT(DISTINCT C.customer_id)  > (SELECT avg FROM avg_customers_by_country);
