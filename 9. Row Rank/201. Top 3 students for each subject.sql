/*
Instruction

Write a query to return the top 3 students for each subject.
If a student took multiple tests for the same subject, only use their highest score.
We assume there are at least 3 students who took at least one exam for each subject.
If there are ties, return all students.
Table: snap_test_results 

Students test scores on 3 different subjects, a student can take the same subject multiple times. The exam is online and student can take any subject at any time during the two weeks from Sep 10, 2023 and Sep 23, 2023.

   col_name     | col_type
----------------+--------------------------
 student_id     | int
 subject        | varchar(30)
 score          | integer
 date           | date

Sample results

 student_id |         subject          | highest_score
------------+--------------------------+---------------
          9 | Computer Science         |           100
          1 | Computer Science         |            90
         16 | Computer Science         |            90
          9 | Introduction to Database |            98
         16 | Introduction to Database |            97
          5 | Introduction to Database |            92
          9 | Machine Learning         |            95
          5 | Machine Learning         |            89
         16 | Machine Learning         |            88
*/
WITH scores AS (
  SELECT student_id,
         subject,
         MAX(score) as highest_score
  FROM snap_test_results
  GROUP BY student_id, subject
),
top_students AS (
  SELECT student_id,
         subject,
         highest_score,
         RANK() OVER (PARTITION BY subject ORDER BY highest_score DESC) AS ranking
  FROM scores
)
SELECT student_id, subject, highest_score
FROM top_students
WHERE ranking <= 3
ORDER BY subject, ranking;
