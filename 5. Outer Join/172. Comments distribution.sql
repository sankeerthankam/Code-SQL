/*
Write a query to return the distribution of contents' by the number of comments.
Our goal is to find out how many contents have this number of comments.
Table: content_action 

Content type can only be one of the 4: status_update, photo, video, comment. You can't comment on others' comments.

    Column    |         Type          
--------------+-----------------------
 date         | date                
 user_id      | bigint            
 content_id   | bigint         
 content_type | character varying(20) -- status_update, photo, video, comment
 target_id    | bigint                -- original conent_id associated with this comment
Sample results

 num_comments | num_contents
--------------+--------------
            0 |            6
            1 |            3
            2 |            1
*/
WITH comments_cnt as (
    SELECT A.content_id, SUM(case when B.target_id IS NULL THEN 0 ELSE 1 END ) AS num_comments
    FROM content_action A
    LEFT JOIN content_action B
    ON A.content_id= B.target_id
    GROUP BY A.content_id
)
SELECT num_comments, COUNT(content_id) AS num_contents
FROM comments_cnt
GROUP BY num_comments;
