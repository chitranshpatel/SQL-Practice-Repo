---------------------------------------------------------
-- TOPIC: BASIC JOINS
---------------------------------------------------------

-- 1. Student Grading Report
-- Goal: Mask names for low grades and sort by specific criteria.

SELECT 
    CASE WHEN g.grade < 8 THEN NULL ELSE s.name END AS name, 
    g.grade, s.marks
FROM students s 
JOIN grades g ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, name ASC, s.marks ASC;


--2.Finding the Group-wise Minimum

SELECT w.id, p.age, w.coins_needed, w.power
FROM wands w
JOIN wands_property p ON w.code = p.code
WHERE p.is_evil = 0
  AND w.coins_needed = (
      SELECT MIN(w1.coins_needed)
      FROM wands w1
      JOIN wands_property p1 ON w1.code = p1.code
      WHERE p1.is_evil = 0 
        AND w1.power = w.power 
        AND p1.age = p.age
  )
ORDER BY w.power DESC, p.age DESC;


--3 .Query to fetch hacker_id, name, and total challenges created by each student, 
-- sorted by challenge count descending. Excludes hackers who share a challenge 
-- count (unless it's the maximum), using subqueries in the HAVING clause.

SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS challenges_created
FROM hackers h 
JOIN challenges c ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING 
    challenges_created = (
        SELECT MAX(cnt) 
        FROM (
            SELECT COUNT(challenge_id) as cnt 
            FROM challenges 
            GROUP BY hacker_id
        ) as max_counts
    ) 
    OR 
    challenges_created IN (
        SELECT cnt
        FROM (
            SELECT COUNT(challenge_id) as cnt 
            FROM challenges 
            GROUP BY hacker_id
        ) as counts
        GROUP BY cnt
        HAVING COUNT(*) = 1
    )
ORDER BY challenges_created DESC, h.hacker_id ASC;
