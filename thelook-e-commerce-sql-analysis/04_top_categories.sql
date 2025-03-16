SELECT 
    category,  
    ROUND(SUM(total_sale), 2) AS total_revenue,  
    ROUND(SUM(retail_price * quantity), 2) AS total_cost,  
    ROUND(SUM(total_sale) - SUM(retail_price * quantity), 2) AS profit  
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY category  
ORDER BY profit DESC;
