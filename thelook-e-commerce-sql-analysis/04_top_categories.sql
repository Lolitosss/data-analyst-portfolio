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