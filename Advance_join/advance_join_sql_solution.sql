-- 1. Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
-- If there is more than one project that have the same number of completion days, then order by the start date of the project.

WITH DateSequence AS (
    SELECT
        start_date,
        end_date,
        DATE_ADD(start_date, INTERVAL -ROW_NUMBER() OVER (ORDER BY start_date) DAY) AS grouping_key
    FROM PROJECTS
)
SELECT
    MIN(start_date) AS start_date,
    MAX(end_date)   AS end_date
FROM DateSequence
GROUP BY grouping_key
ORDER BY COUNT(*), MIN(start_date);



-- 2.Write a query to output the names of those students whose best friends got offered a higher salary than them. 
-- Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

SELECT s.name
FROM students s
INNER JOIN packages  p  ON s.id       = p.id
INNER JOIN friends   f  ON s.id       = f.id
INNER JOIN packages  pp ON f.friend_id = pp.id
WHERE p.salary < pp.salary
ORDER BY pp.salary;
