-- 1. Customer summary
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS orders,
       ROUND(SUM(Revenue),2) AS spend,
       ROUND(SUM(Revenue)/COUNT(DISTINCT InvoiceNo),2) AS aov
FROM sales WHERE CustomerID IS NOT NULL
GROUP BY CustomerID ORDER BY spend DESC LIMIT 20;

-- 2. Repeat vs one-time customers
SELECT CASE WHEN orders = 1 THEN 'One-time' ELSE 'Repeat' END AS type,
       COUNT(*) AS customers, ROUND(AVG(total_spend),2) AS avg_spend
FROM customers GROUP BY 1;

-- 3. Purchase frequency distribution
SELECT orders, COUNT(*) AS customers FROM customers GROUP BY orders ORDER BY orders LIMIT 15;

-- 4. Segment summary
SELECT segment, COUNT(*) AS customers, ROUND(AVG(total_spend),2) AS avg_spend,
       ROUND(AVG(recency_days),0) AS avg_recency
FROM customers GROUP BY segment ORDER BY avg_spend DESC;

-- 5. Customers by first-order month (cohort size)
SELECT strftime('%Y-%m', first_order) AS cohort, COUNT(*) AS new_customers
FROM customers GROUP BY 1 ORDER BY 1;

-- 6. Churned customers who were high spenders
SELECT CustomerID, orders, ROUND(total_spend,2) AS spend, recency_days
FROM customers WHERE churned = 1 AND total_spend > (SELECT AVG(total_spend)*2 FROM customers)
ORDER BY total_spend DESC LIMIT 20;