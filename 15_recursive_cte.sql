-- Total sales by year

USE DaysOfSQL;

create table sales ( product_id int, period_start date, period_end date, average_daily_sales int ); 
insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

SELECT * FROM sales;


WITH r_cte AS(
    SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date FROM sales
    UNION ALL
    SELECT DATEADD(DAY,1,dates) AS dates, max_date FROM r_cte
    WHERE dates < max_date
    
)

SELECT product_id, YEAR(dates) AS report_year,  SUM(average_daily_sales) AS total_amount
FROM r_cte
JOIN sales ON dates BETWEEN period_start AND period_end
GROUP BY product_id, YEAR(dates)
ORDER BY product_id, YEAR(dates)

OPTION(maxrecursion 1000)


