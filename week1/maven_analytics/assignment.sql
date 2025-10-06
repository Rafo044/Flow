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








-- ASSIGNMENT 2: Self Joins

-- Which products are within 25 cents of each other in terms of unit price?
-- View the products table

SELECT 		*
FROM 		products p ;

-- Join the products table with itself so each candy is paired with a different candy

SELECT 		p.product_name ,pr.product_name 
FROM 		products p INNER JOIN products pr
			ON p.product_id  <> pr.product_id ;

        
-- Calculate the price difference, do a self join, and then return only price differences under 25 cents

SELECT 		p.product_name ,p.unit_price  ,
			pr.product_name , pr.unit_price,
			(p.unit_price - pr.unit_price ) AS price_diff
FROM 		products p INNER JOIN products pr
			ON p.product_id  <> pr.product_id 
WHERE 		ABS(p.unit_price - pr.unit_price) < 0.25 
			AND p.product_name < pr.product_name 
ORDER BY 	price_diff DESC ;

