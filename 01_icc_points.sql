USE DaysOfSQL;

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;


SELECT
A.team_name,
COUNT(*) AS no_of_matches_played,
SUM(win_flag) AS no_of_matches_won,
COUNT(*) - SUM(win_flag) AS no_of_losses
FROM 
(
    SELECT 
    team_1 as team_name,
    CASE WHEN winner = team_1 THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
    UNION ALL
    SELECT 
    team_2 as team_name,
    CASE WHEN winner = team_2 THEN 1 ELSE 0 END AS win_flag
    FROM icc_world_cup
) A
GROUP BY team_name
ORDER BY no_of_matches_won DESC;


