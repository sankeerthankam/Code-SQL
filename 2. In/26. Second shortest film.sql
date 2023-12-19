/*
Instruction

Write a query to return the title of the second shortest film based on its duration/length.
A movie's duration can be found using the length column.
If there are ties, return just one of them.
Table: film 

       col_name       |  col_type
----------------------+--------------------------
 film_id              | integer
 title                | text
 description          | text
 release_year         | integer
 language_id          | smallint
 original_language_id | smallint
 rental_duration      | smallint
 rental_rate          | numeric
 length               | smallint
 replacement_cost     | numeric
 rating               | text
Sample results

    title
--------------
 SECOND SHORTEST
*/

SELECT  title     
FROM film    
ORDER BY length     
LIMIT 1 
OFFSET 1;
