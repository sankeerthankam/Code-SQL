/*
Context

Twitter's users can create an advertiser account so that they start ad campaigns;
A campaign has a unique campaign_id and a unique campaign_type;
Activation day is the first day an advertiser account starts spending.
Instruction

Write a query to find the activation day for every account.
Return null if an account has not activated any of the campaigns yet.
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

 account_id | start_date
------------+------------
       8006 | 2022-01-05
       8010 | null
*/
SELECT
    C.account_id,
    MIN(S.date) AS start_date
FROM twitter_campaigns C
LEFT JOIN twitter_campaign_spend S
ON C.campaign_id = S.campaign_id
AND S.spend > 0
GROUP BY 1;
