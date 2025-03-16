# 📈 TheLook E-Commerce SQL Analysis

## 🌟 Project Overview

This project analyzes the [`thelook_ecommerce`](https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1sdata-analyst-portfolio-453701!2sthelook_cleaned) dataset from BigQuery, focusing on exploring **sales trends**, **customer behavior** and **product performance**. The goal is to demonstrate SQL skills, including joins, aggregations, window functions, and data cleaning.

## 🔍 Business Questions

### **Sales Trends**
1. How have sales trended over time (monthly)?
2. Which product categories generate the most and least revenue?
3. Which product categories are profitable

### **Customer Insights**
4. Who are the top customers by purchase volume?
5. What is the average order value by customer segment?

## 📊 SQL Query Plan

1. **Exploratory Data Analysis (EDA)**
   - Preview key tables like `users`, `orders`, `products`, and `order_items`.
   - Check for missing values and data consistency.

2. **Data Cleaning**
   - Identify and handle nulls or inconsistencies.

3. **Joins & Aggregations**
   - Join tables to analyze sales by product, category, and time.
   - Aggregate data to identify trends and patterns.

4. **Advanced SQL Techniques**
   - Use window functions to rank top customers and products.

5. **Final Summary Table**
   - Create a summary table for key business metrics.

## Dataset Overview

The dataset includes several key tables:

- **users**: Customer information (user_id, email, gender, location, etc.).
- **orders**: Order details, including order ID, created_at, and user_id.
- **order_items**: Items within an order, including product_id, quantity, and sale_price.
- **products**: Product details, including product_id, category, price

## 🧹 Data Cleaning

### Steps:

### 1. Null Values
We checked for and handled any missing values. If there were any, they were either replaced with appropriate defaults or removed.

### 2. Duplicates
We removed any duplicate entries from the dataset, especially focusing on `user_id` and `order_id` in the **orders** and **users** tables.

### 3. Data Standardization
We ensured the consistency of column data types and formats to avoid errors in further analysis. For example:
- Standardizing `created_at` format.
- Ensuring that all monetary values are numeric and rounded to two decimal places.

### Example SQL Query
```sql
-- Removing duplicates based on user_id and order_id
DELETE FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders`
WHERE (user_id, order_id) IN (
    SELECT user_id, order_id
    FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders`
    GROUP BY user_id, order_id
    HAVING COUNT(*) > 1
);
```
# 🚀 Key SQL Queries and Insights

## 1. **How Have Sales Trended Over Time (Monthly)?**

```sql
SELECT 
    FORMAT_TIMESTAMP('%Y-%m', order_date) AS month,
    ROUND(SUM(total_sale), 2) AS total_sales               
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY month                                      
ORDER BY month;                                    
```

### Insight:

- Sales have shown a **steady increase** over time, peaking at **$1,003,510 in March 2025**.  
- A significant jump occurred from **December 2024 ($787,984.09)** to **January 2025 ($879,757.96)**, possibly due to post-holiday sales.  

## 2. **Which Product Categories Generate the Most and Least Revenue?**

```sql
SELECT 
    p.name AS product_name, 
    ROUND(SUM(oi.sale_price * oi.quantity), 2) AS total_revenue, 
    SUM(oi.quantity) AS total_quantity_sold,
    RANK() OVER (ORDER BY SUM(oi.sale_price * oi.quantity) DESC) AS rank
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS oi
JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_products` AS p
    ON oi.product_id = p.id
GROUP BY p.name
ORDER BY total_revenue DESC;
```
###  Insight:
- **Darla** is the top-selling product with **$19,980** in total sales.  
- **Jackets and outerwear dominate the best-selling products**, indicating high seasonal demand or premium pricing.  
- **Nike and Air Jordan apparel** also perform well, hinting at strong brand loyalty among customers.
- **Indestructable Aluminum Aluma Wallet** got the lowest revenue.

## 3. **Which product categories are profitable?**
```sql
SELECT 
    p.category,  
    ROUND(SUM(oi.sale_price), 2) AS total_revenue,  
    ROUND(SUM(p.cost * oi.quantity), 2) AS total_cost,  
    ROUND(SUM(oi.sale_price) - SUM(p.cost * oi.quantity), 2) AS profit  
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS oi
JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_products` AS p 
    ON oi.product_id = p.id
GROUP BY p.category  
ORDER BY profit DESC;
```
### Insight:

- Outerwear & Coats, Suits & Sport Coats, and Accessories are profitable.

## 4. **Who Are the Top Customers by Purchase Volume?**
```sql
SELECT 
    user_id,  
    COUNT(order_id) AS total_orders,  
    ROUND(SUM(total_sale), 2) AS total_spent  
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY user_id  
ORDER BY total_spent DESC  
LIMIT 10;
```
###  Insight:

- The top-spending customer **(User 87587)** placed **4 orders**, totaling **$11,124** in spending.  
- The second and third top customers placed **11 and 8 orders**, spending around **$6,100 each**.  
- A small group of customers accounts for a large percentage of sales, highlighting an opportunity for **loyalty programs and personalized marketing**.

## 5. **What Is the Average Order Value by Customer Segment?**

```sql
SELECT 
    u.gender, 
    ROUND(AVG(o.total_sale), 2) AS avg_order_value
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS o
JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS u
    ON o.user_id = u.id
GROUP BY u.gender;
```
### Insight:

- **Male customers** have a higher average order value **($120.76)** than females ($105.87).
- Marketing strategies could focus on encouraging more spending among female customers.

## 5. **Which product categories are profitable?**

### Methods used:

#### **1. Data Aggregation**
- Performed aggregations using SQL functions like SUM(), AVG(), and COUNT() to summarize sales, customer spending, and product trends.

#### **2. Joins**
- Utilized SQL JOIN statements to combine data from multiple tables, ensuring comprehensive analysis across products, orders, and customer segments.

#### **3. Window Functions**
- Applied RANK() to identify top-selling products and high-spending customers.

### **5. Recommendations**  
- **Marketing:** Introduce loyalty programs, especially for top customers, and consider targeted campaigns to boost female customer spending.  
- **Product Strategy:** Reassess underperforming products. Consider discounts, marketing adjustments, or phasing out consistently low-performing items.  
- **Customer Engagement:** Utilize personalized offers to engage high-value customers and encourage repeat purchases.
