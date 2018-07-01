-- my first JOIN
SELECT orders.standard_qty, orders.gloss_qty,
       orders.poster_qty,  accounts.website,
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
-- Exercises on JOINING
-- First Qns
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

-- Second Qns
SELECT r.name AS region, s.name AS rep, a.name AS account FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
ORDER BY a.name

-- Third Qns
SELECT r.name AS region, a.name AS account, o.total_amt_usd/(o.total+0.01) AS price FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

-- Bringing it all together
-- Questions 1,2,3
SELECT r.name AS region, s.name AS rep, a.name AS account FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

-- Questions 4,5,6
SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) AS unit_price FROM orders o
JOIN accounts a ON a.id = o.account_id
JOIN sales_reps s ON s.id = a.sales_rep_id
JOIN region r ON r.id = s.region_id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC;

-- Questions 7
SELECT DISTINCT a.name, w.channel FROM accounts a
JOIN web_events w ON w.account_id = a.id
WHERE a.id = 1001;

-- Questions 8
SELECT w.occurred_at,a.name,o.total,o.total_amt_usd FROM orders o
JOIN accounts a ON a.id = o.account_id
JOIN web_events w ON w.account_id = a.id
WHERE w.occurred_at BETWEEN '01-01-2015' AND '01-01-2016';
