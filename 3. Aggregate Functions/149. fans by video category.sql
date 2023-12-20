/*
If a user watches at least 2 different videos from the same category within a day, we consider this user a fan of this category.
For each category, find their fans on August 1 2021.
If a category has no fans, ignore this category.
Table: video_session

Video watch history for all users.

  col_name       | col_type
-----------------+---------------------
session_id       | bigint
user_id          | bigint
video_id         | bigint
video_category   | varchar(20)
start_at         | timestamp

Sample results

  video_category   | user_id
-------------------+---------
 Beauty & Skincare | 8000001
 Beauty & Skincare | 8000003
 Beauty & Skincare | 8000008
 Dance             | 8000001
 Dance             | 8000002
*/
SELECT video_category, user_id
FROM video_session
WHERE DATE(start_at) = '2021-08-01'
GROUP BY user_id, video_category
HAVING  COUNT(video_id) >= 2
ORDER BY video_category;
