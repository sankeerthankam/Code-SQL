/*
Instruction

Write a query to return the top 5 artists id and their names for US on New Year's day: 2021-01-01.
For simplicity, we can assume there is no tie.
The order of your results doesn't matter.
Table 1: artist 

  col_name   | col_type
-------------+--------------------------
 artist_id   | bigint
 name       | varchar(255)

Table 2: song 

  col_name   | col_type
-------------+--------------------------
   song_id   | bigint
   title     | varchar(1000)
   artist_id | bigint
Table 3: song_plays 

Number of times a song is played (streamed), aggregated on daily basis.

  col_name   | col_type
-------------+--------------------------
 date        | date
 country     | varchar(2)
 song_id     | bigint
 num_plays   | bigint
Sample results

 artist_id | name
-----------+-----------
10000063.  | SAINt JHN
10000010.  | Justin Bieber
10000066.  | Old Dominion
10000014.  | DaBaby Featuring Roddy Ricch
10000068   | Jhene Aiko
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
        AND P.country = 'US'
	GROUP BY 1,2
)
SELECT A.artist_id, A.name
FROM artist_plays P
INNER JOIN artist A
ON A.artist_id = P.artist_id
ORDER BY num_plays DESC
LIMIT 5;
