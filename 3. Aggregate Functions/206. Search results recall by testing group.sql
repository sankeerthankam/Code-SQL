/*
Instruction

This is a follow-up question to question 205.
Compute the overall percentage of searches with at least one result by ab testing group.
Table 1: apple_search 

Search id by two different ab testing groups: --0: control, 1, testing

   col_name              | col_type
-------------------------+--------------------------
  search_id              | uuid
  ab_testing_bucket_id   | smallint --0: control, 1, testing
Table 2: apple_search_results 

Search results history, if a user keeps scrolling down, more page_url will be shown to the user.

   col_name   | col_type
--------------+--------------------------
  search_id   | uuid
  result_id   | uuid
  page_url    | url
  is_shown    | boolean --true or false 
Sample results

 ab_testing_bucket_id | percentage_with_results
----------------------+-------------------------
                    0 |     96.5384615384615385
                    1 |     95.5208333333333333
*/
WITH total_searches AS (
    SELECT ab_testing_bucket_id, COUNT(*) AS total_search_count
    FROM apple_search
    GROUP BY ab_testing_bucket_id
),
searches_with_result AS (
    SELECT s.ab_testing_bucket_id, COUNT(DISTINCT sr.search_id) AS results_search_count
    FROM apple_search s
    INNER JOIN apple_search_results sr ON s.search_id = sr.search_id
    GROUP BY s.ab_testing_bucket_id
)

SELECT
    t.ab_testing_bucket_id,
    (r.results_search_count * 100.0) / t.total_search_count AS percentage_with_results
FROM total_searches t
JOIN searches_with_result r ON t.ab_testing_bucket_id = r.ab_testing_bucket_id
ORDER BY t.ab_testing_bucket_id;
