CREATE OR REPLACE TABLE `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS
SELECT *
FROM (
  SELECT *, 
         ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn
  FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users`
)
WHERE rn = 1;

SELECT o.user_id
FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_orders` AS o
LEFT JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS u
ON o.user_id = u.id
WHERE u.id IS NULL;

CREATE OR REPLACE TABLE `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` AS
SELECT o.*
FROM `data-analyst-portfolio-453701.thelook_cleaned.cleaned_order_items` AS o
JOIN `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS u
ON o.user_id = u.id;