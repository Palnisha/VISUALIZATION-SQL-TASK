### VISUALIZATION TASK ###

-- TASK 5 :  Customer Retention Analysis:

-- Visualize customer retention by showing how many customers from a  
-- specific cohort made repeat purchases in subsequent months.
-- Use a suitable BI visualization tool to present your findings.
-- Clearly explain how the visualization tracks customer retention.

--- EXTRACTING DATA FOR VISUALIZATION
USE  ALTDB;

--- FIRST PURCHSE DATE
SELECT customer_id, MIN(order_date) AS first_purchase_month
FROM customer_orders
GROUP BY customer_id;

--- REPEAT PURCHASES ---
SELECT cohort.first_purchase_month, MONTH(C.order_date) AS repeat_month, COUNT(DISTINCT C.customer_id) AS repeat_customers
FROM (
    SELECT customer_id, MIN(order_date) AS first_purchase_month
    FROM customer_orders
    GROUP BY customer_id
) cohort
JOIN customer_orders C ON cohort.customer_id = C.customer_id
WHERE MONTH(C.order_date) >= MONTH(cohort.first_purchase_month)
GROUP BY cohort.first_purchase_month, MONTH(C.order_date);


--- RETENTION RATE


---- CRETE CUSTOMER RETENTION TABLE
CREATE TABLE customer_retention (
    first_purchase_month INT,
    repeat_month INT,
    retention_rate DECIMAL(15,4)
);

ALTER TABLE CUSTOMER_RETENTION MODIFY COLUMN retention_rate DECIMAL(15,5);


---- INSERT VALUE INTO CUSTOMER RETENTION TABLE

CREATE TEMPORARY TABLE temp_retention AS
WITH cohort AS (
    SELECT customer_id, MONTH(MIN(order_date)) AS first_purchase_month
    FROM customer_orders
    GROUP BY customer_id
),
monthly_orders AS (
    SELECT customer_id, MONTH(order_date) AS repeat_month
    FROM customer_orders
)
SELECT c.first_purchase_month, m.repeat_month,
       COUNT(DISTINCT m.customer_id) * 100.0 /
       (SELECT COUNT(DISTINCT customer_id) FROM cohort WHERE first_purchase_month = c.first_purchase_month) AS retention_rate
FROM cohort c
JOIN monthly_orders m ON c.customer_id = m.customer_id
WHERE m.repeat_month >= c.first_purchase_month
GROUP BY c.first_purchase_month, m.repeat_month;

INSERT INTO customer_retention SELECT * FROM temp_retention;

WITH cohort AS (
    SELECT customer_id, MONTH(MIN(order_date)) AS first_purchase_month
    FROM customer_orders
    GROUP BY customer_id
)
SELECT CAST(
    (COUNT(DISTINCT m.customer_id) * 100.0 /  
    NULLIF((SELECT COUNT(DISTINCT customer_id) FROM cohort WHERE first_purchase_month = c.first_purchase_month), 0))  
    AS DECIMAL(15,5)
) AS retention_rate
FROM cohort c
JOIN customer_orders m ON c.customer_id = m.customer_id
WHERE MONTH(m.order_date) >= c.first_purchase_month
GROUP BY c.first_purchase_month, MONTH(m.order_date);

INSERT INTO customer_retention (first_purchase_month, repeat_month, retention_rate)
WITH cohort AS (
    SELECT customer_id, MONTH(MIN(order_date)) AS first_purchase_month
    FROM customer_orders
    GROUP BY customer_id
),
monthly_orders AS (
    SELECT customer_id, MONTH(order_date) AS repeat_month
    FROM customer_orders
)
SELECT c.first_purchase_month, m.repeat_month,
       CAST(
           (COUNT(DISTINCT m.customer_id) * 100.0 /
           NULLIF((SELECT COUNT(DISTINCT customer_id) FROM cohort WHERE first_purchase_month = c.first_purchase_month), 0))
           AS DECIMAL(15,5)
       ) AS retention_rate
FROM cohort c
JOIN monthly_orders m ON c.customer_id = m.customer_id
WHERE m.repeat_month >= c.first_purchase_month
GROUP BY c.first_purchase_month, m.repeat_month;


SHOW VARIABLES LIKE 'secure_file_priv';


-- save file in csv form 
SELECT * FROM customer_retention 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_retention.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';






