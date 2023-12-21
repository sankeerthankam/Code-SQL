/*
Write a query to return the top 1 question by each department.
Rank order the question's popularity by the number of comments on the same day the post was created.
When counting the number of comments for a question, exclude all the comments made by the author.
Table 1: google_employee 

   col_name   | col_type
--------------+--------------------------
 employee_id  | int
 start_dt     |  date
 department   | varchar(30)

Table 2: google_forum 

Google's internal Q&A forum.

   col_name   | col_type
--------------+--------------------------
 created_dt   | date
 post_id      | int
 post_type    | varchar(20) -- either a question or a comment 
 employee_id  | int
 content      | text 
Sample results

   department   | post_id
----------------+---------
 Engineering    |      19
 Executives     |     120
 Human Resource |      97
 Marketing      |      50
*/
WITH post_questions AS(
  SELECT 
	gf.post_id AS question_id,
	gf.employee_id AS question_author,
  	ge.department
  FROM google_forum AS gf
  INNER JOIN google_employee AS ge
  ON ge.employee_id = gf.employee_id
  WHERE post_type = 'question'
  ),
post_comments AS(
  SELECT 
	gf.post_id AS comment_id,
	gf.employee_id AS comment_author
  FROM google_forum AS gf
  LEFT JOIN google_employee AS ge
  ON gf.employee_id = ge.employee_id
  WHERE post_type = 'comment'
  ),
post_questions_comments AS(
  SELECT
  	pq.department,
  	pq.question_id,
  	COUNT(pc.comment_id) AS num_comments
  FROM post_questions AS pq
  LEFT JOIN post_comments AS pc
  ON pq.question_id = pc.comment_id
  AND pq.question_author != pc.comment_author
  GROUP BY pq.department, pq.question_id
  ),
post_rankings AS(
  SELECT
  	pqc.department,
  	pqc.question_id,
  	pqc.num_comments,
  	ROW_NUMBER() OVER(PARTITION BY pqc.department ORDER BY pqc.num_comments DESC) AS ranking
  FROM post_questions_comments AS pqc
  )
  
SELECT
	pr.department,
	pr.question_id AS post_id
FROM post_rankings AS pr
WHERE pr.ranking = 1
