/*
Write a query to return the average score for each of the 3 subjects
We assume there is at least one test score for each subject
If a student took multiple tests, use their highest score.
Table: snap_test_results 

Students test scores on 3 different subjects, a student can take the same subject multiple times. The exam is online and student can take any subject at any time during the two weeks from Sep 10, 2023 and Sep 23, 2023.

   col_name     | col_type
----------------+--------------------------
 student_id     | int
 subject        | varchar(30)
 score          | integer
 date           | date

Sample results

         subject          |   average_score
--------------------------+-------------------
 Computer Science         | 76.05882352941177
 Machine Learning         | 74.05263157894737
 Introduction to Database | 77.89473684210526
*/
SELECT subject, AVG(highest_score) AS average_score
FROM (
    SELECT student_id, subject, MAX(score) AS highest_score
    FROM snap_test_results
    GROUP BY student_id, subject
) AS subquery
GROUP BY subject;
