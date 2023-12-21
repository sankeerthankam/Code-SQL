/*
Instruction
Write a query to return unique names (first_name, last_name) of our customers and actors whose last name starts with letter 'A'.
Table 1: actor 

  col_name   | col_type
-------------+--------------------------
 actor_id    | integer
 first_name  | text
 last_name   | text
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

 first_name | last_name
------------+-----------
 KENT       | ARSENAULT
 JOSE       | ANDREW
*/
SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'A%'
UNION
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'A%';
