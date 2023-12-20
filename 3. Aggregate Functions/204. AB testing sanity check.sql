/*
Instructions

 Assumption:
If the sample size (unique search_id) between the two groups is smaller than 5%, we assume the two groups have equal size
Write a query to compute the difference in sample size between the two groups using the following formula:
(sample size of control - sample size of testing) * 100.0 / sample size of control.
Table: apple_search 

Search id by two different ab testing groups: --0: control, 1, testing

   col_name              | col_type
-------------------------+--------------------------
  search_id              | uuid
  ab_testing_bucket_id   | smallint --0: control, 1, testing
Sample results

 sample_difference_percentage
------------------------------
           7.6923076923076923
*/
WITH control AS (
    SELECT COUNT(*) AS control_count
    FROM apple_search
    WHERE ab_testing_bucket_id = 0
),
testing AS (
    SELECT COUNT(*) AS testing_count
    FROM apple_search
    WHERE ab_testing_bucket_id = 1
)
SELECT
    (control_count - testing_count) * 100.0 / control_count AS sample_difference_percentage
FROM control, testing;
