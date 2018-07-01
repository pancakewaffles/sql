-- ORDER BY
SELECT id, account_id, total
FROM orders
ORDER BY total
LIMIT 20;

SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;

-- WHERE
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

-- Arithmetic Operators
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

-- LIKE
SELECT name
FROM accounts
WHERE name LIKE '%one%'; -- %c starts with c , s% ends with s, %one% contains a "one" somewhere

-- IN
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

-- AND
SELECT * FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0

SELECT * FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s'

-- OR
SELECT id FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000

SELECT name, primary_poc FROM accounts
WHERE name LIKE 'C%' OR name LIKE 'W%'
AND primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%'
AND primary_poc NOT LIKE '%eana%'
