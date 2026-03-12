-- 1.1 Print every person's name with the first letter of their job in brackets, sorted A→Z** — like `Ashley(P)` for a Professor.
-- 1.2. Count how many people have each job and print a sentence for each**, sorted by count (lowest first), then alphabetically if counts are equal — like `There are a total of 2 doctors.`

SELECT CONCAT(Name, '(', SUBSTR(occupation,1,1),')')
FROM occupations
ORder by Name;

SELECT CONCAT('There are a total of', ' ', COUNT(*), ' ', LOWER(occupation),'s.')
FROM occupations
Group by occupation
order by COUNT(*), occupation;

