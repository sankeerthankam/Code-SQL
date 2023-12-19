/*
Write a query to return the name of the top song in the US on new year's day: 2021-01-01.

Table 1: song 

  col_name   | col_type
-------------+--------------------------
   song_id   | bigint
   title     | varchar(1000)
   artist_id | bigint
Table 2: song_plays 

Number of times a song is played (streamed), aggregated on daily basis.

  col_name   | col_type
-------------+--------------------------
 date        | date
 country     | varchar(2)
 song_id     | bigint
 num_plays   | bigint
Sample results

title
------------
Eminence Front
*/
SELECT S.title
FROM song_plays d   
INNER JOIN song S
ON S.song_id = d.song_id
WHERE d.country = 'US'
AND d.date = '2021-01-01'
ORDER BY num_plays DESC
LIMIT 1
