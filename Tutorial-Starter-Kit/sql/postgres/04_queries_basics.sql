-- 04_queries_basics.sql (PostgreSQL)
SET search_path = mpd, public;

-- 1) Counts
SELECT COUNT(*) AS n_subscribers FROM subscribers;
SELECT COUNT(*) AS n_towers FROM towers;
SELECT COUNT(*) AS n_events FROM cdr_events;

-- 2) Simple filters
SELECT * FROM cdr_events ORDER BY event_ts DESC LIMIT 10;

-- 3) Aggregation: events by type
SELECT event_type, COUNT(*) AS n
FROM cdr_events
GROUP BY event_type
ORDER BY n DESC;

-- 4) Top 5 busiest towers overall
SELECT c.tower_id, t.regency, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY c.tower_id, t.regency
ORDER BY n DESC
LIMIT 5;

-- 5) Events by regency and day
SELECT t.regency, DATE(event_ts) AS d, COUNT(*) AS n
FROM cdr_events c
JOIN towers t ON t.tower_id = c.tower_id
GROUP BY t.regency, DATE(event_ts)
ORDER BY t.regency, d;
