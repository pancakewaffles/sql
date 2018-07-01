-- The SQL DATE function
-- Question 1
SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
-- Question 2
SELECT DATE_PART('month', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
-- Question 3
SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(o.*)
FROM orders o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
-- Question 4
SELECT DATE_PART('month', occurred_at) ord_year,  COUNT(o.*)
FROM orders o
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;
-- Question 5
SELECT DATE_PART('year',occurred_at) ord_year, DATE_PART('month', occurred_at) ord_month,  SUM(gloss_amt_usd)
FROM orders o JOIN accounts a ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1,2
ORDER BY 3 DESC;
