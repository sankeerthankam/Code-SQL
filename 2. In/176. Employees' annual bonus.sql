/*
Write a query to compute this year's annual bonus based on the following rules:
Anyone who joined amazon after 2021-05-01  receives nothing.
Those who joined before 2021-01-01 receive a full bonus of 10000.
For those who joined before 2021-05-01 but after 2021-01-01, their annual bonus is prorated as the number of days between their joined date and  2021-05-01, divided by 120 and multiply by 10,000.
Return 3 columns: first_name, last_name, and bonus.
Table: amzn_employees 

    col_name |  col_type
-------------+------------------
 employee_id | bigint
 first_name  | text      
 last_name   | text     
 joined_date | date   
 salary      | float
*/
SELECT 
    first_name, 
    last_name, 
    CASE WHEN joined_date >= '2021-05-01' THEN 0
               WHEN joined_date < '2021-01-01' THEN 10000
               ELSE DATEDIFF('2021-05-01',  joined_date) * 1.0 / 120 * 10000 END AS bonus
FROM amzn_employees;
