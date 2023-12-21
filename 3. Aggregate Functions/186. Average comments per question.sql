/*
Write a query to return the average number of comments per question.
Only include comments made on the same day a question is asked.
E.g., if a question is asked in 2022-01-01 and received 1 comment on 2022-01-01 and 3 comments on 2022-01-02, only count the 1 comment.
Table: google_forum 

Google's internal Q&A forum.

   col_name   | col_type
--------------+--------------------------
 created_dt   | date
 post_id      | int
 post_type    | varchar(20) -- either a question or a comment 
 employee_id  | int
 content      | text 
Sample results

          avg
------------------------
 0.72631578947368421053
*/
WITH questions AS (
    SELECT post_id, created_dt
    FROM google_forum
    WHERE post_type = 'question'
),
comments AS (
    SELECT post_id, created_dt
    FROM google_forum
    WHERE post_type = 'comment'
)

SELECT avg(num_comments) FROM (
    SELECT Q.post_id, COUNT(C.post_id) AS num_comments
    FROM questions Q
    LEFT JOIN comments C
    ON Q.post_id = C.post_id
    AND Q.created_dt = C.created_dt
    GROUP BY 1
) X;
