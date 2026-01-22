USE DaysOfSQL;

CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

SELECT * FROM students;

--Q1. Write an SQL Query to get list of students
-- who scored above the average marks in each subject

WITH avg_cte AS(
    SELECT subject, AVG(marks) AS avg_subject_marks
    FROM students
    GROUP BY subject
) 
SELECT s.*, ac.*
FROM students s
JOIN avg_cte ac ON s.subject=ac.subject
WHERE s.marks > ac.avg_subject_marks;


--Q2. Write an SQL Query to get the percentage of students 
-- who score more than 90 in any subject amongst the total students

--mine
WITH marks AS(
    SELECT studentid
    FROM students
    WHERE marks >90
)

SELECT ROUND(100.0 * COUNT(DISTINCT m.studentid)/COUNT(DISTINCT s.studentid),2) AS percentage_of_students
FROM students s
LEFT JOIN marks m ON s.studentid = m.studentid

--another method
SELECT
100.0*COUNT(DISTINCT CASE WHEN marks>90 THEN studentid ELSE NULL END)/COUNT(DISTINCT studentid) AS percentage
FROM students


--Q3. Write an SQL Query to get second-highest 
-- and second-lowest marks for each subject

--mine
WITH ranked AS(
    SELECT subject, marks, 
    RANK() OVER(PARTITION BY subject ORDER BY marks DESC) AS rn1,
    RANK() OVER(PARTITION BY subject ORDER BY marks ASC) AS rn2
    FROM students
)
, final AS(
    SELECT subject,
    CASE WHEN rn1=2 THEN marks ELSE NULL END AS second_highest_marks,
    CASE WHEN rn2=2 THEN marks ELSE NULL END AS second_lowest_marks
    FROM ranked
)
SELECT subject, MAX(second_highest_marks) AS second_highest_marks, MAX(second_lowest_marks) AS second_lowest_marks
FROM final
WHERE second_highest_marks IS NOT NULL OR second_lowest_marks IS NOT NULL
GROUP BY subject

--another method
SELECT subject,
    SUM(CASE WHEN rn1=2 THEN marks ELSE NULL END) AS second_highest_marks,
    SUM(CASE WHEN rn2=2 THEN marks ELSE NULL END) AS second_lowest_marks
    FROM 
(
    SELECT subject, marks, 
    RANK() OVER(PARTITION BY subject ORDER BY marks DESC) AS rn1,
    RANK() OVER(PARTITION BY subject ORDER BY marks ASC) AS rn2
    FROM students
) a
GROUP BY subject


--Q4. For each student and test, identify if their marks 
-- increased or decreased  from the previous test

SELECT studentid, testid, marks, prev_marks,
CASE WHEN marks>prev_marks THEN 'inc'
     WHEN marks<prev_marks THEN 'dec' ELSE NULL END AS status
FROM (
    SELECT studentid, testid, marks,
    LAG(marks,1) OVER(PARTITION BY studentid ORDER BY testdate, subject) AS prev_marks
    FROM students
) a

