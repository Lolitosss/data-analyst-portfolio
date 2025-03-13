SELECT
  CASE 
    WHEN BPM <= 60 THEN 'Slow (<=60)'
    WHEN BPM BETWEEN 61 AND 120 THEN 'Moderate (61-120)'
    WHEN BPM > 120 THEN 'Fast (>120)'
  END AS bpm_category,
  AVG(Anxiety) AS avg_anxiety,
  AVG(Depression) AS avg_depression,
  AVG(Insomnia) AS avg_insomnia,
  AVG(OCD) AS avg_OCD
FROM
 `music-and-mental-health-data.music_health_analysis.music_health_analysis`
GROUP BY
  bpm_category
ORDER BY
  bpm_category;
