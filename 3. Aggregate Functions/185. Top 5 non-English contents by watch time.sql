/*
Write a query to return the top 5 non-English (original_language <> 'EN') contents based on the total watched time within 28 days of their release.

Fun fact:

Speaking on stage at Vox Media’s Code Conference in Beverly Hills, Calif., Sarandos shared slides revealing Netflix’s most popular series and movies by both the number of accounts that watched them in their first 28 days on the streaming platform and the number of hours that they were watched in that timeframe.

https://variety.com/2021/digital/news/netflix-most-popular-tv-shows-movies-1235075301/

Table 1: netflix_content 

 col_name          | col_type
-------------------+---------------------
 content_id        | bigint
 content_type      | character varying(10) -- either TV or Movie
 original_language | character varying(2) -- 'EN',  'ES', 'CN', 'KO'
 release_date      | date
Table 2: netflix_daily_streaming 

Daily aggregated watch time by account by content.

  col_name    | col_type
--------------+---------------------
 date         | date
 account_id   | bigint
 content_id   | bigint
 duration     | int -- in seconds
Sample results

 content_id | watch_time_in_seconds
------------+-----------------------
    1000224 |                 26808
    1000641 |                 24902
    1000638 |                 24627
    1000869 |                 21325
    1000580 |                 20884
*/
WITH non_english_content AS (
  SELECT content_id, release_date
  FROM netflix_content
  WHERE original_language <> 'EN'
)
SELECT N.content_id, SUM(duration) watch_time_in_seconds
FROM non_english_content N
INNER JOIN netflix_daily_streaming S
ON S.content_id = N.content_id
WHERE S.date <= DATE_ADD(N.release_date, INTERVAL 28 DAY)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
