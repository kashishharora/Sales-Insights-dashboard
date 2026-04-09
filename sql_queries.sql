-- ============================================
-- Sales Insights Dashboard — SQL Queries
-- Database: MySQL | Schema: sales
-- Author: Kashish Arora
-- ============================================

-- 1. Total number of sales transactions
SELECT COUNT(*) AS total_transactions
FROM sales.transactions;

-- 2. Sales records for Chennai market (Mark001)
SELECT transaction_id, product_code,
  sales_amount, order_date, market_code
FROM sales.transactions
WHERE market_code = 'Mark001';

-- 3. Total transactions in USD currency
SELECT COUNT(*) AS usd_transactions,
  SUM(sales_amount) AS usd_revenue
FROM sales.transactions
WHERE currency = 'USD';

-- 4. Join transactions with date table
SELECT t.transaction_id, t.product_code,
  t.sales_amount, t.market_code,
  d.year, d.month_name
FROM sales.transactions t
INNER JOIN sales.date d
  ON t.order_date = d.date;

-- 5. Total revenue in year 2020
SELECT SUM(t.sales_amount) AS total_revenue_2020
FROM sales.transactions t
INNER JOIN sales.date d
  ON t.order_date = d.date
WHERE d.year = 2020;

-- 6. Total revenue in 2020 for Chennai (Mark001)
SELECT SUM(t.sales_amount) AS chennai_revenue_2020
FROM sales.transactions t
INNER JOIN sales.date d
  ON t.order_date = d.date
WHERE d.year = 2020
  AND t.market_code = 'Mark001';

-- 7. Distinct products sold in Chennai market
SELECT DISTINCT product_code
FROM sales.transactions
WHERE market_code = 'Mark001';

-- 8. Total revenue by market (GROUP BY)
SELECT market_code,
  SUM(sales_amount) AS total_revenue,
  COUNT(*) AS total_transactions
FROM sales.transactions
GROUP BY market_code
ORDER BY total_revenue DESC;

-- 9. Monthly revenue trend for 2020
SELECT d.month_name, d.year,
  SUM(t.sales_amount) AS monthly_revenue
FROM sales.transactions t
INNER JOIN sales.date d
  ON t.order_date = d.date
WHERE d.year = 2020
GROUP BY d.month_name, d.year
ORDER BY d.month_name;

-- 10. Top 5 products by total revenue
SELECT product_code,
  SUM(sales_amount) AS total_revenue,
  COUNT(*) AS times_sold
FROM sales.transactions
GROUP BY product_code
ORDER BY total_revenue DESC
LIMIT 5;

-- 11. Markets with revenue above average market revenue
SELECT market_code,
  SUM(sales_amount) AS total_revenue
FROM sales.transactions
GROUP BY market_code
HAVING SUM(sales_amount) > (
  SELECT AVG(market_total)
  FROM (
    SELECT SUM(sales_amount) AS market_total
    FROM sales.transactions
    GROUP BY market_code
  ) AS market_summary
);

-- 12. Revenue rank by market using window function
SELECT market_code,
  SUM(sales_amount) AS total_revenue,
  RANK() OVER(ORDER BY SUM(sales_amount) DESC) AS revenue_rank
FROM sales.transactions
GROUP BY market_code;

-- 13. Year over year revenue comparison using LAG()
SELECT d.year,
  SUM(t.sales_amount) AS revenue,
  LAG(SUM(t.sales_amount)) OVER(ORDER BY d.year) AS prev_year_revenue,
  SUM(t.sales_amount) - LAG(SUM(t.sales_amount)) OVER(ORDER BY d.year) AS yoy_change
FROM sales.transactions t
INNER JOIN sales.date d
  ON t.order_date = d.date
GROUP BY d.year;

-- 14. Customer segmentation by total purchase value
SELECT customer_code,
  SUM(sales_amount) AS total_spent,
  CASE
    WHEN SUM(sales_amount) > 100000 THEN 'High Value'
    WHEN SUM(sales_amount) BETWEEN 50000 AND 100000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS customer_segment
FROM sales.transactions
GROUP BY customer_code
ORDER BY total_spent DESC;

-- 15. Running total of revenue over time
SELECT order_date,
  sales_amount,
  SUM(sales_amount) OVER(
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_revenue
FROM sales.transactions
ORDER BY order_date;

