/*
Write a query to return GROUCHO WILLIAMS' actor_id.					
Actor's first_name and last_name are all stored as UPPER case in our database, and the database is case sensitive.					
					
Data					
actor_id	first_name	last_name			
1	        PENELOPE	GUINESS			
2		NICK		WAHLBERG			
3		ED		CHASE			
4		JENNIFER	DAVIS			
5		JOHNNY		LOLLOBRIGIDA			
					
actor_id	first_name	last_name			
integer	text	text			
					
Output					
actor_id					
actor_id1					
					
*/


SELECT					
	actor_id				
FROM					
	actor				
WHERE					
	first_name = 'GROUCHO' AND				
	last_name = 'WILLIAMS'				
LIMIT 5					
;					
