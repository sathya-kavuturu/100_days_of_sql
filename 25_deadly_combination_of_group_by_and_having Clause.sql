--Select students with same marks in physics and chemistry
USE DaysOfSQL;

create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

SELECT * FROM exams

SELECT student_id
FROM exams
WHERE subject IN ('Physics', 'Chemistry')
GROUP BY student_id
HAVING COUNT(DISTINCT subject) = 2 AND COUNT(DISTINCT marks) =1
