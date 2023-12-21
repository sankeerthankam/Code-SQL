/*
Context

This is a follow-up question to question #189
Twitter's users can create an advertiser account so that they can create ad campaigns on Twitter;
A campaign has a unique campaign_id and a unique campaign_type;
Once a campaign is created, its campaign_type can not be changed.
Instruction

Write a query to return the following:
campaign_id, campaign_type, campaign_start_date, march_spend (campaign total spend in march 2022)
campaign_start_date is the first day with >0 spend.
If a campaign has not started, return NULL for campaign_start_date, and 0 for march_spend.
Table 1: twitter_campaigns

List of advertising campaigns created by an ad account on Twitter.

   col_name   | col_type
--------------+--------------------------
 account_id   | bigint
 campaign_id  | bigint
 campaign_type| varchar(30)

Table 2: twitter_campaign_spend

Daily ad campaign spends by Twitter's advertiser accounts.

   col_name   | col_type
--------------+--------------------------
 campaign_id  | bigint
 date         | date
 spend        | float

Sample results

 campaign_id | campaign_start_date | campaign_type | march_spend
-------------+---------------------+---------------+-------------
      200012 |                     | branding      |           0
      200003 | 2022-01-03          | branding      |        9508
      200006 | 2022-01-07          | performance   |        7589
*/
WITH campaign_start_date AS (
    SELECT
        C.campaign_id,
        MIN(S.date) AS campaign_start_date,
        MIN(C.campaign_type) AS campaign_type
    FROM twitter_campaigns C
    LEFT JOIN twitter_campaign_spend S
    ON C.campaign_id = S.campaign_id
    AND S.spend > 0
    GROUP BY 1
),
campaign_march_spend AS (
    SELECT campaign_id, SUM(spend) AS march_spend
    FROM twitter_campaign_spend
    WHERE date>= '2022-03-01'
    AND   date<= '2022-03-31'
    GROUP BY campaign_id
)

SELECT 
    D.campaign_id, 
    D.campaign_start_date, 
    D.campaign_type, 
    COALESCE(S.march_spend,0) march_spend
FROM campaign_start_date D
LEFT JOIN campaign_march_spend S
ON D.campaign_id = S.campaign_id
ORDER BY D.campaign_id
;
