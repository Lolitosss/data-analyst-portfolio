CREATE TABLE `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` AS
SELECT
  id,
  order_id,
  user_id,
  product_id,
  status,
  created_at,
  sale_price
FROM `bigquery-public-data.thelook_ecommerce.order_items`;