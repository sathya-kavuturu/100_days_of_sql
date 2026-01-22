

USE DaysOfSQL;

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

SELECT * FROM stores

--method 1 (using agg)
SELECT Store, 
'Q'+CAST(10 - SUM(CAST(RIGHT(Quarter, 1) AS INT)) AS CHAR(1)) AS q_no
FROM stores
GROUP BY Store;


--method 2 (using recursive cte)

WITH cte AS(
    SELECT DISTINCT Store, 1 AS q_no FROM stores
    UNION ALL
    SELECT Store, q_no+1 AS q_no FROM cte
    WHERE q_no<4
)
, q AS(
    SELECT Store, 'Q'+CAST(q_no AS CHAR(2)) AS q_no 
    FROM cte
)
SELECT q.Store, q.q_no
FROM q
LEFT JOIN Stores s ON q.Store=s.Store AND q.q_no=s.quarter
WHERE s.Store IS NULL
ORDER BY q.Store


--method 3 (using cross join)
EXPLAIN ANALYZE
[
WITH cte AS(
    SELECT DISTINCT s1.Store, s2.Quarter
    FROM Stores s1, Stores s2
)
SELECT q.Store, q.Quarter
FROM cte q
LEFT JOIN Stores s ON q.Store=s.Store AND q.Quarter=s.Quarter
WHERE s.Store IS NULL
ORDER BY q.Store
]