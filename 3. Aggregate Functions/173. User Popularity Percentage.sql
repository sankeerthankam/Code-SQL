/*
Write a query to compute the popularity percentage of the following users.
user_id in ( 1, 3, 5, 7, 9)
Popularity percentage: number of friends * 100.0 / total number of users
Table: friends 

Users and their friends, each row is a pair of friends.

  col_name   | col_type
-------------+--------------------------
 user_id     | bigint
 friend_id   | bigint

Sample results

 user_id |     pop_percentage
---------+------------------------
       1 |     1.0020040080160321
       3 |     1.0020040080160321
*/
WITH all_users AS (
    SELECT DISTINCT user_id AS user_id FROM friends
    UNION
    SELECT DISTINCT friend_id AS user_id FROM friends
)
SELECT user_id, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM all_users) AS pop_percentage
FROM friends
WHERE user_id IN (1,3,5,7,9)
GROUP BY user_id;
