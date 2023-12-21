/*
Instruction

Write a query to return the average number of replies by experiment groups for experiment 2001.
the average number of replies: total number of replies/number of unique tweets count.
Report both treatment and control groups in two different rows.
Table 1: tweets 

   col_name     | col_type
----------------+--------------------------
 user_id        | bigint
 tweet_id       | bigint
 reply_tweet_id | bigint
 created_at     | timestamp
 content        | varchar(280) -- max of 280 chars
Table 2: twitter_experiment_users 

Users that have been assigned into a treatment group or not for each ab testing. A user can only belong to either treatment or control group by a single experiment.

   col_name   | col_type
--------------+--------------------------
 exp_id       | bigint
 user_id      | bigint
 is_treatment | boolean

Sample results

   group   |      avg_replies
-----------+------------------------
 control   | 0.40000000000000000000
 treatment | 0.62500000000000000000
*/
WITH user_tweet_replies AS (
    SELECT user_id, COUNT(DISTINCT tweet_id) AS num_tweets, SUM(num_replies) AS total_replies
    FROM (
        SELECT T1.user_id, T1.tweet_id, COUNT(T2.tweet_id) AS num_replies
        FROM tweets T1
        LEFT JOIN tweets T2
        ON T1.tweet_id = T2.reply_tweet_id
        GROUP BY 1,2
    ) X
    GROUP BY user_id
),
exp_2001 AS (
    SELECT user_id, is_treatment
    FROM twitter_experiment_users
    WHERE exp_id = 2001
)
SELECT
    CASE WHEN E.is_treatment is true then 'treatment' ELSE 'control' END AS group_label,
    SUM(total_replies) *1.0 / SUM(num_tweets) AS avg_replies
FROM user_tweet_replies R
INNER JOIN exp_2001 E
ON E.user_id = R.user_id
GROUP BY 1;
