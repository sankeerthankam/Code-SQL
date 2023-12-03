/*
Write a SQL query to return this staff's first name and last name.
Picture field contains the link that points to a staff's profile image.
There is only one staff who doesn't have a profile picture.
Use colname IS NULL to identify data that are missing.

Data									
staff_id	first_name	last_name	username	last_update	                  picture
2	        Jon	        Stephens	Jon	      2017-05-16 16:13:11.79328-07	NULL
1	        Mike	      Hillyer		Mike	    2020-06-19 12:45:26.827726-07	picture_url1
									
Table Structure									
staff_id	first_name	last_name	username	last_update	                  picture
integer	  text	       text	    text	    timestamp	                    text
									
Output									
first_name	last_name								
Jon	        Stephens								
																		
*/

SELECT									
	first_name, last_name								
FROM									
	staff								
WHERE									
	picture IS NULL								
LIMIT 5									
