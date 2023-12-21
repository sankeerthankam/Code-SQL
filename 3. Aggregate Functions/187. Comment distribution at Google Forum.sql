/*
Write a query to report the distribution of the number of comments made within the same day a question is posted.
Using the following buckets to count the number of questions with the following number of comments.
0
1
>=2, <5
>=5
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

 num_comments | cnt
--------------+-----
 0            |  42
 1            |  40
 >=2, <5      |  13
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
),
comments_stat AS (
    SELECT
        CASE WHEN num_comments = 0 THEN '0'
             WHEN num_comments = 1 THEN '1'
             WHEN num_comments <5  THEN '>=2, <5'
             ELSE '>=5' END AS num_comments,
        post_id
    FROM (
        SELECT Q.post_id, COUNT(C.post_id) AS num_comments
        FROM questions Q
        LEFT JOIN comments C
        ON Q.post_id = C.post_id
        AND Q.created_dt = C.created_dt
        GROUP BY 1
    ) X
)
SELECT num_comments, COUNT(DISTINCT post_id) as cnt
FROM comments_stat
GROUP BY 1;
