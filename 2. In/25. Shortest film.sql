/*
Instruction
Write a query to return the title of the film with the minimum duration.
A movie's duration can be found using the length column.
If there are ties, e.g., two movies have the same length, return either one of them.
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
 SHORT FILM
*/

SELECT title
FROM film
ORDER BY length
LIMIT 1;
