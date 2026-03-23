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

-- 3 Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. 
-- Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

SELECT
    tweet_no                    AS tweet_count,
    COUNT(user_id)              AS user_num
FROM (
    SELECT
        user_id,
        COUNT(tweet_id)         AS tweet_no
    FROM tweets
    WHERE EXTRACT(YEAR FROM tweet_date) = 2022
    GROUP BY user_id
) AS no_of_tweets
GROUP BY tweet_no
ORDER BY tweet_no;

-- 4. Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. 
-- You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

select candidate_id
from (SELECT CANDIDATE_ID, count(skill) as no_skill
FROM CANDIDATES
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id) as count_skills
where no_skill = 3
order by candidate_id asc;
