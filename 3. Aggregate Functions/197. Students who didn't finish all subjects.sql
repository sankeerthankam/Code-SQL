/*
Write a query to return the list of students who did not take all 3 different subjects.
Every student must have taken at least 1 subject.
Report two columns: student_id and the number of different subjects they have taken.
Table: snap_test_results 

Students test scores on 3 different subjects, a student can take the same subject multiple times. The exam is online and student can take any subject at any time during the two weeks from Sep 10, 2023 and Sep 23, 2023.

   col_name     | col_type
----------------+--------------------------
 student_id     | int
 subject        | varchar(30)
 score          | integer
 date           | date

Sample results

 student_id | num_subjects
------------+--------------
          3 |            2
          5 |            2
          6 |            2
         13 |            1
*/
SELECT student_id, COUNT(DISTINCT subject) AS num_subjects
FROM snap_test_results
GROUP BY student_id
HAVING COUNT(DISTINCT subject) < 3;
