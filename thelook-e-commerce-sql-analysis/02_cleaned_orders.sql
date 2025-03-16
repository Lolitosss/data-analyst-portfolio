CREATE TABLE `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders` AS
SELECT
  order_id,
  user_id,
  status,
  gender,
  created_at,
  num_of_item
FROM `bigquery-public-data.thelook_ecommerce.orders`;
