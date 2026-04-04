### 🔹Total number of sales transactions
SELECT COUNT(*) AS total_transactions
FROM sales.transactions;
### 🔹 Sales Records for Market Code 'Mark0001'
SELECT *
FROM sales.transactions
WHERE market_code = 'Mark001';
### 🔹 Total Transactions with USD Currency
SELECT *
FROM sales.transactions
WHERE currency = 'USD';
