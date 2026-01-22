/* 
Write a query to find personid, name,number of friends, sum of marks of person 
who have friends with total score greater than 100
*/

USE DaysOfSQL;

Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');


create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','John','63');

select * from person;
select * from friend;



WITH score_details AS (
    SELECT f.pid, 
           SUM(p.score) AS total_friend_score, 
           COUNT(1) AS no_of_friends
    FROM friend f
    JOIN person p ON f.fid = p.personid
    GROUP BY f.pid
    HAVING SUM(p.score) > 100
)

SELECT s.*, p.name AS person_name
FROM person p
JOIN score_details s ON p.personid = s.pid;