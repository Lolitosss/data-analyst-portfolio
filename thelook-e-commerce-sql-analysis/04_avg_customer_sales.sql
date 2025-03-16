SELECT 
    u.gender, 
    ROUND(AVG(o.total_sale), 2) AS avg_order_value
FROM `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS o
JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS u
    ON o.user_id = u.id
GROUP BY u.gender;