/*Writw an SQL query to find winner in each group
The winner in each group is the player who score dthe maximum total points  within the group. 
In case of a tie, the lowest plater_id wins
*/

USE DaysOfSQL;

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

SELECT * FROM players;
SELECT * FROM matches;


WITH players_score AS(
    SELECT first_player AS player_id, first_score AS score
    FROM matches
    UNION ALL
    SELECT second_player AS player_id, second_score AS score
    FROM matches
)
, agg_players_score AS(
    SELECT player_id, SUM(score) AS score
    FROM players_score
    GROUP BY player_id
)
,final_list AS(
    SELECT 
    p.group_id, p.player_id, ps.score,
    RANK() OVER(PARTITION BY p.group_id ORDER BY ps.score DESC, p.player_id) AS winner
    FROM players p
    JOIN agg_players_score ps ON p.player_id = ps.player_id
)

SELECT
group_id, player_id, score
FROM
final_list
WHERE winner = 1







