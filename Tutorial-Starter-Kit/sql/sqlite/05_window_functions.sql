-- 05_window_functions.sql (SQLite)
-- Usual environment: most frequent night-time tower per subscriber (22:00-06:00)
WITH night_events AS (
  SELECT * FROM cdr_events
  WHERE CAST(substr(event_ts, 12, 2) AS INT) >= 22 OR CAST(substr(event_ts, 12, 2) AS INT) < 6
),
counts AS (
  SELECT subscriber_id, tower_id, COUNT(*) AS n
  FROM night_events
  GROUP BY subscriber_id, tower_id
),
ranked AS (
  SELECT c1.*,
        (SELECT COUNT(*) + 1 FROM counts c2 WHERE c2.subscriber_id=c1.subscriber_id AND c2.n > c1.n) AS rnk
  FROM counts c1
)
SELECT subscriber_id, tower_id AS usual_night_tower, n
FROM ranked
WHERE rnk = 1
ORDER BY subscriber_id
LIMIT 50;
