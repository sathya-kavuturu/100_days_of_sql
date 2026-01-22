-- Get the second most recent activity, 
--if there is only one activity then return that one.

USE DaysOfSQL;

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

SELECT * FROM UserActivity;


WITH ranked_users AS(
    SELECT *,
    RANK() OVER(PARTITION BY username ORDER BY endDate DESC) AS rn,
    COUNT(1) OVER(PARTITION BY username ) AS total_activities
    FROM UserActivity
)

SELECT *
FROM ranked_users
WHERE total_activities = 1 OR rn=2
