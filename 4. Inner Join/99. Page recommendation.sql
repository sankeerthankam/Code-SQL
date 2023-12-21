/*
Write a query to recommend Facebook pages for a user with id=1.
Hint: We assume pages user 1 will like are the top 8 pages that his/her friends liked.
If user_id=1 has already liked a page, remove this page from the recommended list.
Table 1: friends 

Users and their friends, each row is a pair of friends.

  col_name   | col_type
-------------+--------------------------
 user_id     | bigint
 friend_id   | bigint

Table 2: liked_page 

Pages a user liked.

  col_name   | col_type
-------------+--------------------------
 user_id     | bigint
 page_id     | bigint

Sample results

page_id
-------------
2001
2002
*/
WITH  friends_liked_pages AS
(
  SELECT user_id, page_id
  FROM liked_page
  WHERE user_id IN (
      SELECT friend_id FROM exercise.friends WHERE user_id = 1
  )
),
page_liked_count AS  (
	SELECT page_id, COUNT(DISTINCT user_id) AS num_liked_friends
	FROM friends_liked_pages
        WHERE page_id NOT IN (
            SELECT page_id FROM liked_page WHERE user_id = 1
        )
	GROUP BY page_id
)
SELECT
  page_id  
FROM page_liked_count
ORDER BY num_liked_friends DESC
LIMIT 8;
