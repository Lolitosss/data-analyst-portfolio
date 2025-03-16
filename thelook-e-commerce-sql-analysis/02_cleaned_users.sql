CREATE TABLE `data-analyst-portfolio-453701.thelook_cleaned.cleaned_users` AS
SELECT
  id,
  first_name,
  last_name,
  email,
  gender,
  age,
  country
FROM `bigquery-public-data.thelook_ecommerce.users`;
