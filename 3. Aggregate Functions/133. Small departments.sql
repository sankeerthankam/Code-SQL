/*
Write a query to find all departments with less than (<) 5 employees.
Return 3 columns: department's id, department's name and the number of employees.
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

 id |         name         | count
----+----------------------+-------
  1 | Software Engineering |     3
  2 | Sales                |     4
*/
SELECT D.id, D.name, COUNT(E.id)
FROM department D
INNER JOIN employee E
ON E.department_id = D.id
GROUP BY D.id, D.name
HAVING COUNT(E.id) < 5
ORDER BY D.id;
