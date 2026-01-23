
USE DaysOfSQL;

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

SELECT * FROM players_location


SELECT
    MAX(CASE WHEN city='Bangalore' THEN name ELSE NULL END) AS Bangalore,
    MAX(CASE WHEN city='Mumbai' THEN name ELSE NULL END) AS Mumbai,
    MIN(CASE WHEN city='Delhi' THEN name ELSE NULL END) AS Delhi
FROM(
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY city ORDER BY name) AS player_groups
    FROM players_location
) a 
GROUP BY player_groups



