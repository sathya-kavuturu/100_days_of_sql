USE DaysOfSQL;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

SELECT * FROM activity;


-- Q1. find the total active users each day
SELECT event_date, COUNT(DISTINCT user_id) AS total_active_users
FROM activity
GROUP BY event_date


-- Q1. find the total active users each week
SELECT DATEPART(WEEK,event_date) AS week, COUNT(DISTINCT user_id) AS total_active_users
FROM activity
GROUP BY DATEPART(WEEK,event_date)


--Q3. Date wise total numbe of users 
-- who made the purchase same day they installed the app

SELECT event_date, COUNT(new_user) FROM (
    SELECT user_id, event_date, 
    CASE WHEN COUNT(DISTINCT event_name) = 2 THEN user_id ELSE NULL END AS new_user
    FROM activity 
    GROUP BY user_id, event_date
) a
GROUP BY event_date



-- Q4. Percentage of paid users in India, USA and 
-- any other country be tagged as others


WITH agg_countries AS(
    SELECT 
    CASE WHEN country IN ('India', 'USA') THEN country ELSE 'Others' END AS new_country,
    COUNT(DISTINCT user_id) AS no_of_users
    FROM activity
    WHERE event_name = 'app-purchase'
    GROUP BY CASE WHEN country IN ('India', 'USA') THEN country ELSE 'Others' END
)
, total as(
    SELECT COUNT(no_of_users) AS total_count
    FROM agg_countries
)

SELECT
new_country, SUM(no_of_users*1.0)/total_count AS perc_users
FROM agg_countries, total



-- Q5. Among all the users who installed the app on a given day, 
-- how many did in app purchased on the very next day - day wise results

WITH prev_data AS(
    SELECT *,
    LAG(event_date,1) OVER(PARTITION BY user_id ORDER BY event_date) AS prev_event_date,
    LAG(event_name,1) OVER(PARTITION BY user_id ORDER BY event_date) AS prev_event_name
    FROM activity
)
SELECT *
FROM prev_data
WHERE prev_event_name = 'app-installed' AND event_name = 'app-purchase'
    AND DATEDIFF(DAY, prev_event_date, event_date) = 1