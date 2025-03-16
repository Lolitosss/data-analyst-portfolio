SELECT * 
FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` 
WHERE sale_price < 0;

SELECT * 
FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_products` 
WHERE cost < 0 OR retail_price < 0;

SELECT * FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` LIMIT 10;  
SELECT * FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders` LIMIT 10;  
SELECT * FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` LIMIT 10;  
SELECT * FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_products` LIMIT 10;
