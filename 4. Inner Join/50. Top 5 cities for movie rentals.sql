/*
Instruction

Write a query to return the names of the top 5 cities with the most rental revenues in 2020.
Include each city's revenue in the second column.
The order of your results doesn't matter.
Your results should have exactly 5 rows.
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
Table 4: payment 

Movie rental payment transactions table

   col_name   | col_type
--------------+--------------------------
 payment_id   | integer
 customer_id  | smallint
 staff_id     | smallint
 rental_id    | integer
 amount       | numeric
 payment_ts   | timestamp with time zone
Sample results

            city            |  sum
----------------------------+--------
 Cape Coral                 | 221.55
 Saint-Denis                | 216.54
 Aurora                     | 198.50
 City 4                     | 12.34
 City 5                     | 1.23
*/
SELECT 
	T.city,
	SUM(P.amount)
FROM payment P
INNER JOIN customer C
ON C.customer_id = P.customer_id
INNER JOIN address A
ON A.address_id = C.address_id
INNER JOIN city T
ON T.city_id = A.city_id
WHERE DATE(P.payment_ts) >= '2020-01-01'
AND DATE(P.payment_ts) <= '2020-12-31'
GROUP BY T.city
ORDER BY SUM(P.amount) DESC
LIMIT 5;
