/*
Instruction

Write a query to return students that took exams this week didn't take any exams last week.
This week: Sep 17, 2023 to Sep 23, 2023
Last week: Sep 10, 2023 to Sep 16, 2023
Table: snap_test_results 

Students test scores on 3 different subjects, a student can take the same subject multiple times. The exam is online and student can take any subject at any time during the two weeks from Sep 10, 2023 and Sep 23, 2023.

   col_name     | col_type
----------------+--------------------------
 student_id     | int
 subject        | varchar(30)
 score          | integer
 date           | date

Sample results

 student_id
------------
         11
         13
          7
          5
          6
         14
          3
         17
*/
SELECT DISTINCT student_id
FROM snap_test_results
WHERE date BETWEEN '2023-09-17' AND '2023-09-23'  -- This week
AND student_id NOT IN (
    SELECT DISTINCT student_id
    FROM snap_test_results
    WHERE date BETWEEN '2023-09-10' AND '2023-09-16'  -- Last week
);


