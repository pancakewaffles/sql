-- Subqueries
SELECT channel, AVG(num_occur) FROM
(SELECT DATE_TRUNC('day',occurred_at) AS day,
	   channel,
       COUNT(*) AS num_occur FROM web_events
GROUP BY 1,2
) sub
GROUP BY 1
ORDER BY 2;

SELECT AVG(standard_qty) AS avg_standard, AVG(gloss_qty) AS avg_gloss, AVG(poster_qty) AS avg_poster FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) as 	date FROM orders)

-- Question 2
SELECT * FROM
  ((SELECT t1.region, MAX(t1.timmy) FROM
    (SELECT r.name AS region, 		  SUM(o.total_amt_usd) AS timmy FROM sales_reps s
      JOIN region r ON s.region_id = r.id
      JOIN accounts a ON a.sales_rep_id = s.id
      JOIN orders o ON a.id = o.account_id
      GROUP BY r.name) AS t1
    GROUP BY t1.region)
    ORDER BY 2 DESC
    LIMIT 1) AS max_region

  JOIN

  (SELECT r.name AS mt_region, COUNT(o.*) AS total_count FROM orders o
  JOIN accounts a ON a.id = o.account_id
  JOIN sales_reps s ON s.id = a.sales_rep_id
  JOIN region r ON r.id = s.region_id
  GROUP BY 1) AS main_table

  ON main_table.mt_region = max_region.region;
  -- Question 3
  -- It's crazy. By this point I gave up. It's easier to use temp tables here.

  -- WITH creates a temporary table which you can access normally.
  WITH sales_region_amt AS
  (SELECT s.name AS sales_rep, r.name AS region_name, SUM(o.total_amt_usd), COUNT(o.*) order_count FROM orders o
  JOIN accounts a ON a.id = o.account_id
  JOIN sales_reps s ON s.id = a.sales_rep_id
  JOIN region r ON r.id = s.region_id
  GROUP BY 1,2),

  orders_qty_account AS
  (SELECT a.name, SUM(o.standard_qty) AS sum_std_qty, SUM(o.total_amt_usd) AS sum_total_usd, SUM(o.total) AS sum_total FROM orders o JOIN accounts a ON a.id = o.account_id
   GROUP BY 1
    ),
    largest_std_orderer AS (SELECT name, sum_std_qty, sum_total FROM orders_qty_account
ORDER BY 2 DESC
LIMIT 1) ,
	largest_spender AS (SELECT name, sum_std_qty, sum_total FROM orders_qty_account
ORDER BY 3 DESC
LIMIT 1)
-- Question 1
SELECT * FROM
(SELECT region_name, MAX(sum) FROM sales_region_amt
GROUP BY 1) AS t1
JOIN sales_region_amt ON t1.max = sales_region_amt.sum

-- Question 2
SELECT t2.region_name, SUM(order_count) FROM
(SELECT region_name, SUM(sum) FROM sales_region_amt
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1) AS t2 JOIN sales_region_amt aa ON t2.region_name = aa.region_name
GROUP BY 1;

-- Question 3
SELECT COUNT(*) FROM orders_qty_account
WHERE sum_total >
(SELECT sum_total FROM largest_std_orderer)


-- Question 4
SELECT a.name, w.channel, COUNT(*) FROM accounts a
JOIN web_events w ON w.account_id = a.id AND a.name = (SELECT name FROM largest_spender)
GROUP BY 1,2;

-- Question 5
SELECT AVG(sum_total_usd) FROM
(SELECT * FROM orders_qty_account
ORDER BY 3
LIMIT 10) sub

-- Question 6
SELECT AVG(sum_total_usd) FROM orders_qty_account
WHERE sum_total_usd >
(SELECT AVG(sum_total_usd) FROM orders_qty_account)
