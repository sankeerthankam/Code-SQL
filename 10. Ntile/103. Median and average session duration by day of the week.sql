/*
Write a query to return the median and mean of session duration, by day of the week.
The Postgres function to get day of week is EXTRACT(DOW FROM date)
For simplicity, we can assume no session spans across multiple days.
(Postgres)You can use PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY col) aggregate function to compute the median.
(MySQL) there is no built-in median function in MySQL, you can skip this question or share your solution in the forum.
Table: session_web_duration 

The number of seconds a user spends by session.

  col_name       | col_type
-----------------+---------------------
date             | date    
session_id       | bigint
duration         | int

Sample results

   dow    |   median  | avg
----------+-----------+---
1         | 12.3      | 20
2         | 15.3      | 30
3         | 18.8      | 25
*/
SELECT *
FROM session_web_duration
LIMIT 5;


