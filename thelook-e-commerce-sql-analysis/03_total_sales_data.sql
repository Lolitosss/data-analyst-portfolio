CREATE OR REPLACE TABLE `data-analyst-portfolio-453701.thelook_cleaned.sales_data` AS 

-- Selecting the columns we want for our final table
SELECT 
    o.order_id AS order_id,                
    o.user_id,                       
    oi.id AS order_item_id,          
    oi.product_id,                    
    p.category,                      
    p.name AS product_name,           
    p.retail_price,                   
    oi.sale_price,                   
    o.num_of_item AS quantity,       
    (oi.sale_price * o.num_of_item) AS total_sale, -- Calculating total sale (sale price * quantity)
    o.created_at AS order_date      
     
FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders` AS o

JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` AS oi
    ON o.order_id = oi.order_id

JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_products` AS p
    ON oi.product_id = p.id;
