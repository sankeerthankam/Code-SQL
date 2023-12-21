/*
Instruction

Write a query to return the top artist id for every country on New Year's Day: 2021-01-01
Return a unique row for each country
For simplicity, let's assume there is no tie.
The order of your results doesn't matter.
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

 country      | artist_id
--------------+-------
           US |  100
           UK |  200
           JP |  300
           CA |  100
           AU |  200
*/
WITH artist_plays AS (
    SELECT 
        S.artist_id,
        P.country,
        SUM(num_plays) num_plays	    
    FROM song_plays P
    INNER JOIN song S
    ON S.song_id = P.song_id
    WHERE P.date = '2021-01-01'
    GROUP BY 1,2
),

artist_ranking AS (
    SELECT 
    artist_id,
    country,
    ROW_NUMBER() OVER(PARTITION BY country ORDER BY num_plays DESC) ranking
FROM artist_plays
)

SELECT country, artist_id
FROM artist_ranking
WHERE ranking = 1;
