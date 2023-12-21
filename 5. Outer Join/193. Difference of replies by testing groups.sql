/*
This is a follow-up question to #192

Write a query to compute the average difference of the number of replies from the treatment group vs. control group for experiment 2001
Formula: (total number of replies for treatment group / total number of original tweets for treatment group) - (total number of replies for control group / total number of original tweets for the control group)
Original tweets are the first tweets to start a thread of discussions. i.e. reply_tweet_id are nulls
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

*/
WITH user_tweet_replies AS (
    SELECT user_id, COUNT(DISTINCT tweet_id) AS num_tweets, SUM(num_replies) AS total_replies
    FROM (
        SELECT T1.user_id, T1.tweet_id, COUNT(T2.tweet_id) AS num_replies
        FROM (
            SELECT * FROM tweets
            WHERE reply_tweet_id IS NULL
        )  T1
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
    SUM(CASE WHEN E.is_treatment is true then total_replies ELSE 0 END) *1.0 / SUM(CASE WHEN E.is_treatment is true then num_tweets ELSE 0 END) -
    SUM(CASE WHEN E.is_treatment is false then total_replies ELSE 0 END) *1.0 / SUM(CASE WHEN E.is_treatment is false then num_tweets ELSE 0 END) AS diff
FROM user_tweet_replies R
INNER JOIN exp_2001 E
ON E.user_id = R.user_id
;

