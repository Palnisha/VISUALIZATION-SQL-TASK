# SQL and Visualization TASK

# SQL QUERIES

# Overview

This repository contains SQL queries and Power BI visualizations designed to analyze customer retention patterns for Alt Mobility. The analysis focuses on identifying repeat purchase 

behavior and tracking cohort-based retention rates over subsequent months.

The dataset used:

- customer_orders.csv – Contains order details, including order status and order amounts.
  
- payments.csv – Includes payment transaction details.
 

# The queries provide insights into:
- Order and sales trends
  
- Customer behavior and retention patterns
  
- Payment success rates and failure trends
  
- A comprehensive report linking orders and payments

 #  Task 1: Order and Sales Analysis
 
###  Approach:

- Identify order status distribution to understand fulfillment trends.
  
- Calculate total order amount and orders placed to determine overall sales performance.
  
- Evaluate monthly revenue trends to analyze seasonal variations.
  
- Determine high-revenue orders and customer contributions.
  
- Assess cancellation rates to flag potential operational inefficiencies.

#  Task 2: Customer Analysis

### Approach:

- Identify repeat customers to study loyalty trends.
  
- Segment customers based on spending thresholds to categorize purchasing behavior.
  
- Analyze monthly order trends to observe demand fluctuations.

#  Task 3: Payment Status Analysis

### Approach:

- Analyze payment success rates to evaluate financial performance.
  
- Identify failure trends by payment method for optimization
  
- Explore monthly payment success trends.

 #  Task 4: Order Details Report
 
### Approach:

- Join orders and payments datasets to establish a unified view.
  
- Calculate total revenue per order status for business insights.
  
- Analyze payment trends by order status to improve financial planning.

 #  Conclusion
 
This README outlines the approach and logic behind the SQL queries used for Alt Mobility’s data analysis. The queries help derive business insights that can optimize operational 

efficiency and improve customer retention. The full set of queries can be accessed in the repository.




# VISUALIZATION TASK

# Objective

Calculate customer retention percentages for each cohort by tracking their purchase behavior across subsequent months.

Approach

- Define the first purchase month for each customer.

- Track repeat purchases in later months.

- Store retention rates in the customer_retention table for visualization.

# Power BI Visualizations

1. Cohort Retention Heatmap

- Objective: Visualizes customer retention rates over multiple months.

- Steps:- Import customer_retention.csv into Power BI.

- Use Matrix Visual.

- Drag first_purchase_month to Rows.

- Drag repeat_month to Columns.

- Drag retention_rate to Values.

- Apply Conditional Formatting → Color Scales.


2. Line Chart – Retention Trends Over Time

- Objective: Tracks retention rate fluctuations across different repeat months.

- Steps:- Use Line Chart Visual.

- Drag repeat_month to X-Axis.

- Drag retention_rate to Y-Axis.

3. Pie Chart – Retention distribution


- Objective: Shows the proportion of retained vs. dropped customers over months.

- Steps:- Use Pie Chart Visual.

- Drag repeat_month to Legend.

- Drag retention_rate to Values.

- Enable Data Labels to show percentages.



# Conclusion for Visualization

This README outlines the SQL queries, data extraction, and visualizations used for customer retention analysis. The findings help Alt Mobility assess customer loyalty trends, identify 

high-retention periods, and optimize engagement strategies.


# Final Thought : Insights from Retention Data

As per my experienced while doing this project .......


- Sharp Decline After First Month- Every cohort starts at 100% retention in its first purchase month.

- Significant drop occurs in Month 2, where retention falls below 10% across multiple cohorts.

###  Possible Cause: Lack of follow-up engagement after the first purchase.

- Fluctuations in Later Months- Retention percentages vary between 6% and 11% in the following months.

- Some months see slight growth (Month 4 and Month 10 in certain cohorts), suggesting some delayed repeat purchases.

### Opportunity: Retarget inactive customers after a few months with personalized incentives.

- Stronger Retention Among Middle Cohorts- Cohorts 5–8 have slightly higher repeat percentages over time.

- These customers may be more engaged or satisfied with the service.

- Strategy: Identify characteristics of these high-retention customers and replicate engagement methods.















