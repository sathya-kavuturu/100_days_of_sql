USE DaysOfSQL;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;




WITH distinct_resources AS (
    SELECT DISTINCT name, resources
    FROM entries 
    
)
,agg_resources AS (
    SELECT name, STRING_AGG(resources, ',') AS used_resources
    FROM distinct_resources
    GROUP BY name
)
,total_visits AS (
    SELECT name, COUNT(1) AS total_visit
    FROM entries
    GROUP BY name
)
,floor_visited AS (
    SELECT name, floor,
    COUNT(1) AS floor_visited_count,
    RANK() OVER(PARTITION BY name ORDER BY COUNT(1) DESC) AS rank
    FROM entries
    GROUP BY name, floor
)

SELECT
fv.name,
tv.total_visit ,
fv.floor AS most_visited_floor,
ag.used_resources
FROM floor_visited fv
JOIN total_visits tv ON fv.name=tv.name
JOIN agg_resources ag ON fv.name=ag.name
WHERE rank=1