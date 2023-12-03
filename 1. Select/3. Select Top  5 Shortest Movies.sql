/*												
Write a query to return the titles of the 5 shortest movies by duration.												
The order of your results doesn't matter.												
												
Data												
film_id		title			length	replacement_cost	rating	last_update	
1		ACADEMY DINOSAUR	86	20.99			PG	2017-09-10 17:46:03.905795-07	
2		ACE GOLDFINGER		48	12.99			G	2017-09-10 17:46:03.905795-07	
												
Table Structure												
film_id		title			length	replacement_cost	rating	last_update	
integer		text			int	numeric			text	timestamp	
												
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
