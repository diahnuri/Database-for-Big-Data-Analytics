-- 05_queries_intermediate.sql (PostgreSQL)
SET search_path = mpd, public;

-- 1) Join subscribers with events
SELECT s.home_regency, COUNT(*) AS n_events
FROM cdr_events c
JOIN subscribers s ON s.subscriber_id = c.subscriber_id
GROUP BY s.home_regency
ORDER BY n_events DESC;

-- 2) Top-3 towers by regency (using DISTINCT ON + ORDER BY)
WITH counts AS (
  SELECT t.regency, c.tower_id, COUNT(*) AS n
  FROM cdr_events c
  JOIN towers t ON t.tower_id = c.tower_id
  GROUP BY t.regency, c.tower_id
)
SELECT DISTINCT ON (regency) regency, tower_id, n
FROM counts
ORDER BY regency, n DESC;

-- 3) Subscribers active during a tourism event window (e.g., Ubud Arts Fair)
SELECT DISTINCT c.subscriber_id
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
JOIN tourism_events e ON e.regency = t.regency
WHERE e.event_name = 'Ubud Arts Fair'
  AND c.event_ts::date BETWEEN e.start_date AND e.end_date
ORDER BY c.subscriber_id
LIMIT 20;

-- 4) Travel detection (simple heuristic): events outside home_regency
SELECT s.subscriber_id,
       SUM(CASE WHEN t.regency <> s.home_regency THEN 1 ELSE 0 END) AS events_outside_home,
       COUNT(*) AS total_events
FROM cdr_events c
JOIN subscribers s ON s.subscriber_id = c.subscriber_id
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY s.subscriber_id
ORDER BY events_outside_home DESC
LIMIT 20;
