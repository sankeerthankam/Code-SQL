/*
Write a query to return the top 5 contents (either movie or tv) based on the number of unique accounts who watched them;
Only include accounts that watched at least 10 minutes (> 600 seconds) of the content after the movie was first released within 28 days.
Fun fact:

Speaking on stage at Vox Media’s Code Conference in Beverly Hills, Calif., Sarandos shared slides revealing Netflix’s most popular series and movies by both the number of accounts that watched them in their first 28 days on the streaming platform and the number of hours that they were watched in that timeframe.

https://variety.com/2021/digital/news/netflix-most-popular-tv-shows-movies-1235075301/

 

Table 1: netflix_account 

 col_name    | col_type
-------------+---------------------
 account_id  | bigint
 country     | character varying(2)
 created_dt  | date

Table 2: netflix_content 

 col_name          | col_type
-------------------+---------------------
 content_id        | bigint
 content_type      | character varying(10) -- either TV or Movie
 original_language | character varying(2) -- 'EN',  'ES', 'CN', 'KO'
 release_date      | date
Table 3: netflix_daily_streaming 

Daily aggregated watch time by account by content.

  col_name    | col_type
--------------+---------------------
 date         | date
 account_id   | bigint
 content_id   | bigint
 duration     | int -- in seconds
Sample results

 content_id | uu_cnt
------------+--------
    1000638 |     21
    1000491 |     21
    1000641 |     21
    1000577 |     20
    1000224 |     20
*/
WITH user_watch_time AS (
    SELECT C.content_id, S.account_id, SUM(duration) watch_time_in_seconds
    FROM netflix_content C
    INNER JOIN netflix_daily_streaming S
    ON S.content_id = C.content_id
    WHERE S.date <= DATE_ADD(C.release_date, INTERVAL 28 DAY)
    GROUP BY 1,2
)
SELECT content_id, COUNT(CASE WHEN watch_time_in_seconds > 600 THEN account_id ELSE NULL END) uu_cnt
FROM user_watch_time
GROUP BY content_id
ORDER BY 2 DESC
LIMIT 5;
