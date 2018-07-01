--SUM
SELECT SUM(poster_qty) AS poster, SUM(standard_qty) AS standard, SUM(total_amt_usd) AS total, SUM(standard_amt_usd) AS standard_usd, SUM(gloss_amt_usd) AS gloss_usd, SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit FROM orders

-- MIN, MAX, AVG
SELECT MIN(occurred_at) FROM orders
-- Alternatively
SELECT occurred_at FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at) FROM web_events;

SELECT AVG(standard_qty) AS standard_average, AVG(standard_amt_usd) AS standard_usd FROM orders;

-- Question 6
SELECT *
FROM
(SELECT total_amt_usd FROM orders
ORDER BY total_amt_usd
LIMIT 3457 ) AS table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- GROUP BY
-- Question 1
SELECT a.name, o.occurred_at FROM orders o
JOIN accounts a ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;
-- Question 2
SELECT a.name, SUM(o.total_amt_usd) FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name;
-- Question 3
SELECT w.occurred_at, w.channel, a.name FROM web_events w JOIN accounts a ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;
-- Question 4
SELECT channel, COUNT(*) AS channel_count FROM web_events
GROUP BY channel;
-- Question 5
SELECT w.occurred_at, a.primary_poc FROM web_events w JOIN accounts a ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;
-- Question 6
SELECT a.name, MIN(o.total_amt_usd) AS smallest_amt FROM orders o JOIN accounts a ON a.id = o.account_id
GROUP BY a.name;
-- Question 7
SELECT r.name AS region, COUNT(s.*) AS number_of_sales_reps FROM sales_reps s JOIN region r ON s.region_id = r.id
GROUP BY r.name
ORDER BY number_of_sales_reps;

-- GROUP BY Part 2
SELECT a.name, AVG(standard_qty) AS standard_avg, AVG(gloss_qty) AS gloss_avg, AVG(poster_qty) AS poster_avg FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name;
-- Question 2
SELECT a.name, AVG(o.standard_amt_usd) AS standard_usd, AVG(o.gloss_amt_usd) AS gloss_usd, AVG(o.poster_amt_usd) AS poster_usd FROM orders o
JOIN accounts a ON a.id = o.account_id
GROUP BY a.name;
-- Question 3
SELECT s.name, w.channel, COUNT(w.*) AS num_occur FROM web_events w
JOIN accounts a ON a.id = w.account_id
JOIN sales_reps s ON s.id = a.sales_rep_id
GROUP BY s.name,w.channel
ORDER BY num_occur;
-- Question 4
SELECT r.name, w.channel, COUNT(w.*) AS num_occur FROM web_events w
JOIN accounts a ON a.id = w.account_id
JOIN sales_reps s ON s.id = a.sales_rep_id
JOIN region r ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_occur;

-- DISTINCT
SELECT DISTINCT id,name FROM accounts;
-- Verifying
SELECT a.id as "account id", r.id as "region id",
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON r.id = s.region_id;

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
-- Verifying
SELECT DISTINCT id,name FROM sales_reps

-- HAVING
-- Question 1
SELECT s.name,COUNT(a.*) AS num_accounts FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(a.*) > 5
-- Question 2, 3
SELECT a.name, COUNT(o.*) AS num_orders FROM orders o JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.*) > 20
ORDER BY COUNT(o.*) DESC
-- Question 4,5,6,7
SELECT a.name, SUM(o.total_amt_usd) AS order_usd FROM orders o JOIN accounts a ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000 or SUM(o.total_amt_usd) < 1000
-- Question 8,9
SELECT a.name, w.channel, COUNT(w.channel) AS channel_usage FROM web_events w JOIN accounts a ON w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(w.channel) > 6
ORDER BY COUNT(w.channel) DESC
-- Question 10
SELECT w.channel, COUNT(w.channel) AS channel_usage FROM web_events w JOIN accounts a ON w.account_id = a.id
GROUP BY w.channel
ORDER BY COUNT(w.channel) DESC
