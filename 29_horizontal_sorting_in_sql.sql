-- find total number of messages  exchanged between each person per day

USE DaysOfSQL;

CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

SELECT * FROM subscriber

SELECT sms_date, p1, p2, SUM(sms_no) 
FROM(
    SELECT sms_date,
    CASE WHEN sender<receiver THEN sender ELSE receiver END AS p1,
    CASE WHEN sender>receiver THEN sender ELSE receiver END AS p2,
    sms_no
    FROM subscriber
) A
GROUP BY sms_date, p1, p2;