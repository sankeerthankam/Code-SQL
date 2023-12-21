/*
Instruction

Write a query to return top song id for every country, respectively, during the first 7 days of 2021: 2021-01-01 - 2021-01-07
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

 country |        title        | num_plays
---------+---------------------+-----------
 AU      | Hot                 |  11734009
 CA      | Bad Guy             |   5430133
 CN      | Dynamite            |   4758076
 DE      | High Fashion        |   8802157
 ES      | Yummy               |   4819624
 FR      | Does To Me          |   9416258
 IN      | Laugh Now Cry Later |  10754927
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
)
SELECT country, title, num_plays
FROM song_ranking
WHERE ranking = 1;
