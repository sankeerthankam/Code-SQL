/*
Write a query to return the overall acceptance rate of friend requests.
acceptance rate: number of acceptance divided by number of requests.
Hint: a sender can make multiple requests to the same people, a recipient can accept a request multiple times.
If there are no requests, you should return 0.
Table 1: accepted_request 

Log when a friend request is accepted

  col_name      | col_type
----------------+------------------------
 sender_id      | bigint
 recipient_id   | bigint
 acceptance_dt  |  date
Table 2: friend_request 

Friend request table

  col_name    | col_type
--------------+--------------------------
 sender_id    | bigint
 recipient_id | bigint
 request_dt   | date

Sample results

acceptance_rate    
--------------+-------
0.2
*/
WITH A AS (
	SELECT COUNT(*) AS num_acceptance FROM (
		SELECT DISTINCT sender_id, recipient_id 
		FROM accepted_request
	) X 
),

B AS (
	SELECT COUNT(*) AS num_requests FROM (
		SELECT DISTINCT sender_id, recipient_id 
		FROM friend_request
	) X 
)

SELECT A.num_acceptance * 1.0 / B.num_requests
FROM A, B;
