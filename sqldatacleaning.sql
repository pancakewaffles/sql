-- LEFT and RIGHT
-- Question 1
SELECT RIGHT(website,3) AS extension, COUNT(website) FROM accounts
GROUP BY extension;
-- Question 2
SELECT LEFT(name,1) AS first_letter, COUNT(name) FROM accounts
GROUP BY first_letter;
-- Question 3 Count the number of companies that start with a number, and also the number of companies that start with a letter
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 1 ELSE 0 END AS num,
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
-- Question 4
SELECT SUM(vowels) AS sum_of_vowels, SUM(the_rest) AS sum_the_rest FROM
(SELECT name, CASE WHEN LEFT(UPPER(name),1) IN ('A','E','I','O','U') THEN 1 ELSE 0 END AS vowels,
              CASE WHEN LEFT(UPPER(name),1) IN ('A','E','I','O','U') THEN 0 ELSE 1 END AS the_rest
              FROM accounts) t1;

-- POSITION and STRPOS
-- Question 1
SELECT LEFT(UPPER(primary_poc),POSITION(' ' IN primary_poc)-1) AS firstname,
       RIGHT(UPPER(primary_poc),LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS lastname FROM accounts
-- Question 2
SELECT LEFT(UPPER(name),POSITION(' ' IN name)-1) AS firstname, RIGHT(UPPER(name),LENGTH(name) - POSITION(' ' IN name)) AS lastname FROM sales_reps

-- CONCAT and TRANSLATE
WITH t1 AS (
SELECT name AS company_name, LEFT(LOWER(primary_poc),POSITION(' ' IN primary_poc)-1) AS firstname, RIGHT(LOWER(primary_poc),LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS lastname  FROM accounts )
-- Question 1, and Question 2
SELECT CONCAT(firstname,'.',lastname,'@',TRANSLATE(LOWER(company_name),' ',''),'.com') AS email FROM t1;
-- Question 3
SELECT
LEFT(firstname,1) || RIGHT(firstname,1) || LEFT(lastname,1) || RIGHT(lastname,1) || LENGTH(firstname) || LENGTH(lastname) || TRANSLATE(UPPER(company_name),' ','') FROM t1;
