/*
Write a query to return the top 3 domains (ordered by shown rate) in each testing bucket

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
*/
WITH domain_shown_rate AS (
    SELECT 
        s.ab_testing_bucket_id,
        SUBSTRING_INDEX(SUBSTRING_INDEX(r.page_url, '//', -1), '/', 1) AS domain,
        SUM(CASE WHEN r.is_shown = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(r.result_id) AS shown_rate
    FROM 
        apple_search s
    JOIN 
        apple_search_results r ON s.search_id = r.search_id
    GROUP BY 
        s.ab_testing_bucket_id,
        domain
)

SELECT 
    ab_testing_bucket_id,
    domain,
    shown_rate
FROM (
    SELECT 
        ab_testing_bucket_id,
        domain,
        shown_rate,
        ROW_NUMBER() OVER (PARTITION BY ab_testing_bucket_id ORDER BY shown_rate DESC) AS rn
    FROM 
        domain_shown_rate
) AS ranked_results
WHERE 
    rn <= 3;
