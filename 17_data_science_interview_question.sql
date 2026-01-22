USE DaysOfSQL;

DROP TABLE IF EXISTS orders
create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

DROP TABLE IF EXISTS products
create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

SELECT * FROM orders;
SELECT * FROM products;



SELECT p1.name + ' '+ p2.name AS pair, COUNT(1) AS frequency_count

FROM orders o1
JOIN orders o2 ON o1.order_id=o2.order_id
JOIN products p1 ON o1.product_id = p1.id
JOIN products p2 ON o2.product_id = p2.id
WHERE  o1.product_id < o2.product_id
GROUP BY p1.name, p2.name

