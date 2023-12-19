/*
Write a query to counts employees' salary by their group
Use the following groups labels:
<= 50000
> 50000, <= 80000
> 80000, <= 100000
> 100000
Table: employee 

Employee information, department they are in and their annual salary.

  col_name     | col_type
---------------+-------------------
id             | bigint
full_name      | varchar (100)
department_id  | int
salary         | float



Sample results

salary_group         | count
---------------------+----------
 <= 50000            |   123
 > 50000, <= 80000   |   456
 > 80000, <= 100000  |   789
*/

SELECT CASE WHEN salary <= 50000 THEN '<= 50000'
            WHEN salary <= 80000 THEN '>50000, <= 80000'
            WHEN salary <= 100000 THEN '>80000, <= 100000'
            WHEN salary > 100000 THEN '>100000'
            ELSE NULL END AS salary_group,
        COUNT(id)
FROM employee
GROUP BY 1
ORDER BY 1;
