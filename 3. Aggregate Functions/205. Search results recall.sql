/*
Instruction

Compute the overall percentage of searches with at least one result.
In AI and machine learning, this metric is often referred to as 'recall'.
If a search didn't yield any results, this search id will not show up in the apple_search_results table.
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

 percentage_with_results
-------------------------
     96.0500000000000000
*/
WITH total_searches AS (
    SELECT COUNT(*) AS total_search_count
    FROM apple_search
),
searches_with_result AS (
    SELECT COUNT(DISTINCT search_id) AS results_search_count
    FROM apple_search_results
)

SELECT
    (results_search_count * 100.0) / total_search_count AS percentage_with_results
FROM total_searches, searches_with_result;
