-- Top products by total sales
SELECT 
    product_name,
    SUM(sale_price * quantity) AS total_sales
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS s
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
    product_name,  
    COUNT(order_id) AS times_sold,  
    ROUND(SUM(total_sale), 2) AS total_revenue  
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY product_name  
ORDER BY total_revenue DESC  
LIMIT 10;

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