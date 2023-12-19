/*
Write a query to return the user's id with the most friends.
Hint:We can assume there is one and only one person with the most friends, there is no tie.
A request can be accepted multiple times.
Table: accepted_request 

Log when a friend request is accepted

  col_name      | col_type
----------------+------------------------
 sender_id      | bigint
 recipient_id   | bigint
 acceptance_dt  |  date
Sample results

id
--------------
1000020
*/
SELECT user_id_1 AS user_id
FROM (
	SELECT sender_id AS user_id_1, recipient_id user_id_2
	FROM accepted_request
	UNION 
	SELECT recipient_id AS user_id_1, sender_id user_id_2
	FROM accepted_request
) X
GROUP BY 1
ORDER BY COUNT(DISTINCT user_id_2) DESC
LIMIT 1;
