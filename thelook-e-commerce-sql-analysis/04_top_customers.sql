SELECT 
    user_id,
    SUM(sale_price * quantity) AS total_purchase_value
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS s
GROUP BY user_id
ORDER BY total_purchase_value DESC
LIMIT 10;

SELECT 
    user_id,  
    COUNT(order_id) AS total_orders,  
    ROUND(SUM(total_sale), 2) AS total_spent  
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY user_id  
ORDER BY total_spent DESC  
LIMIT 10;
