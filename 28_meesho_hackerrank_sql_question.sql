
USE DaysOfSQL;

DROP TABLE IF EXISTS products
create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

SELECT * FROM products
SELECT * FROM customer_budget

--mine
WITH final AS(
    SELECT *,
    RANK() OVER(PARTITION BY c.customer_id ORDER BY p.cost) AS affordable,
    CASE WHEN SUM(p.cost) OVER(PARTITION BY c.customer_id ORDER BY p.cost ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) < c.budget THEN 1 ELSE 0 END AS valid_products
    FROM customer_budget c
    JOIN products p ON c.budget >= p.cost 
)
SELECT customer_id, budget,
COUNT(product_id) AS no_of_products,
STRING_AGG(product_id, ',') AS products
FROM final
WHERE valid_products=1
GROUP BY customer_id, budget


--method 1
WITH running_cost AS(
    SELECT *,
    SUM(cost) OVER(ORDER BY cost) AS r_cost
    FROM products
)
SELECT customer_id, budget, 
COUNT(1) AS no_of_products, STRING_AGG(product_id, ',') AS list_of_products
FROM customer_budget cb
LEFT JOIN running_cost rc ON rc.r_cost <= cb.budget
GROUP BY  customer_id, budget


