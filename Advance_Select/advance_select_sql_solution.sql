-- 1.1 Print every person's name with the first letter of their job in brackets, sorted A→Z** — like `Ashley(P)` for a Professor.
-- 1.2. Count how many people have each job and print a sentence for each**, sorted by count (lowest first), then alphabetically if counts are equal — like `There are a total of 2 doctors.`

SELECT CONCAT(Name, '(', SUBSTR(occupation,1,1),')')
FROM occupations
ORder by Name;

SELECT CONCAT('There are a total of', ' ', COUNT(*), ' ', LOWER(occupation),'s.')
FROM occupations
Group by occupation
order by COUNT(*), occupation;


-- 2 Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.

SELECT 
    MAX(CASE WHEN Occupation = 'Doctor'    THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer'    THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor'     THEN Name END) AS Actor
FROM (
    SELECT Name, Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) AS temp
GROUP BY rn;


-- 3. Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
-- Root: If node is root node.
-- Leaf: If node is leaf node.
-- Inner: If node is neither root nor leaf node.

SELECT 
    N,
    CASE
        WHEN P IS NULL                                  THEN 'Root'
        WHEN N NOT IN (SELECT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE                                                 'Inner'
    END AS node_type
FROM BST
ORDER BY N;

--4 write a query to print the company_code, founder name, total number of lead managers, total number of 
-- senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

select c.company_code, c.founder,
count(distinct lm.lead_manager_code) as lm_number,
count(distinct sm.senior_manager_code) as sm_number,
count(distinct m.manager_code) as m_number,
count(distinct e.employee_code) as employee_number
FROM company c
left JOIN lead_manager lm    ON c.company_code  = lm.company_code
left JOIN senior_manager sm  ON lm.lead_manager_code = sm.lead_manager_code
left JOIN manager m          ON sm.senior_manager_code = m.senior_manager_code
left JOIN employee e         ON m.manager_code  = e.manager_code
group by c.company_code, c.founder
order by c.company_code asc;
