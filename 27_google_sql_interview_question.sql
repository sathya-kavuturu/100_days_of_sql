--Find companies who  have atleast 2 users 
-- who speaks English and German both the languages 

USE DaysOfSQL;

create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

SELECT * FROM company_users

WITH final_companies AS(
    SELECT company_id, user_id, COUNT(1) AS tl
    FROM company_users
    WHERE language IN ('English', 'German')
    GROUP BY company_id, user_id
    HAVING COUNT(1) = 2
)

SELECT company_id, COUNT(user_id) AS no_of_users
FROM final_companies
GROUP BY company_id
HAVING COUNT(user_id) >=2