/*
Write a query to return the second best seller for each category by revenue.
Revenue: a total of unit_price * qty.
Skip categories with less than 2 products.

Data
orders
order_id	product_id	customer_id	order_dt	  qty	unit_price_usd	channel
114215193	10000025	  1027	      2021-08-17	1	  24.95	          mobile
668786589	10000034	  1014	      2021-08-08	4	  9.95	          mobile
51146435	10000096	  1028	      2021-08-27	1	  199.5	          desktop

product_category
product_id	category_id
10000000	  3
10000001	  2
10000002	  3


Table Structure
orders
order_id	product_id	customer_id	order_dt	  qty	unit_price_usd	channel
bigint    bigint      bigint      date        int float           varchar(20)

product_category
product_id  product_category_id
bigint      smallint

product_category_id | product_id |      revenue       
---------------------+------------+--------------------+---------
                   1 |   10000052 |  4586.589999999999 
                   2 |   10000030 |            4731.81 
                   3 |   10000098 |  5045.109999999999 
*/

WITH CTE as 
(SELECT 
	p.product_category_id, o.product_id, SUM(o.unit_price_usd * o.qty) as revenue
FROM 
	orders o
LEFT JOIN
		product_category p
ON 
	o.product_id = p.product_id 
GROUP BY 
 	p.product_category_id, o.product_id
)

SELECT product_category_id, product_id, revenue
FROM 
  (SELECT 
	  product_category_id, product_id, revenue,
	  RANK() OVER(PARTITION BY product_category_id order by revenue desc) as ranking
  FROM 
	  CTE
  )  a
WHERE 
	 a.ranking = 2;
