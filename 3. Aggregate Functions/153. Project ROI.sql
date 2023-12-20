/*
Write a query to calculate the ROI for every active project.
ROI = budget / cost
Cost = prorated sum of employees' salary on this project.
To prorate the cost of an employee, divide the total number of days he/she spend on this project by 365 then multiply his/her annual salary.
Table 1: employee 

Employee information, department they are in and their annual salary.

  col_name     | col_type
---------------+-------------------
id             | bigint
full_name      | varchar (100)
department_id  | int
salary         | float



Table 2: project_detail 

Project meta data

  col_name       | col_type
-----------------+---------------------
project_id       | bigint   
title            | varchar(200)
start_date       | date
end_date         | date
budget           | float

Table 3: projects 

Projects history and employees who are associated with.

  col_name       | col_type
-----------------+---------------------
project_id       | bigint
employee_id      | bigint


Sample results

 project_id |         roi
------------+---------------------
      20001 | 0.15113281250000002
      20002 | 0.49863387978142076
      20003 |  2.0277777777777777
*/
SELECT 
    P.project_id, 
    MAX(D.budget) *1.0/  SUM(datediff(end_date, start_date) * 1.0/365 * E.salary) AS roi
FROM projects P
INNER JOIN project_detail D
ON D.project_id = P.project_id
INNER JOIN employee E
ON E.id = P.employee_id
GROUP BY 1
ORDER BY 1;
