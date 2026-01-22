-- total charges as per billing rate

USE DaysOfSQL;

create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4);

SELECT * FROM billings
SELECT * FROM HoursWorked



WITH date_range AS(
SELECT *,
LEAD(DATEADD(DAY,-1,bill_date),1, '9999-12-31') OVER(PARTITION BY emp_name ORDER BY bill_date) AS bill_date_end
FROM billings)

SELECT dr.emp_name, SUM(hr.bill_hrs*dr.bill_rate) AS total_charges
FROM date_range dr 
JOIN HoursWorked hr ON dr.emp_name = hr.emp_name AND 
    hr.work_date BETWEEN dr.bill_date AND dr.bill_date_end
GROUP BY dr.emp_name

