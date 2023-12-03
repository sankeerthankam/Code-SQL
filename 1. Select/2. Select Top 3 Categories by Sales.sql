/*
Write a query to find the top 3 film categories that generated the most sales.				
The order of your results doesn't matter.				

Table Structure
category  total_sales
text      decimal

Data      
category	total_sales			
Sports	  5314.21			
Classics	3639.59			
New	      4361.57			
Family	  4226.07			
Comedy	  4383.58			
				
Output				
category				
Category 1				
Category 2				
Category 3				
				
*/

SELECT 
	category
FROM 
	sales_by_film_category
ORDER BY 
	total_sales DESC
LIMIT 3;
