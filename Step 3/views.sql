CREATE VIEW expenditure_vs_life_expectancy AS
SELECT h.year, c.name, h.expenditure, l.le
FROM country c
JOIN health_expenditure h ON c.iso = h.iso
JOIN life_expectancy_all l ON h.year = l.year AND c.iso = l.iso;

CREATE VIEW gender_survival_difference AS
SELECT s.year, c.name, (s.survival_female - s.survival_male) AS survival_diff
FROM country c
JOIN survival_to_65 s ON c.iso = s.iso;

CREATE VIEW life_expectancy_decrease_1990_2000 AS
SELECT c.name
FROM (
  SELECT l1.iso, l1.year AS year1, l2.year AS year2, l1.le - l2.le AS diff
  FROM life_expectancy_all l1, life_expectancy_all l2
  WHERE l1.year = 1990 AND l2.year = 2000 AND l1.iso = l2.iso) r1
JOIN country c ON r1.iso = c.iso 
WHERE r1.diff > 0;

CREATE VIEW countries_with_survival_male_dec_female_inc_in AS
SELECT c.name
FROM country c
WHERE c.iso IN (
  SELECT s1.iso
  FROM survival_to_65 s1, survival_to_65 s2
  WHERE s1.year = 1960 AND s2.year = 1970 AND s1.iso = s2.iso AND s1.survival_male > s2.survival_male AND s1.survival_female < s2.survival_female);

CREATE VIEW countries_with_survival_male_dec_female_inc_exists AS
SELECT c.name
FROM country c
WHERE EXISTS (
  SELECT 1
  FROM survival_to_65 s1, survival_to_65 s2
  WHERE s1.year = 1960 AND s2.year = 1970 AND s1.iso = s2.iso AND s1.survival_male > s2.survival_male AND s1.survival_female < s2.survival_female AND c.iso = s1.iso);

CREATE VIEW avg_life_expectancy_90s AS
SELECT c.name, AVG(l.le) AS avg_life_expectancy
FROM country c
JOIN life_expectancy_all l ON c.iso = l.iso
WHERE l.year BETWEEN 1990 AND 1999
GROUP BY c.name;

CREATE VIEW total_health_expenditure_90s AS
SELECT c.name, SUM(h.expenditure) AS total_expenditure
FROM country c
JOIN health_expenditure h ON c.iso = h.iso
WHERE h.year BETWEEN 2010 AND 2019
GROUP BY c.name;

CREATE VIEW highest_life_expectancy AS
SELECT c.name, MAX(l.le) AS max_life_expectancy
FROM country c
JOIN life_expectancy_all l ON c.iso = l.iso
WHERE l.year = 2000
GROUP BY c.name
ORDER BY max_life_expectancy DESC
LIMIT 1;

CREATE VIEW min_max_difference_survival_male_female AS
SELECT c.name, MIN(s.survival_female - s.survival_male) AS min_diff, MAX(s.survival_female - s.survival_male) AS max_diff
FROM country c
JOIN survival_to_65 s ON c.iso = s.iso
GROUP BY c.name;

CREATE VIEW count_years_life_expectacy_increased AS
SELECT c.name, COUNT(*) AS increased_years
FROM country c
JOIN life_expectancy_all l1 ON c.iso = l1.iso
JOIN life_expectancy_all l2 ON l1.year - 1 = l2.year AND l1.iso = l2.iso
WHERE l1.le > l2.le
GROUP BY c.name;

