/*
Write a query to compute ROI for each advertiser.
Hint: ROI: total revenue (customer spend) / total ad spend
If no users bought any ads from an advertiser, the ROI is 0.
Table 1: ad_info 

User purchases after clicking on the ad

  col_name       | col_type
-----------------+---------------------
ad_id            | bigint     
user_id          | bigint 
spend            | float 

Table 2: advertiser 

  col_name       | col_type
-----------------+---------         
advertiser_id    | bigint     
ad_id            | bigint        
cost             | float  

Sample results

 advertiser_id |        roi
---------------+--------------------
             1 |  0.123456789
             2 |  0.234567890
*/
WITH advertiser_cost AS (
   SELECT advertiser_id, SUM(cost) AS total_cost
   FROM advertiser
   GROUP BY advertiser_id
),
revenue AS (
    SELECT SUM(spend) revenue, A.advertiser_id
    FROM ad_info I
    INNER JOIN advertiser A
    ON A.ad_id = I.ad_id
    GROUP BY  A.advertiser_id
)

SELECT C.advertiser_id, COALESCE(R.revenue, 0) / C.total_cost AS roi
FROM advertiser_cost C
LEFT JOIN revenue R
ON R.advertiser_id = C.advertiser_id
