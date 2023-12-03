/*												
Write a query to return the titles of the 5 shortest movies by duration.												
The order of your results doesn't matter.												
												
Data												
film_id	            title	description	release_year	language_id	original_language_id	rental_duration	rental_rate	length	replacement_cost	rating	last_update	
1	ACADEMY DINOSAUR	  A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies	2006	1	NULL	6	0.99	86	20.99	PG	2017-09-10 17:46:03.905795-07	
2	ACE GOLDFINGER	A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China	2006	1	NULL	3	4.99	48	12.99	G	2017-09-10 17:46:03.905795-07	
												
Table Structure												
film_id	title	description	release_year	language_id	original_language_id	rental_duration	rental_rate	length	replacement_cost	rating	last_update	
integer	text	text	integer	smallint	smallint	smallint	numeric	smallint	numeric	text	timestamp	
												
Output												
title												
title1												
title2												
title3												
title4												
title5												
*/


SELECT												
	title											
FROM												
	film											
ORDER BY												
	length ASC											
LIMIT 5												
