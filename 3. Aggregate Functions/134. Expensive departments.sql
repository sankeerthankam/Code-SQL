/*
This is a follow-up to question 133.

First, identify departments with fewer than 5 employees.

Sort these departments by the total salary of its worker in descending order.

If there is a tie, the department with the greatest number of employees should go first.

If it’s still not enough to break a tie, the department with the smallest id in higher rows.

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

 id |         name         | num_employees | total_salary
----+----------------------+---------------+--------------
  8 | Legal                |             3 |       310000
  2 | Sales                |             4 |       240000
  5 | Product Management   |             2 |       160000
*/
SELECT
    D.id,
    D.name,
    COUNT(E.id) num_employees,
    SUM(E.salary) AS total_salary
FROM department D
INNER JOIN employee E
ON E.department_id = D.id
GROUP BY D.id, D.name
HAVING COUNT(E.id) < 5
ORDER BY total_salary DESC, num_employees DESC, D.id;
