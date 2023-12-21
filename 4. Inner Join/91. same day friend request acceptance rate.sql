/*
Write a query to return the same day friend requests acceptance rate on new year's day (2021-01-01)
If a friend request is not accepted, the acceptance_dt column is null
Table: request 

Friend request and acceptance table by date.

  col_name     | col_type
---------------+--------------------------
 request_id     | bigint
 acceptance_id  | bigint
 request_dt     | date
 acceptance_dt  | date
Sample results

same_day_acceptance_rate    
--------------+-------
0.02
*/
SELECT 
  SUM(CASE WHEN acceptance_dt = request_dt THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS same_day_acceptance_rate
FROM request
WHERE request_dt = '2021-01-01'
