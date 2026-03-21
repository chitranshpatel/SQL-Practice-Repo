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
