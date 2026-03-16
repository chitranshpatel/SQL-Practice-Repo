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
