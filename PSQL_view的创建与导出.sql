CREATE OR REPLACE VIEW combied_downsampling
 AS
 SELECT
    rtm_leadbackice_d_n.rec_bs_id,
    rtm_leadbackice_d_n.rec_update_time,
    rtm_leadbackice_d_n.rec_phase,
    rtm_leadbackice_d_n.rec_ice_height,
    rtm_weather_d_n.rec_temperature,
    rtm_weather_d_n.rec_humidity,
    rtm_weather_d_n.rec_wind_speed,
	rtm_weather_d_n.rec_wind_direction
   FROM rtm_leadbackice_d_n
     LEFT JOIN rtm_weather_d_n ON rtm_leadbackice_d_n.rec_bs_id = rtm_weather_d_n.rec_bs_id
	 AND rtm_leadbackice_d_n.rec_update_time = rtm_weather_d_n.rec_update_time
	 ORDER by rec_bs_id,rec_phase,rec_update_time;
--
copy (SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER() AS rn
    FROM combied_downsampling
    WHERE rec_phase = 'A相') AS subquery
    WHERE rn % 6 = 0
    order by rec_bs_id,rec_update_time
)TO '/mnt/M8T/south_data/downsampling/Phase_A.csv' DELIMITER ',' CSV HEADER;
