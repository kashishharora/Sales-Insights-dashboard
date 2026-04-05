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
### 🔹write the query to retrive all columns from the transactions table along with all columns from the date table 
SELECT sales.transactions.*,sales.date.*
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date;
### 🔹Write an SQL query to calculate the total revenue generated in the year 2020.
SELECT SUM(sales.transactions.sales_amount)
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date
WHERE sales.date.year = 2020;
### 🔹Write an SQL query to calculate the total revenue in the year 2020 for the market with code Mark001 (Chennai).
SELECT SUM(sales.transactions.sales_amount)
FROM sales.transactions 
INNER JOIN sales.date 
ON sales.transactions.order_date=sales.date.date
WHERE sales.date.year = 2020 and sales.transactions.market_code="Mark001";
### 🔹Write an SQL query to find all distinct products sold in Chennai market (Mark001).
SELECT DISTINCT product_code 
FROM sales.transactions 
WHERE market_code = 'Mark001';

