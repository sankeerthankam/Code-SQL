/*
Write a query to return the name of the top song in the US and UK in the first 7 days of 2021: 2021-01-01 - 2021-01-07, respectively.

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

 country      | song_name
--------------+-----------------
           US |  Superhero
           UK |  Eminence Front
*/
WITH song_plays AS (
	SELECT 
	    S.song_id,
	    P.country,
	    MAX(S.title) AS title,	    	    
	    SUM(num_plays) num_plays
	FROM song_plays P
	INNER JOIN song S
	ON P.song_id = S.song_id
	WHERE P.date >= '2021-01-01'
	AND P.date <= '2021-01-07'	
	GROUP BY S.song_id, P.country
),
song_ranking AS(
	SELECT song_id, title, country, num_plays, ROW_NUMBER() OVER(PARTITION BY country ORDER BY num_plays DESC) AS ranking
	FROM song_plays
	WHERE country IN ('US', 'UK')
)
SELECT country, title
FROM song_ranking
WHERE ranking = 1;
