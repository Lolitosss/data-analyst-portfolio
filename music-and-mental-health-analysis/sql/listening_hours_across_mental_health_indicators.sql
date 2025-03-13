SELECT
  CASE 
    WHEN Hours_per_day <= 1 THEN 'Low (<= 1 hour)'
    WHEN Hours_per_day BETWEEN 2 AND 4 THEN 'Moderate (2-4 hours)'
    ELSE 'High (> 4 hours)'
  END AS listening_category,
  AVG(Anxiety) AS avg_anxiety,
  AVG(Depression) AS avg_depression,
  AVG(Insomnia) AS avg_insomnia,
  AVG(OCD) AS avg_OCD,
  COUNT(*) AS respondent_count
FROM
  `music-and-mental-health-data.music_health_analysis.music_health_analysis`
GROUP BY
  listening_category
HAVING
  COUNT(*) > 10
ORDER BY
  listening_category;