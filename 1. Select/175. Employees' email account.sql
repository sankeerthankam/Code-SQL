/*
Write a query to generate a user's email account based on the following rules:
First 3 letters of their first name, followed by a period: '.', then the first 5 letters of their last name.
For those without last names, use SNOW as their last name.
Return 3 columns: first_name, last_name, and their email address (ending in @mycompany.com).
The email address has to be converted to lowercase.
To concatenate strings together, use CONCAT function.
Table: amzn_employees 

    col_name |  col_type
-------------+------------------
 employee_id | bigint
 first_name  | text      
 last_name   | text     
 joined_date | date   
 salary      | float
Sample results

 first_name | last_name |        lower
------------+-----------+----------------------
 Jon        | Snow      | jon.snow@mycompany.com
 Ned        | Stark     | ned.stark@mycompany.com
*/

SELECT
    first_name,
    last_name,
    LOWER(CONCAT(SUBSTRING(first_name, 1, 3), '.', SUBSTRING(COALESCE(last_name, 'SNOW'), 1, 5), '@amazon.com')) AS email
FROM amzn_employees;
