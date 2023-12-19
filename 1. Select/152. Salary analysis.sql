/*
For each employee in the 'Product Management' department, we want to know how many other employees' salary from a different department that is at least $5000 lower.
Table 1: department 

Dimensional table for each department: sales, data science, hr, etc.

  col_name     | col_type
---------------+-------------------
id             | int
name           | varchar (20)


Table 2: employee 

Employee information, department they are in and their annual salary.

  col_name     | col_type
---------------+-------------------
id             | bigint
full_name      | varchar (100)
department_id  | int
salary         | float



Sample results

  id  |    full_name    | salary | count
------+-----------------+--------+-------
 8016 | Tywin Lannister | 150000 |    27
 8009 | Theon Greyjoy   |  10000 |     3
*/

WITH pm_employees AS (
    SELECT E.id, E.full_name, E.salary, D.id AS department_id
    FROM employee E
    INNER JOIN department D
    ON D.id = E.department_id
    WHERE D.name = 'Product Management'
)
SELECT P.id, P.full_name, P.salary, COUNT(E.id)
FROM pm_employees P
INNER JOIN employee E
ON P.department_id <> E.department_id
AND P.salary > E.salary + 5000
GROUP BY 1,2, 3
;
