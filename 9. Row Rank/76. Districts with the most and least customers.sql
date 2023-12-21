/*
Instructions

Return the districts with the most and least number of customers.
Append a column to indicate whether this district has the most customers or least customers with 'most' or 'least' category.
HINT: it is possible an address is not associated with any customer.
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
Table 2: customer 

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

district  | cat
----------+----------
 New York | most
 Kamado   | least
*/
WITH district_cust_cnt AS (
	SELECT     
		A.district,
		COUNT(DISTINCT C.customer_id) cust_cnt,
		ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT C.customer_id) ASC) AS cust_asc_idx,
		ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT C.customer_id) DESC) AS cust_desc_idx
	FROM address A
	LEFT JOIN customer C
	ON A.address_id = C.address_id
	GROUP BY A.district
)
SELECT 
    district,
    'least' AS city_cat
FROM district_cust_cnt
WHERE cust_asc_idx = 1
UNION
SELECT 
    district,
    'most' AS city_cat
FROM district_cust_cnt
WHERE cust_desc_idx = 1
;
