SELECT 
    FORMAT_TIMESTAMP('%Y-%m', order_date) AS month,
    ROUND(SUM(total_sale), 2) AS total_sales               
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data`
GROUP BY month                                      
ORDER BY month;                                    
