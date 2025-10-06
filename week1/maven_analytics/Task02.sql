

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

