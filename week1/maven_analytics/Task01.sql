-- Connect to database (Postgresql)

\c maven 

-- ASSIGNMENT 1: Basic Joins
-- Looking at the orders and products tables, which products exist in one table, but not the othe



-- View the orders and products tables

SELECT *
FROM products p ;

SELECT * 
FROM orders o ;

-- Join the tables using various join types & note the number of rows in the output

SELECT 		COUNT(*)
FROM		products p INNER JOIN	
			orders o ON 			
			p.product_id = o.product_id ; 

-- 8.549



SELECT 		COUNT(*)
FROM 		products p LEFT  JOIN 
			orders o ON 
			o.product_id = p.product_id ;

-- 8,552


-- View the products that exist in one table, but not the other

SELECT 		*
FROM 		products p LEFT JOIN orders o 
			ON p.product_id = o.order_id 
WHERE 		p.product_id IS NULL ;

SELECT 		*
FROM 		products p RIGHT JOIN orders o 
			ON p.product_id = o.product_id 
WHERE 		p.product_id IS NULL ;

-- Pick a final JOIN type to join products and orders

SELECT  	p.product_id ,p.product_name  ,
			o.product_id AS orders_product_id
FROM 		products p  LEFT JOIN orders o 
			ON p.product_id = o.product_id 
WHERE 		p.product_id  IS NULL ;





