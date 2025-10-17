-- 02_load_data.sql (PostgreSQL)
SET search_path = mpd, public;

-- Use \copy from psql so paths are client-side relative
\copy towers FROM 'data/towers.csv' CSV HEADER
\copy subscribers FROM '/Users/sitimariyah/Documents/Regional Hub on Big Data and Data Science for the Asia and the Pacific/MPD Short Course Database for Big Data Analytics/mpd_db_course_starter_kit/data/subscribers.csv' CSV HEADER
\copy cdr_events FROM '/Users/sitimariyah/Documents/Regional Hub on Big Data and Data Science for the Asia and the Pacific/MPD Short Course Database for Big Data Analytics/mpd_db_course_starter_kit/data/cdr_events.csv' CSV HEADER
\copy tourism_events FROM '/Users/sitimariyah/Documents/Regional Hub on Big Data and Data Science for the Asia and the Pacific/MPD Short Course Database for Big Data Analytics/mpd_db_course_starter_kit/data/tourism_events.csv' CSV HEADER
