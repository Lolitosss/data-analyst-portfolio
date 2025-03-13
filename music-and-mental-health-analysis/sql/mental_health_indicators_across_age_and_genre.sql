SELECT
  Age_Range,
  Fav_genre,
  AVG(Anxiety) AS avg_anxiety,
  AVG(Depression) AS avg_depression,
  AVG(Insomnia) AS avg_insomnia,
  AVG(OCD) AS avg_OCD
FROM
 `music-and-mental-health-data.music_health_analysis.music_health_analysis`
GROUP BY
  Fav_genre, Age_Range
ORDER BY
  Age_Range;