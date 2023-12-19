/*
Write a query to return the user who received the most friend requests in January 2021.
Hint: We can assume there is one and only one person with the most requests, there is no tie.
Requests from the same sender should be deduplicated when counting.
Table: friend_request 

Friend request table

  col_name    | col_type
--------------+--------------------------
 sender_id    | bigint
 recipient_id | bigint
 request_dt   | date

Sample results

id
--------------
1000027
*/
SELECT recipient_id
FROM friend_request
WHERE request_dt >= '2021-01-01'
AND request_dt < '2021-02-01'
GROUP BY recipient_id
ORDER BY COUNT(DISTINCT sender_id) DESC
LIMIT 1;
