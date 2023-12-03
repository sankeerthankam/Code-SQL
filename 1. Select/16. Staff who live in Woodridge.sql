/*
Write a query to return the names of the staff who live in the city of 'Woodridge'							
							
Data							
id	name	        address	                phone		city		country		sid
1	Mike Hillyer	23 Workhaven Lane	14033335568	Lethbridge	Canada	  	1
2	Jon Stephens	1411 Lillydale Drive	6172235589	Woodridge	Australia	2
							
Table Structure							
id	name	        address	                phone	      	city	      	country	  	sid
int	text	        text			text	      	text	      	text	    	smallint
							
Output							
name							
name1							
							
*/


SELECT							
	name						
FROM							
	staff_list						
WHERE							
	city = 'Woodridge'						
LIMIT 5							
