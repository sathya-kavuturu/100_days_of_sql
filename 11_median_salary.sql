-- Find Median salary

USE DaysOfSQL;

DROP TABLE IF EXISTS emp;

create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);


--Method 1
WITH cte AS (
    SELECT *,
    ROW_NUMBER() OVER(ORDER BY emp_age ) AS rn_asc,
    ROW_NUMBER() OVER(ORDER BY emp_age DESC) AS rn_desc
    FROM emp
    --WHERE emp_id <10
    )

SELECT AVG(emp_age) AS median_age
FROM cte 
WHERE ABS(rn_asc-rn_desc) <= 1


--Method 2
SELECT *,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY emp_age) OVER() AS median_age
FROM emp




