-- crated database for task --

create database ALT;
USE ALT;

-- importing both the dataset for  all 4 task --

select* from customer_orders ; --  customer_orders  dataset 
select * from payments; -- payments dataset

## TASK 1  : Order and Sales Analysis:

##  Analyze order status and sales data to provide insights into order 
##  fulfillment and revenue trends. Identify key metrics and trends related to order status and sales.

-- Analyze order status distribution---
SELECT order_status, COUNT(*) AS order_count
FROM customer_orders
GROUP BY order_status;

-- calculating total order amount  --
select sum(order_amount) as total_order_amount
from customer_orders;

-- calculating total orders placed 
SELECT COUNT(order_id) AS total_orders
FROM customer_orders;

-- calculationg total orders_amount per customer --
select customer_id, count(order_amount)
from customer_orders
group by customer_id;

-- Order Fulfillment Time Analysis
SELECT order_date, COUNT(*) AS fulfilled_orders
FROM customer_orders
WHERE order_status = 'delivered'
GROUP BY order_date;

-- Break down revenue by month or week .
SELECT MONTH(order_date) AS month, SUM(order_amount) AS monthly_revenue
FROM customer_orders
GROUP BY MONTH(order_date);

-- Top rated analysis based on order id by most orders or revenue
SELECT order_id, SUM(order_amount) AS revenue
FROM customer_orders
GROUP BY order_id
ORDER BY revenue DESC;

--  Cancellation Rate or pending rate Analysis
SELECT COUNT(*) AS total_canceled_orders,
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_orders)) AS pending_rate
FROM customer_orders
WHERE order_status = 'pending';
select * from customer_orders;

-- Revenue Contribution by Customer Segments contribute the most to revenue.
SELECT customer_id, SUM(order_amount) AS total_spent
FROM customer_orders
GROUP BY customer_id
HAVING total_spent > 500; 

-- Churn Rate Indicators Identify such patterns.
SELECT customer_id, MAX(order_date) AS last_order_date
FROM customer_orders
GROUP BY customer_id
HAVING DATEDIFF(CURDATE(), MAX(order_date)) > 90; 

-- Monthly revenue.
SELECT MONTH(order_date) AS month,
       SUM(order_amount) AS monthly_revenue,
       (SUM(order_amount) * 100.0 / (SELECT SUM(order_amount) FROM customer_orders)) AS revenue_percentage
FROM customer_orders
GROUP BY MONTH(order_date);

-- Trend Analysis for High Revenue Orders
SELECT *
FROM customer_orders
WHERE order_amount > 400;

## TASK 2 : Customer Analysis:

##  Explore customer ordering behavior to identify patterns such as repeat ordering, customer segmentation, and trends over time

-- Determine which customers place multiple orders .
SELECT customer_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY customer_id
HAVING TOTAL_ORDERS > 1;

-- Perform Customer Segmentation
SELECT customer_id, SUM(order_amount) AS total_spent
FROM customer_orders
GROUP BY customer_id
HAVING total_spent > 1000; -- High spending

-- Analyze Trends Over Time
SELECT MONTH(order_date) AS month, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY MONTH(order_date);


## TASK 3 : Payment Status Analysis:

## Investigate payment status data to identify any potential issues or trends 
-- Related to payment success and failure.

-- Payment Status 
SELECT status, COUNT(*) AS status_count
FROM payments
GROUP BY status;

-- Payment Success Rate
SELECT 
  (COUNT(CASE WHEN payment_status = 'Completed' THEN 1 END) * 100.0 / COUNT(*)) AS success_rate
FROM payments;

-- failure payment analysis
SELECT payment_method, COUNT(*) AS failure_count
FROM payments
WHERE payment_status = 'Failed'
GROUP BY payment_method
ORDER BY failure_count DESC;

-- trend analysis over time
SELECT MONTH(payment_date) AS month, payment_status, COUNT(*) AS status_count
FROM payments
GROUP BY MONTH(payment_date), payment_status
ORDER BY month, payment_status;

-- payment amount analysis
SELECT payment_status, SUM(payment_amount) AS total_amount
FROM payments
GROUP BY payment_status;

## TASK 4 : Order Details Report:

## Create a comprehensive report that provides a detailed overview of order information, payment details, and key metrics.

-- JOIN THE DATASET FIRST FOR TASK 4
SELECT C.order_id, C.customer_id, C.order_date, C.order_status, P.payment_id, P.payment_date, 
	P.payment_amount, P.payment_method, P.payment_status
FROM customer_orders C
JOIN payments P ON C.order_id = P.order_id;


-- CALCULATE MATRICS
SELECT C.order_status, SUM(P.payment_amount) AS total_revenue,
       (COUNT(CASE WHEN P.payment_status = 'Completed' THEN 1 END) * 100.0 / COUNT(*)) AS payment_success_rate
FROM customer_orders C
JOIN payments P ON C.order_id = P.order_id
GROUP BY C.order_status;


-- PAYMENT TREND BY ORDER STATUS
SELECT C.order_status, COUNT(C.order_id) AS total_orders, SUM(P.payment_amount) AS total_payments
FROM customer_orders C
JOIN payments P ON C.order_id = P.order_id
GROUP BY C.order_status;


-- ORDERS AND PAYMENTS OVER TIME
SELECT MONTH(C.order_date) AS order_month, SUM(P.payment_amount) AS monthly_revenue
FROM customer_orders C
JOIN payments P ON C.order_id = P.order_id
GROUP BY MONTH(C.order_date);


-- FINAL REPORT 

SELECT 
    C.order_id, C.customer_id, C.order_date, C.order_status,
    P.payment_id,P.payment_date, P.payment_amount, 
	P.payment_method, 
	P.payment_status
FROM 
    customer_orders C
JOIN 
    payments P 
ON 
    C.order_id = P.order_id;
    
    




























