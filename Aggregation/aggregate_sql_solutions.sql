-- 1 write a query to query find the highest total earnings (salary × months) across all employees. 
--  also counts how many employees share that maximum earning figure.

SELECT 
    MAX(salary * months) AS max_salary,
    COUNT(DISTINCT employee_id) AS employee_count
FROM employee
WHERE (salary * months) = (
    SELECT MAX(salary * months) 
    FROM employee
);

-- 2 Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . 
-- Truncate your answer to  decimal places.
SELECT ROUND(SUM(lat_n), 4) AS sum_lat
FROM station
WHERE lat_n BETWEEN 38.7880 AND 137.2345;
