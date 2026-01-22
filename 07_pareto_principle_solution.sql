-- Pareto Principle :- 80% of consequences come from 20% of the causes
-- 80% of sales come from 20% of products

USE DaysOfSQL;

--SELECT 0.8 * SUM(sales) FROM orders;
--C.77711996


WITH product_wise_sales AS (
	SELECT product_id, SUM(sales) AS product_sales
	FROM orders
	GROUP BY product_id
	),
	cal_sales AS(
	SELECT 
	product_id,
	product_sales,
	SUM(product_sales) OVER(ORDER BY product_sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sales,
	0.8* SUM(product_sales) OVER() AS total_sales
	FROM product_wise_sales
	)

SELECT * FROM cal_sales WHERE running_sales <= 1837760.77711996





