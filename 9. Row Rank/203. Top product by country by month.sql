/*
This is a follow up quesiton of 202.
Write a query to return the top product by country by mouth in the first 4 months of 2023.
Each product_name is unique, there are no two products share the same name.
Rank order products by their active paid subscriptions.
Use rank() function to return the top products that share the same amount of active subscriptions, if there are ties.
Table 1: apple_subscription 

Subscription table

     Column      |            Type             
-----------------+-----------------------------
 subscription_id | bigint                      
 product_name    | character varying(100)      
 country         | character varying(2)        
 start_at        | timestamp 
 end_at          | timestamp
 state           | character varying(20)       
Table 2: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Sample results

 country | product_name | subscription_count | month | ranking
---------+--------------+--------------------+-------+---------
 AU      | iCloud 50GB  |                  1 |     1 |       1
 AU      | Netflix      |                  1 |     1 |       1
 AU      | Apple Music  |                  1 |     1 |       1
 AU      | Spotify      |                 23 |     2 |       1
 AU      | Apple Music  |                 28 |     3 |       1
 AU      | Apple Music  |                 36 |     4 |       1
 CA      | ChatGPT Plus |                  2 |     1 |       1
 CA      | iCloud 50GB  |                  2 |     1 |       1
*/
WITH month_start_dt AS (
    SELECT date, MONTH(date) AS month
    FROM dates
    WHERE date >= '2023-01-01'
    AND date < '2023-05-01'
    AND DAY(date) = 1
),
product_subscriptions AS (
    SELECT
        country,
        product_name,
        month,
        COUNT(DISTINCT subscription_id) AS subscription_count
    FROM apple_subscription S
    JOIN month_start_dt D
    ON S.start_at <= D.date
    AND S.end_at >= D.date
    WHERE S.state = 'paid'
    GROUP BY country, product_name, month
),
product_ranking AS (
    SELECT 
        country, 
        product_name, 
        month, 
        subscription_count,  
        RANK() OVER (PARTITION BY country, month ORDER BY subscription_count DESC) AS ranking
    FROM product_subscriptions
)
SELECT country, product_name, month, subscription_count,  ranking
FROM product_ranking
WHERE ranking = 1;
