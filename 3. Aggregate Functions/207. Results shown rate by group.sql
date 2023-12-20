/*
Calculate the overall % of results that are shown by ab testing group
Exclude searches with no results.
This metric gives us a sense on how deep a user scroll down to the search results page.
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

 ab_testing_bucket_id |  percentage_shown
----------------------+---------------------
                    0 | 36.3970088375254929
                    1 | 37.4620522161505768
*/
SELECT
    s.ab_testing_bucket_id,
    (SUM(CASE WHEN r.is_shown = TRUE THEN 1 ELSE 0 END)* 100.0  / COUNT(r.result_id))  AS percentage_shown
FROM
    apple_search s
JOIN
    apple_search_results r ON s.search_id = r.search_id
GROUP BY
    s.ab_testing_bucket_id;
