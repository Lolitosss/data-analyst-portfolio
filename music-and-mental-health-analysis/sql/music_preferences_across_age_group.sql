SELECT
    Age_Range,
    AVG(Classical) AS avg_classical,
    AVG(Country) AS avg_country,
    AVG(EDM) AS avg_edm,
    AVG(Folk) AS avg_folk,
    AVG(Hip_hop) AS avg_hip_hop,
    AVG(Jazz) AS avg_jazz,
    AVG(K_pop) AS avg_k_pop,  
    AVG(Latin) AS avg_latin,  
    AVG(Lofi) AS avg_lofi, 
    AVG(Metal) AS avg_metal,
    AVG(Pop) AS avg_pop,
    AVG(R_B) AS avg_r_b,
    AVG(Rap) AS avg_rap,  
    AVG(Rock) AS avg_rock,
    AVG(Video_game_music) AS avg_video_game_music
  FROM
    `music-and-mental-health-data.music_health_analysis.music_health_analysis`
  GROUP BY
    Age_Range
  ORDER BY
    Age_Range;