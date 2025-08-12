CREATE DATABASE olist;

USE olist;

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

SELECT customer_city, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

SELECT customer_state, COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;

SELECT customer_unique_id, COUNT(customer_id) AS order_count
FROM customers
GROUP BY customer_unique_id
HAVING order_count > 1
ORDER BY order_count DESC;

SELECT customer_state, COUNT(DISTINCT customer_city) AS city_count
FROM customers
GROUP BY customer_state
ORDER BY city_count DESC;

SELECT customer_zip_code_prefix, COUNT(*) AS customer_count
FROM customers
GROUP BY customer_zip_code_prefix
ORDER BY customer_count DESC
LIMIT 10;

CREATE VIEW v_customers_per_state AS
SELECT customer_state, COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers
GROUP BY customer_state;

CREATE VIEW v_top_cities AS
SELECT customer_city, COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

CREATE INDEX idx_customer_state ON customers(customer_state);
CREATE INDEX idx_customer_city ON customers(customer_city);

EXPLAIN SELECT customer_city, COUNT(*) 
FROM customers
GROUP BY customer_city
ORDER BY COUNT(*) DESC
LIMIT 10;

