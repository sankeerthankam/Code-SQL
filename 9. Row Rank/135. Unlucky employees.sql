/*
This is a follow-up question based on question 133 and question 134
First, identify departments with fewer than 5 employees.

Sort these departments by the total salary of its worker in descending order.

If there is a tie, the department with the greatest number of employees should go first.

If it’s still not enough to break a tie, the department with the smallest id in higher rows.

Write a query to return the departments at the even row, so we can lay their entire department off.

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

 id |      name      | num_employees | total_salary | row_number
----+----------------+---------------+--------------+------------
  2 | Sales          |             4 |       240000 |          2
  6 | Cloud Services |             2 |       130000 |          4

*/
WITH dept_salary AS (
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
)
SELECT * FROM (
    SELECT
        id,
        name,
        num_employees,
        total_salary,
        ROW_NUMBER() OVER(ORDER BY total_salary DESC, num_employees DESC, id) rn
    FROM dept_salary
) X
WHERE (rn MOD 2) = 0
;
