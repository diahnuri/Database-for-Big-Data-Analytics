-- 06_window_functions.sql (PostgreSQL)
SET search_path = mpd, public;

-- 1) "Usual environment" proxy: most frequent night-time tower per subscriber
-- Night defined as 22:00-06:00
WITH night_events AS (
  SELECT c.*
  FROM cdr_events c
  WHERE EXTRACT(HOUR FROM c.event_ts) >= 22 OR EXTRACT(HOUR FROM c.event_ts) < 6
),
freq AS (
  SELECT subscriber_id, tower_id, COUNT(*) AS n,
         RANK() OVER (PARTITION BY subscriber_id ORDER BY COUNT(*) DESC) AS rnk
  FROM night_events
  GROUP BY subscriber_id, tower_id
)
SELECT f.subscriber_id, f.tower_id AS usual_night_tower, f.n
FROM freq f
WHERE f.rnk = 1
ORDER BY f.subscriber_id
LIMIT 50;

-- 2) 1-day moving event count per regency
WITH reg_day AS (
  SELECT t.regency, DATE(c.event_ts) AS d, COUNT(*) AS n
  FROM cdr_events c
  JOIN towers t ON t.tower_id = c.tower_id
  GROUP BY t.regency, DATE(c.event_ts)
)
SELECT regency, d, n,
       AVG(n) OVER (PARTITION BY regency ORDER BY d ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS mv_avg_3day
FROM reg_day
ORDER BY regency, d
LIMIT 200;
