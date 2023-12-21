/*
Instruction

Write a query to return the average difference of the last two tests the same student took for the same subject.
We assume there are at least one student that took multiple tests for each subject.
Table: snap_test_results 

Students test scores on 3 different subjects, a student can take the same subject multiple times. The exam is online and student can take any subject at any time during the two weeks from Sep 10, 2023 and Sep 23, 2023.

   col_name     | col_type
----------------+--------------------------
 student_id     | int
 subject        | varchar(30)
 score          | integer
 date           | date

Sample results

         subject          | avg_difference
--------------------------+----------------
 Computer Science         |             15
 Machine Learning         |             11
 Introduction to Database |           15.5
*/
WITH cte AS (
  SELECT student_id, subject, score,
         LEAD(score) OVER (PARTITION BY student_id, subject ORDER BY date) AS next_score
  FROM snap_test_results
  ORDER BY student_id, subject, date
),
diff AS (
  SELECT student_id, subject,
         ABS(score - next_score) AS score_difference
  FROM cte
  WHERE next_score IS NOT NULL
)
SELECT subject, AVG(score_difference) AS avg_difference
FROM diff
GROUP BY subject;
