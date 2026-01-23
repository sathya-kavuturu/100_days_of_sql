-- Write an SQL Query to find median salary of each company
-- Bonus points if you can solve it without using any built-in SQL function 

USE DaysOfSQL;

create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341)
insert into employee values (2,'A',341)
insert into employee values (3,'A',15)
insert into employee values (4,'A',15314)
insert into employee values (5,'A',451)
insert into employee values (6,'A',513)
insert into employee values (7,'B',15)
insert into employee values (8,'B',13)
insert into employee values (9,'B',1154)
insert into employee values (10,'B',1345)
insert into employee values (11,'B',1221)
insert into employee values (12,'B',234)
insert into employee values (13,'C',2345)
insert into employee values (14,'C',2645)
insert into employee values (15,'C',2645)
insert into employee values (16,'C',2652)
insert into employee values (17,'C',65);

SELECT * FROM employee


SELECT company,
    AVG(salary)
FROM(
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) AS rn,
        COUNT(1) OVER(PARTITION BY company) AS count
    FROM employee
) a
WHERE rn between count*1.0/2 AND count*1.0/2+1
GROUP BY company


--another method
SELECT e1.company,
       AVG(e1.salary) AS median_salary
FROM employee e1
JOIN employee e2
  ON e1.company = e2.company
GROUP BY e1.company, e1.salary
HAVING
    SUM(CASE WHEN e2.salary <= e1.salary THEN 1 ELSE 0 END) >= COUNT(*) / 2.0
AND
    SUM(CASE WHEN e2.salary >= e1.salary THEN 1 ELSE 0 END) >= COUNT(*) / 2.0;
