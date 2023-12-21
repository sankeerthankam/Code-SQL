/*
Instruction
Write a query to return all actors and customers whose first names ends in 'D'.
Return their ids (for actor: use actor_id, customer: customer_id), first_name and last_name.
The order of your results doesn't matter.
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

customer_id  | first_name |  last_name
-------------+------------+--------------
          55 | DORIS      | REED
          65 | ROSE       | HOWARD
*/
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE '%D'
UNION
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE '%D';
