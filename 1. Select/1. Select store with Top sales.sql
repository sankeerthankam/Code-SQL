# Table Structure
# store	manager	total_sales
# text	text	numeric
  
# Data						
# store		manager		total_sales		
# Woodridge	Jon Stephens	33927.04		
# Lethbridge	Mike Hillyer	33489.47				

SELECT 
	store, manager
FROM
	sales_by_store
ORDER BY
	total_sales DESC
	LIMIT 1
